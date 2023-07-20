$(document).ready(function () {
    $(".accordion-toggle").click(function () {
        var accordionItem = $(this).closest(".accordion-item");
        var accordionContent = accordionItem.find(".accordion-content");

        // Close other accordions
        $(".accordion-content").not(accordionContent).slideUp();
        $(".accordion-toggle")
            .not($(this))
            .removeClass("active")
            .find("i")
            .removeClass("fa-chevron-up")
            .addClass("fa-chevron-down");

        // Toggle current accordion
        accordionContent.slideToggle();
        $(this).toggleClass("active");
        $(this).find("i").toggleClass("fa-chevron-down fa-chevron-up");
    });
});
