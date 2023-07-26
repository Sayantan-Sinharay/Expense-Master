$(document).ready(function () {
    $("[data-tooltip]").hover(function () {
        $(this)
            .parent()
            .find(".tooltip-text")
            .toggleClass("opacity-100 pointer-events-auto");
    });
});
