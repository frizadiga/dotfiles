// ==UserScript==
// @name         TradingView - Esc Stays in Draw Mode
// @namespace    tv-esc-custom-behavior-draw-mode
// @version      2026.09.18.020253
// @author       Frizadiga
// @description  When a drawing tool is active, Esc exits the tool instead of exiting Workspace-only mode. Symbol Search (and text inputs) are excluded so Esc dismisses those first.
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

  const SYMBOL_SEARCH_SELECTORS = [
    '[data-name*="symbol-search"]',
    '[data-dialog-name*="symbol search" i]',
    '[data-role*="symbol-search"]',
    '[class*="tv-symbol-search-dialog"]',
    '[class*="symbolSearch"]',
  ];

  function isSymbolSearchOpen() {
    for (const sel of SYMBOL_SEARCH_SELECTORS) {
      for (const el of document.querySelectorAll(sel)) {
        if (isElementVisible(el) && el.getAttribute('aria-hidden') !== 'true') {
          return true;
        }
      }
    }

    const active = document.activeElement;
    if (active && typeof active.closest === 'function') {
      for (const sel of SYMBOL_SEARCH_SELECTORS) {
        if (active.closest(sel)) return true;
      }
    }
    return false;
  }

  function isEditableElement(target) {
    if (!target || typeof target.tagName !== 'string') return false;
    if (target.isContentEditable) return true;
    const tag = target.tagName;
    if (tag === 'TEXTAREA' || tag === 'SELECT') return true;
    if (tag === 'INPUT') {
      const type = (target.getAttribute('type') || 'text').toLowerCase();
      return !['button', 'checkbox', 'color', 'file', 'hidden', 'image', 'radio', 'range', 'reset', 'submit'].includes(type);
    }
    return false;
  }

  window.addEventListener(
    'keydown',
    function (e) {
      if (e.key !== 'Escape') return;
      if (isEditableElement(e.target)) return; // typing in a text field (e.g. Symbol Search input)
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
