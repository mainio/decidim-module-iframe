$(() => {
  const $contentWidthLabel = $("label[for='component_settings_content_width']")
  const $contentWidthSelect = $("#component_settings_content_width")
  const $widthContainer = $(".width_value_container")
  const $widthInput = $("#component_settings_width_value")

  const toggleWidthValueContainerVisibility = function() {
    if ($contentWidthSelect.val() === "manual_pixel" || $contentWidthSelect.val() === "manual_percentage") {
      $widthContainer.show();
    } else {
      $widthInput.val("");
      $widthContainer.hide();
    }
  };

  $widthContainer.detach().appendTo($contentWidthLabel)

  toggleWidthValueContainerVisibility()


  $contentWidthSelect.on("change", () => {
    toggleWidthValueContainerVisibility()
  })
})
