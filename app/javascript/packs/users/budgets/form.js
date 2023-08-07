import { populateSubcategories } from "../../populate_subcategory";

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
});
