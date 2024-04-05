$(() => {
  const $resizeIframeLabel = $("label[for='component_settings_resize_iframe']")
  const $iFrameSelect = $("#component_settings_resize_iframe")
  const $heightContainer = $(".height_container")
  $heightContainer.addClass("mt-2")
  const $heightInput = $("#component_settings_height")

  const toggleHeightContainerVisibility = function() {
    if ($iFrameSelect.val() === "responsive") {
      $heightInput.val("");
      $heightContainer.hide();
    } else if ($iFrameSelect.val() === "manual") {
      $heightContainer.show();
    }
  };

  $heightContainer.detach().appendTo($resizeIframeLabel)

  toggleHeightContainerVisibility()


  $iFrameSelect.on("change", () => {
    toggleHeightContainerVisibility()
  })
})
