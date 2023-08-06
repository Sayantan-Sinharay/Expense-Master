$(document).ready(function () {
    $("#list-message").removeClass("flex");
    $("#list-message").hide();

    $(".dropdown").on("click", function (e) {
        const dropdown = $(this);
        const isActive = dropdown.hasClass("is-active");
        $(".dropdown").removeClass("is-active");
        if (!isActive) {
            dropdown.addClass("is-active");
        }
    });

    $(document).on("click", function (e) {
        const target = $(e.target);
        if (!target.closest(".dropdown").length) {
            $(".dropdown").removeClass("is-active");
        }
    });

    $(".dropdown-item").on("click", function (e) {
        e.preventDefault();

        const value = $(this).data("value");
        const text = $(this).text();
        const dropdownMenu = $(this).closest(".dropdown-menu");
        const dropdownTrigger = dropdownMenu
            .siblings(".dropdown-trigger")
            .find(".dropdown-button");

        dropdownTrigger.attr("data-value", value);
        dropdownTrigger.find("span:first-child").text(text);

        dropdownMenu.find(".is-active").removeClass("is-active");
        $(this).addClass("is-active");

        const selectedCategoryId = parseInt(
            $("#selected-category").parent().attr("data-value")
        );
        const selectedMonth = parseInt(
            $("#selected-month").parent().attr("data-value")
        );

        let totalValidBudgets = 0;

        $("div#budget-item").each(function () {
            const categoryId = $(this).data("category-id");
            const month = $(this).data("month");

            if (
                (!selectedCategoryId || selectedCategoryId === categoryId) &&
                (!selectedMonth || selectedMonth === month)
            ) {
                $(this).addClass("flex");
                $(this).show();
                totalValidBudgets++;
            } else {
                $(this).removeClass("flex");
                $(this).hide();
            }
        });

        if (totalValidBudgets) {
            $("#list-message").removeClass("flex");
            $("#list-message").hide();
        } else {
            $("#list-message").addClass("flex");
            $("#list-message").show();
        }
    });
});
