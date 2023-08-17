$(document).ready(function () {
    $(".accordion-toggle").click(function () {
        const accordionItem = $(this).closest(".accordion-item");
        const accordionContent = accordionItem.find(".accordion-content");

        // Close other accordions
        $(".accordion-content").not(accordionContent).slideUp();
        $(".accordion-toggle")
            .not($(this))
            .removeClass("active")
            .find("i")
            .removeClass("fa-chevron-up")
            .addClass("fa-chevron-down");

        accordionContent
            .find("#subcategory-form")
            .parent()
            .find("#subcategory-content")
            .addClass("flex")
            .show();
        accordionContent.find("#subcategory-form").remove();

        // Toggle current accordion
        accordionContent.slideToggle();
        $(this).toggleClass("active");
        $(this).find("i").toggleClass("fa-chevron-down fa-chevron-up");
    });
});
