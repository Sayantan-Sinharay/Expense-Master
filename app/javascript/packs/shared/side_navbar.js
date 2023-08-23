$(document).ready(function () {
    var currentPath = window.location.pathname;

    $(".panel-block").each(function () {
        var linkPath = $(this).attr("href");

        // Add "active" class to the link if its path matches the current path
        if (linkPath === currentPath) {
            $(this).addClass("is-active text-primary font-bold");
        }
    });
});
