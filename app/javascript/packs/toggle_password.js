$(document).ready(function () {
  $(".toggle-password")
    .off()
    .click(function () {
      const container = $(this).closest(".password-container");
      const passwordField = container.find(".password-field");

      const isPassword = passwordField.attr("type") === "password";
      passwordField.attr("type", isPassword ? "text" : "password");

      $(this).find("i").toggleClass("fa-eye fa-eye-slash");

      const input = passwordField.get(0);
      input.focus();
      input.setSelectionRange(input.value.length, input.value.length);
    });
});

