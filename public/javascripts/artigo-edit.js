
(function($) {
	$(function() {
		$('.post-title').keyup(function(){
            $('#url-preview').html( $(this).val().replace(/&.{1,4};/ig, '-').replace(/[^a-z0-9]+/ig, '-') );
        });
        $('#save').click(function() {
            $('.post-form').submit();
        });
	});
})(jQuery);
