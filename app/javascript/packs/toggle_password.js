const togglePassword = () => {
    $("#toggle-password").click(function () {
        const passwordField = $(this).prev("#password-field");
        passwordField.focus();
        const isPassword = passwordField.attr("type") === "password";

        passwordField.attr("type", isPassword ? "text" : "password");
        $(this).find("i").toggleClass("fa-eye fa-eye-slash");
    });
};

export { togglePassword };
