$(document).ready(function () {
    $("#subcategory_select").prop("disabled", true);

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
});
