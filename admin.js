jQuery(document).ready(function($) {
    $('#select-all').change(function() {
        // Get all checkboxes
        var checkboxes = $(this).closest('form').find(':checkbox');
        // Check if all checkboxes are checked or not
        if($(this).is(':checked')) {
            checkboxes.prop('checked', true);
        }
        else {
            checkboxes.prop('checked', false);
        }
    });
});
