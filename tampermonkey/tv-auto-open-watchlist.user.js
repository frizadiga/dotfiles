// ==UserScript==
// @name         TradingView Auto Open Watchlist (Cmd/Ctrl+K)
// @namespace    http://tampermonkey.net/
// @version      1.0.1
// @author       Frizadiga
// @description  Opens the command palette and selects "open watchlist" only on one specific chart
// @match        https://www.tradingview.com/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// @updateURL    https://raw.githubusercontent.com/frizadiga/dotfiles/main/tampermonkey/tv-auto-open-watchlist.user.js
// @downloadURL  https://raw.githubusercontent.com/frizadiga/dotfiles/main/tampermonkey/tv-auto-open-watchlist.user.js
// ==/UserScript==

(function () {
  'use strict';

  // Only run the watchlist procedure on this exact chart + symbol
  const isTargetChart = location.pathname === '/chart/PIvKxujq/'
    && new URLSearchParams(location.search).get('symbol') === 'FRED:WALCL';

  if (!isTargetChart) {
    return; // any other chart or symbol — do nothing
  }

  function detectIsMac() {
    // navigator.platform is deprecated. Prefer the newer Client Hints API
    // (Chrome/Edge), falling back to userAgent sniffing (works everywhere,
    // including Firefox-based browsers like Zen, which don't support
    // userAgentData at all).
    if (navigator.userAgentData && typeof navigator.userAgentData.platform === 'string') {
      return navigator.userAgentData.platform.toUpperCase().includes('MAC');
    }
    return /MAC/i.test(navigator.userAgent);
  }

  const isMac = detectIsMac();

  function fireKey(target, opts) {
    target.dispatchEvent(new KeyboardEvent('keydown', opts));
    target.dispatchEvent(new KeyboardEvent('keyup', opts));
  }

  function setNativeValue(input, value) {
    const setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
    setter.call(input, value);
    input.dispatchEvent(new Event('input', { bubbles: true }));
  }

  function waitFor(conditionFn, timeout = 5000, interval = 100) {
    return new Promise((resolve, reject) => {
      const start = Date.now();
      const timer = setInterval(() => {
        const result = conditionFn();
        if (result) {
          clearInterval(timer);
          resolve(result);
        } else if (Date.now() - start > timeout) {
          clearInterval(timer);
          reject(new Error('timeout waiting for condition'));
        }
      }, interval);
    });
  }

  async function run() {
    await waitFor(() => document.querySelector('.chart-container, [class*="chart-widget"]'), 8000).catch(() => {});
    await new Promise(r => setTimeout(r, 1500));

    fireKey(document.body, {
      key: 'k',
      code: 'KeyK',
      keyCode: 75,
      which: 75,
      bubbles: true,
      cancelable: true,
      ctrlKey: !isMac,
      metaKey: isMac,
    });

    let input;
    try {
      input = await waitFor(() => {
        const el = document.activeElement;
        return el && el.tagName === 'INPUT' ? el : null;
      }, 3000);
    } catch (e) {
      console.log('[TM] Command palette input not found — selector/timing may need adjusting');
      return;
    }

    setNativeValue(input, 'open watchlist');
    await new Promise(r => setTimeout(r, 900));

    fireKey(input, { key: 'ArrowDown', code: 'ArrowDown', keyCode: 40, which: 40, bubbles: true, cancelable: true });
    await new Promise(r => setTimeout(r, 300));

    fireKey(input, { key: 'Enter', code: 'Enter', keyCode: 13, which: 13, bubbles: true, cancelable: true });
  }

  run();
})();
