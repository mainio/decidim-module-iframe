import "src/decidim/admin/scope_picker_enabler.component"
import "src/decidim/admin/proposal_infinite_edit"
import "src/decidim/admin/content_height_toggler"
import "src/decidim/admin/content_width_toggler"

// Overwrite core form.js file to import content_width_toggler, content_height_toggler

import BudgetRuleTogglerComponent from "src/decidim/admin/budget_rule_toggler.component"

$(() => {
  const budgetRuleToggler = new BudgetRuleTogglerComponent({
    ruleCheckboxes: $("input[id^='component_settings_vote_rule_']")
  });

  budgetRuleToggler.run();

  const $readonlyContainer = $(".readonly_container input");

  $readonlyContainer.click((event) => {
    event.preventDefault();
    return false;
  });

  const $amendmentsEnabled = $("input#component_settings_amendments_enabled");

  if ($amendmentsEnabled.length > 0) {
    const $amendmentStepSettings = $(".amendments_wizard_help_text_container, .amendments_visibility_container, .amendment_creation_enabled_container, .amendment_reaction_enabled_container, .amendment_promotion_enabled_container");

    if ($amendmentsEnabled.is(":not(:checked)")) {
      $amendmentStepSettings.hide();
    }

    $amendmentsEnabled.click(() => {
      $amendmentStepSettings.toggle();
    });
  }
});
