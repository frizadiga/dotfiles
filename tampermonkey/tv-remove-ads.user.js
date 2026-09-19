// ==UserScript==
// @name         TradingView - Remove Ads
// @namespace    tv-remove-ads
// @version      2026.09.19.031041
// @author       Frizadiga
// @description  Removes Google ActiveView ad modals that TradingView injects.
// @match        https://www.tradingview.com/*
// @match        https://*.tradingview.com/*
// @run-at       document-start
// @grant        none
// @updateURL    https://raw.githubusercontent.com/frizadiga/dotfiles/main/tampermonkey/tv-remove-ads.user.js
// @downloadURL  https://raw.githubusercontent.com/frizadiga/dotfiles/main/tampermonkey/tv-remove-ads.user.js
// ==/UserScript==

(function () {
  'use strict';

  function removeAds() {
    for (const el of document.querySelectorAll('#charting-ad')) {
      el.remove();
    }
  }

  function watchForAds() {
    removeAds();
    new MutationObserver(removeAds).observe(document.documentElement, {
      childList: true,
      subtree: true,
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', watchForAds);
  } else {
    watchForAds();
  }
})();
