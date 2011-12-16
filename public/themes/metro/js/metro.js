(function($) {
	$(function() {
		prettyPrint();
		
		$(".socialLink.email, .socialLink.twitter, .socialLink.linkedin, .socialLink.facebook, .socialLink.rss").hover(
			function() {
				$(this).addClass('hover');
			},
			function() {
				$(this).removeClass('hover');
			}
		);
	});
})(jQuery);