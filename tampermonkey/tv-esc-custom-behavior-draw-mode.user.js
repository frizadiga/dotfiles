// ==UserScript==
// @name         TradingView - Esc Stays in Draw Mode
// @namespace    tv-esc-custom-behavior-draw-mode
// @version      2026.09.20.001300
// @author       Frizadiga
// @description  When a drawing tool is active, Esc exits the tool instead of exiting Workspace-only mode (typing in a drawing's text still exits the tool). Symbol Search is excluded so Esc dismisses it first.
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

  function isToolSearchOpen() {
    const el = document.querySelector('[data-dialog-name="Search tool or function"]');
    return el && isElementVisible(el) && el.getAttribute('aria-hidden') !== 'true';
  }

  window.addEventListener(
    'keydown',
    function (e) {
      if (e.key !== 'Escape') return;
      if (isToolSearchOpen()) return; // let native Esc dismiss the tool search popup first
      if (isSymbolSearchOpen()) return; // let native Esc dismiss the Symbol Search popup first
      if (!isRealDrawingToolActive()) return; // no drawing tool active: let native Esc run (typing in plain inputs, exit Workspace-only, etc.)
      // A real drawing tool IS active, even if focus sits in its text/label box:
      // deactivate the tool instead of letting TV exit Workspace-only mode.
      e.stopImmediatePropagation();
      e.stopPropagation();
      e.preventDefault();
      switchToCursorTool();
    },
    true
  );
})();
