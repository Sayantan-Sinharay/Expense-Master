$(document).ready(function () {
    // Get the selected category on page load
    const selectedCategoryId = $("#category_select").val();

    if (selectedCategoryId) {
        // Populate sub-category select field on page load
        populateSubcategories(selectedCategoryId);
    } else {
        $("#subcategory_select").prop("disabled", true);
        // Handle category select change event
        $("#category_select").change(function () {
            const categoryId = $(this).val();
            populateSubcategories(categoryId);
        });
    }

    // Function to populate sub-category select field
    function populateSubcategories(categoryId) {
        $("#subcategory_select").empty();
        $("#subcategory_select").prop("disabled", true);

        if (categoryId) {
            $.ajax({
                url: "/admin/categories/" + categoryId + "/subcategories",
                method: "GET",
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
});
