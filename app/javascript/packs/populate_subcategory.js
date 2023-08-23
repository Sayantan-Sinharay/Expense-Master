// Function to populate sub-category select field
function populateSubcategories(categoryId) {
    $("#subcategory_select").empty();
    $("#subcategory_select").prop("disabled", true);

    if (categoryId) {
        $.ajax({
            url: "/admin/categories/" + categoryId + "/subcategories",
            method: "GET",
            dataType: "json",
            success: function (response) {
                $("<option>", {
                    value: null,
                    text: "Select Sub-category",
                }).appendTo("#subcategory_select");

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
    }
}

export { populateSubcategories };
