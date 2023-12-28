import "src/decidim/iframe-resizer/iframeResizer.min.js"

document.addEventListener("DOMContentLoaded", function() {
  window.iFrameResize({
    log: true
  }, "#iFrame");
});
