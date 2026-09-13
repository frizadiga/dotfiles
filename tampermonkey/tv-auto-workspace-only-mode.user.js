// ==UserScript==
// @name         TradingView Auto Workspace-Only Mode
// @match        https://www.tradingview.com/chart/*
// @namespace    http://tampermonkey.net/
// @version      2026-09-11
// @description  Automatically switches the TradingView chart to workspace-only (fullscreen) mode via Shift+F once the chart loads.
// @run-at       document-idle
// @updateURL    https://raw.githubusercontent.com/frizadiga/dotfiles/main/tampermonkey/tv-auto-workspace-only-mode.user.js
// @downloadURL  https://raw.githubusercontent.com/frizadiga/dotfiles/main/tampermonkey/tv-auto-workspace-only-mode.user.js
// ==/UserScript==

(function () {
  let triggered = false;

  function simulateShiftF() {
    if (triggered) return;
    triggered = true;

    const target = document.activeElement || document.body;
    const opts = {
      key: 'F',
      code: 'KeyF',
      keyCode: 70,
      which: 70,
      shiftKey: true,
      bubbles: true,
      cancelable: true,
    };
    target.dispatchEvent(new KeyboardEvent('keydown', opts));
    target.dispatchEvent(new KeyboardEvent('keyup', opts));
  }

  const observer = new MutationObserver(() => {
    const chartReady = document.querySelector('.chart-container, [class*="chart-widget"]');
    if (chartReady) {
      observer.disconnect();
      setTimeout(simulateShiftF, 1500);
    }
  });

  observer.observe(document.body, { childList: true, subtree: true });

  // Fallback only runs if the observer path never fired at all
  setTimeout(simulateShiftF, 5000);
})();
