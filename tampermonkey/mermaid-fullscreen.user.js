// ==UserScript==
// @name         Mermaid - Full Screen Diagrams
// @namespace    mermaid-fullscreen
// @version      2026.11.22.195626
// @author       Frizadiga
// @description  Adds a full screen button to each rendered Mermaid diagram in the local Markdown preview (gh markdown-preview, MdOpen).
// @match        http://localhost:3333/*
// @match        http://127.0.0.1:3333/*
// @run-at       document-idle
// @grant        none
// @updateURL    https://raw.githubusercontent.com/frizadiga/dotfiles/main/tampermonkey/mermaid-fullscreen.user.js
// @downloadURL  https://raw.githubusercontent.com/frizadiga/dotfiles/main/tampermonkey/mermaid-fullscreen.user.js
// ==/UserScript==

// Also works as a bookmarklet (`make bookmarklet`) and is safe to load twice.
// Full screen view: wheel = zoom at cursor, drag = pan, double-click or F = fit, Esc = close.
(function () {
  if (window.__mermaidFullscreen) { window.__mermaidFullscreen.scan(); return; }

  var css = [
    '.mmd-fs-host{position:relative}',
    '.mmd-fs-btn{position:absolute;top:8px;right:8px;z-index:2;font:13px/1 system-ui,sans-serif;padding:5px 8px;',
    'border-radius:6px;border:1px solid rgba(128,128,128,.45);background:rgba(128,128,128,.15);color:inherit;',
    'cursor:pointer;opacity:.55;transition:opacity .15s}',
    '.mmd-fs-host:hover .mmd-fs-btn,.mmd-fs-btn:focus{opacity:1}',
    // gh markdown-preview puts a 28px copy button at top:8px right:8px; sit to its left
    '.mmd-fs-host:has(> .copy-button) .mmd-fs-btn{right:44px}',
    '.mmd-fs{position:fixed;inset:0;z-index:2147483647;display:flex;flex-direction:column}',
    '.mmd-fs-bar{display:flex;gap:8px;justify-content:flex-end;align-items:center;padding:8px 12px;font:12px system-ui,sans-serif;opacity:.8}',
    '.mmd-fs-bar span{flex:1;opacity:.7}',
    '.mmd-fs-bar button{font:13px system-ui,sans-serif;padding:5px 10px;border-radius:6px;cursor:pointer;',
    'border:1px solid rgba(128,128,128,.45);background:rgba(128,128,128,.15);color:inherit}',
    '.mmd-fs-stage{flex:1;overflow:hidden;cursor:grab;position:relative}',
    '.mmd-fs-stage.dragging{cursor:grabbing}',
    '.mmd-fs-stage svg{position:absolute;inset:0;width:100%!important;height:100%!important;max-width:none!important;transform-origin:0 0}'
  ].join('');
  var style = document.createElement('style');
  style.textContent = css;
  document.head.appendChild(style);

  function pageColors() {
    var b = getComputedStyle(document.body);
    var bg = b.backgroundColor;
    if (!bg || bg === 'transparent' || bg === 'rgba(0, 0, 0, 0)') bg = getComputedStyle(document.documentElement).backgroundColor;
    if (!bg || bg === 'transparent' || bg === 'rgba(0, 0, 0, 0)') bg = '#fff';
    return { bg: bg, fg: b.color };
  }

  function open(svg) {
    var c = pageColors();
    var overlay = document.createElement('div');
    overlay.className = 'mmd-fs';
    overlay.style.background = c.bg;
    overlay.style.color = c.fg;
    overlay.innerHTML = '<div class="mmd-fs-bar"><span>wheel: zoom · drag: pan · F / double-click: fit · Esc: close</span>' +
      '<button type="button" data-a="fit">Fit</button><button type="button" data-a="close">Close ✕</button></div>' +
      '<div class="mmd-fs-stage"></div>';
    var stage = overlay.querySelector('.mmd-fs-stage');
    var clone = svg.cloneNode(true);
    clone.removeAttribute('width');
    clone.removeAttribute('height');
    clone.style.maxWidth = 'none';
    stage.appendChild(clone);
    document.body.appendChild(overlay);

    var s = 1, x = 0, y = 0;
    function apply() { clone.style.transform = 'translate(' + x + 'px,' + y + 'px) scale(' + s + ')'; }
    function fit() { s = 1; x = 0; y = 0; apply(); }

    stage.addEventListener('wheel', function (e) {
      e.preventDefault();
      var r = stage.getBoundingClientRect();
      var mx = e.clientX - r.left, my = e.clientY - r.top;
      var ns = Math.min(20, Math.max(0.2, s * Math.exp(-e.deltaY * 0.0015)));
      x = mx - (mx - x) * (ns / s);
      y = my - (my - y) * (ns / s);
      s = ns;
      apply();
    }, { passive: false });

    var drag = null;
    stage.addEventListener('pointerdown', function (e) {
      drag = { px: e.clientX, py: e.clientY, x: x, y: y };
      stage.setPointerCapture(e.pointerId);
      stage.classList.add('dragging');
    });
    stage.addEventListener('pointermove', function (e) {
      if (!drag) return;
      x = drag.x + e.clientX - drag.px;
      y = drag.y + e.clientY - drag.py;
      apply();
    });
    function endDrag() { drag = null; stage.classList.remove('dragging'); }
    stage.addEventListener('pointerup', endDrag);
    stage.addEventListener('pointercancel', endDrag);
    stage.addEventListener('dblclick', fit);

    function close() {
      document.removeEventListener('keydown', onKey, true);
      document.removeEventListener('fullscreenchange', onFs);
      if (document.fullscreenElement === overlay && document.exitFullscreen) document.exitFullscreen().catch(function () {});
      overlay.remove();
    }
    function onKey(e) {
      if (e.key === 'Escape') { e.preventDefault(); close(); }
      else if (e.key === 'f' || e.key === 'F') { e.preventDefault(); fit(); }
    }
    function onFs() { if (!document.fullscreenElement) close(); }
    overlay.querySelector('[data-a="fit"]').addEventListener('click', fit);
    overlay.querySelector('[data-a="close"]').addEventListener('click', close);
    document.addEventListener('keydown', onKey, true);

    // Real full screen when allowed; the overlay already fills the window if not.
    if (overlay.requestFullscreen) {
      overlay.requestFullscreen().then(function () {
        document.addEventListener('fullscreenchange', onFs);
      }).catch(function () {});
    }
  }

  function scan() {
    document.querySelectorAll('svg[aria-roledescription]').forEach(function (svg) {
      if (svg.closest('.mmd-fs')) return;
      var host = svg.parentElement;
      if (!host || host.querySelector(':scope > .mmd-fs-btn')) return;
      host.classList.add('mmd-fs-host');
      var btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'mmd-fs-btn';
      btn.title = 'Full screen';
      btn.textContent = '⛶';
      btn.addEventListener('click', function (e) {
        e.preventDefault();
        e.stopPropagation();
        var current = host.querySelector(':scope > svg[aria-roledescription]');
        if (current) open(current);
      });
      host.appendChild(btn);
    });
  }

  // Previews re-render diagrams (live reload, theme toggles), so keep adding buttons.
  var timer = null;
  new MutationObserver(function () {
    clearTimeout(timer);
    timer = setTimeout(scan, 150);
  }).observe(document.body, { childList: true, subtree: true });

  window.__mermaidFullscreen = { scan: scan };
  scan();
})();
