// ==UserScript==
// @name         Lighter DEX
// @namespace    http://tampermonkey.net/
// @version      2026.09.18.020253
// @author       Frizadiga
// @description  Lighter Custom View Modifier
// @match        https://app.lighter.xyz/trade/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        GM_addStyle
// @updateURL    https://raw.githubusercontent.com/frizadiga/dotfiles/main/tampermonkey/lighter-custom-view.user.js
// @downloadURL  https://raw.githubusercontent.com/frizadiga/dotfiles/main/tampermonkey/lighter-custom-view.user.js
// ==/UserScript==

(function() {
    'use strict';

    GM_addStyle(`
html, body {
  overflow: hidden !important;
  max-width: 100vw !important;
}

/* sell/buy button */
#place-order button:is(
  #place-order-button,
  .w-full[disabled],
  [data-testid="order-panel-close-position-button"],
  [data-testid="modify-entire-position-submit-button"]
)
{
  bottom: 8px !important;
  position: absolute !important;
  right: 0;
  left: 0;
  width: calc(100% - (2 * 8px));
  margin: 2px auto;
}

/* bottom section trade positions tabs */
div.react-grid-item.react-resizable-hide.react-resizable:nth-child(6) {
  max-width: 100vw;
  margin-top: 0px;
  border-radius: 0px;
}

/* button table columns in trade position tabs */
button#tableColumns {
  margin-right: 8px;
}

/* main wrapper */
div.react-grid-layout.w-full {
  max-height: calc(100vh - 83px);
  overflow: hidden;
}

/* combo box chart top right */
button[aria-haspopup="menu"] {
  max-width: 8ch;
}
    `);
})();
