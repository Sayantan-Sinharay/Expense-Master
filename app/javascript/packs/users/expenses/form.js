$(document).ready(function () {
    $("#subcategory_select").prop("disabled", true);
    $("#attachment-input #remove_file-button").hide();

    $("#category_select").change(function () {
        const selectedCategoryId = $(this).val();
        $("#subcategory_select").empty();
        $("<option>", {
            value: null,
            text: "Select Sub-category",
        }).appendTo("#subcategory_select");
        $("#subcategory_select").prop("disabled", true);

        if (selectedCategoryId) {
            $.ajax({
                url:
                    "/admin/categories/" +
                    selectedCategoryId +
                    "/subcategories",
                method: "GET",
                success: function (response) {
                    response.forEach(function (subcategory) {
                        $("<option>", {
                            value: subcategory.id,
                            text: subcategory.name,
                        }).appendTo("#subcategory_select");
                    });

                    $("#subcategory_select").prop("disabled", false);
                },
                error: function (xhr, status, error) {
                    console.log(error);
                },
            });
        } else {
            $("#subcategory_select").prop("disabled", true);
        }
    });

    $("#attachment-input input[type=file]").change(function () {
        const fileInput = $(this)[0];
        const fileNameSpan = $(
            "#attachment-input .file-name > span:first-child"
        );

        if (fileInput.files.length > 0) {
            fileNameSpan.text(fileInput.files[0].name);
            $("#attachment-input #remove_file-button").show();
        } else {
            fileNameSpan.text("No file chosen");
            $("#attachment-input #remove_file-button").hide();
        }
    });

    $("#attachment-input #remove_file-button").click(function () {
        const fileInput = $("#attachment-input input[type=file]");
        const fileNameSpan = $(
            "#attachment-input .file-name > span:first-child"
        );

        fileInput.val("");
        fileNameSpan.text("No file chosen");
        $(this).hide();
    });
});
