$(() => {
  const $contentHeightLabel = $("label[for='component_settings_content_height']")
  const $contentHeightSelect = $("#component_settings_content_height")
  const $heightContainer = $(".height_value_container")
  const $heightInput = $("#component_settings_height_value")
  const $heightHelp = $(".content_height_container .help-text")

  const toggleHeightValueContainerVisibility = function() {
    if ($contentHeightSelect.val() === "manual_pixel") {
      $heightContainer.show();
    } else {
      $heightInput.val("");
      $heightContainer.hide();
    }
  };

  const toggleHeightHelpVisibility = function() {
    if ($contentHeightSelect.val() === "auto") {
      $heightHelp.show();
    } else {
      $heightHelp.hide();
    }
  };

  $heightContainer.detach().appendTo($contentHeightLabel)

  toggleHeightValueContainerVisibility()
  toggleHeightHelpVisibility()


  $contentHeightSelect.on("change", () => {
    toggleHeightValueContainerVisibility()
    toggleHeightHelpVisibility()
  })
})
