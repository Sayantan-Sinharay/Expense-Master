$(document).ready(function () {
  $(".accordion-toggle").click(function () {
    const accordionItem = $(this).closest(".accordion-item");
    const accordionContent = accordionItem.find(".accordion-content");

    if (!accordionContent.is(":animated")) {
      if (!accordionContent.is(":visible")) {
        // Close other open sections
        $(".accordion-content").slideUp();
        $(".accordion-toggle")
          .removeClass("active")
          .find("i")
          .removeClass("fa-chevron-up")
          .addClass("fa-chevron-down");

        // Open the clicked section
        accordionContent.slideDown();
        $(this).addClass("active");
        $(this)
          .find("i")
          .removeClass("fa-chevron-down")
          .addClass("fa-chevron-up");
      } else {
        // Close the clicked section
        accordionContent.slideUp();
        $(this).removeClass("active");
        $(this)
          .find("i")
          .removeClass("fa-chevron-up")
          .addClass("fa-chevron-down");
        accordionContent.find("#subcategory-form").remove();
      }
    }
  });
});
