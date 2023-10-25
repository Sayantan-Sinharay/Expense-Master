$(document).ready(function () {
  function hideFlashMessage(ele) {
    $(ele).fadeOut("slow", function () {
      $(this).parent().remove();
    });
  }
  $("#flash-message .delete").click(function () {
    hideFlashMessage("#flash-message");
  });

  const hideFlashTimer = setTimeout(function () {
    hideFlashMessage("#flash-message");
  }, 8000);
  hideFlashTimer();
  clearTimeout(hideFlashTimer);
});
