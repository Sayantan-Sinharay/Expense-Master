$(document).ready(function () {
    $(".toggle-password")
        .off()
        .click(function () {
            const container = $(this).closest(".password-container");
            const passwordField = container.find(".password-field");
            passwordField.focus();

            const isPassword = passwordField.attr("type") === "password";
            passwordField.attr("type", isPassword ? "text" : "password");

            $(this).find("i").toggleClass("fa-eye fa-eye-slash");
        });
});
