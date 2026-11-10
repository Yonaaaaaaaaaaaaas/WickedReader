# Spike 4: PDF.js and epub.js inside Electron

Steps (in `ui/`): `npm init -y`, `npm i --save-exact pdfjs-dist epubjs`, copy the viewer bundles into `ui/vendor/`,
load `testlib/files/pdf-small-text.pdf` and `epub3-basic.epub` through the loopback service URL, confirm text layer, TOC and page turns.
Record exact versions and the Electron/Chromium version below. If epub.js shows problems with Chromium 156, evaluate a maintained fork before Sprint 5.

| Item | Result |
|---|---|
| pdfjs-dist version | _fill in_ |
| epubjs version | _fill in_ |
| Electron / Chromium | 45.2.3 / 156 (planned) |
| PDF renders with selectable text | _pass/fail_ |
| EPUB 2 and 3 render, TOC works | _pass/fail_ |
