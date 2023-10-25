$(document).ready(function () {
  $(".tab-link").click(function (event) {
    event.preventDefault();
    // Remove active class from all tab links
    $(".tab-link").parent().removeClass("is-active font-bold");

    // Hide all tab contents
    $(".tab-content").addClass("hidden");

    // Add active class to clicked tab link
    $(this).parent().addClass("is-active font-bold");

    // Show corresponding tab content
    const tabId = $(this).parent().data("tab");
    $("#" + tabId).removeClass("hidden");
  });
});
