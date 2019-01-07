$(document).on("ready turbolinks:load", function() {
  $("#mass-message-select-all").on("click", function() {
    var elem = $(this);

    parentCheckboxes = $(".mass-message-parent-select");
    if (parentCheckboxes.prop("checked")) {
      elem.html("Select All");
      parentCheckboxes.prop("checked", false);
    } else {
      elem.html("Deselect All");
      parentCheckboxes.prop("checked", true);
    }
  });
});
