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

    $(".dropdown-item.reject").on("click", function (event) {
        event.preventDefault();
        // Show the modal
        $("#rejection-modal").addClass("is-active");
    });

    // Handle click event on the modal close button
    $(".modal .delete").on("click", function () {
        // Hide the modal
        $(this).closest(".modal").removeClass("is-active");
    });

    // Handle form submission
    $("#rejectForm").on("submit", function (event) {
        event.preventDefault();

        // Get the rejection reason from the form
        const reason = $("#reasonInput").val();

        // Check if a reason is provided
        if (reason.trim() === "") {
            $(".reject-error").removeClass("is-hidden");
        } else {
            // Hide the modal
            $("#rejection-modal").removeClass("is-active");

            // Submit the form (perform the AJAX request)
            $(this).off("submit").submit();
        }
    });
});
