$(document).ready(function () {
  // Hide all tab contents except for the active one
  $(".tab-content:not(.is-active)").hide();

  // Handle tab click event
  $(".tabs ul li").click(function () {
    // Remove active class from all tab links
    $(".tabs ul li").removeClass("is-active");

    // Add active class to the clicked tab link
    $(this).addClass("is-active");

    // Hide all tab contents
    $(".tab-content").hide();

    // Show the corresponding tab content
    const targetTab = $(this).attr("data-target");
    $("#" + targetTab).show();
  });
});
