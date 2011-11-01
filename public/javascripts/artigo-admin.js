(function($) {
	$(function() {
		$('.tabs').tabs({ cookie: { expires: 30 } });
		$('button, input[type=submit]').button();
		
		$('#themes button').click(function(e) {
			e.preventDefault();
			var $trigger = $(this);
			var theme = $trigger.attr('theme');
			$trigger.find('.status').show();
			var jxhr = $.post('/admin/config/changetheme', { newtheme: theme })
						.success(function(a,b,c) {
							$('#themes .theme').removeClass('selected');
							$trigger.parents('.theme').addClass('selected');
							$('#notice').slideDown(function() { $(this).html('Theme has been changed to "' + theme + '".').glow("#ffff99", 3000); });
							setTimeout(function() {
								$('#notice').slideUp(function(){ $(this).html(''); });
							}, 4000);
						}).complete(function() {
							$trigger.find('.status').hide();
						});
			return false;
		});
	});
})(jQuery);