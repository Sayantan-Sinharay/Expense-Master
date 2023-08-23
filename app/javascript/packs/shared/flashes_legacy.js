$(document).ready(function () {
    function hideFlashMessage(ele) {
        $(ele).fadeOut("slow", function () {
            $(this).remove();
        });
    }
    $("#flash-message .delete").click(function () {
        hideFlashMessage("#flash-message");
    });

    setTimeout(function () {
        hideFlashMessage("#flash-message");
    }, 3000);
});
