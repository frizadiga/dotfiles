// ==UserScript==
// @name         TradingView - Esc Stays in Draw Mode
// @namespace    tv-esc-custom-behavior-draw-mode
// @version      1.0.0
// @author       Frizadiga
// @description  When a drawing tool is active, Esc exits the tool instead of exiting Workspace-only mode.
// @match        https://www.tradingview.com/chart/*
// @match        https://*.tradingview.com/chart/*
// @run-at       document-start
// @grant        none
// @updateURL    https://raw.githubusercontent.com/frizadiga/dotfiles/main/tampermonkey/tv-esc-custom-behavior-draw-mode.user.js
// @downloadURL  https://raw.githubusercontent.com/frizadiga/dotfiles/main/tampermonkey/tv-esc-custom-behavior-draw-mode.user.js
// ==/UserScript==

(function () {
  'use strict';

  function isRealDrawingToolActive() {
    const pressed = document.querySelectorAll('[aria-pressed="true"]');

    for (const el of pressed) {
      // Skip the cursor/arrow tool button (class contains "arrow-")
      if (el.className.includes('arrow-')) continue;
      // Skip the favorites dropdown toggle
      if (el.id === 'drawing-toolbar-favorite-drawings') continue;
      return true; // anything else pressed = a real drawing tool is active
    }

    return false;
  }

  function switchToCursorTool() {
    const arrowBtn = document.querySelector('button[class*="arrow-"]');
    if (arrowBtn) arrowBtn.click();
  }

  function isElementVisible(el) {
    if (!el || !el.isConnected) return false;
    if (el.getClientRects().length === 0) return false;
    const style = window.getComputedStyle(el);
    return style.display !== 'none' && style.visibility !== 'hidden';
  }

  function isSymbolSearchOpen() {
    const dialog = document.querySelector(
      '[data-name="symbol-search-items-dialog"], [data-dialog-name="Symbol search"]'
    );
    if (isElementVisible(dialog)) return true;

    const active = document.activeElement;
    return !!(
      active &&
      typeof active.closest === 'function' &&
      active.closest('[data-name="symbol-search-items-dialog"]')
    );
  }

  window.addEventListener(
    'keydown',
    function (e) {
      if (e.key !== 'Escape') return;
      if (isSymbolSearchOpen()) return; // let native Esc dismiss the Symbol Search popup
      if (!isRealDrawingToolActive()) return; // let normal Esc (exit workspace) happen

      e.stopImmediatePropagation();
      e.stopPropagation();
      e.preventDefault();
      switchToCursorTool();
    },
    true
  );
})();
