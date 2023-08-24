$(document).ready(function () {
  $("[data-tooltip]")
    .mouseenter(function () {
      $(this)
        .parent()
        .find(".tooltip-text")
        .addClass("opacity-100 pointer-events-auto");
    })
    .mouseleave(function () {
      $(this)
        .parent()
        .find(".tooltip-text")
        .removeClass("opacity-100 pointer-events-auto");
    });
});
