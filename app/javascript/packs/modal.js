$(document).ready(function () {
    $(".delete").click(function () {
        console.log($(this).closest(".modal"));
        $(this).closest(".modal").removeClass("is-active");
    });
});
