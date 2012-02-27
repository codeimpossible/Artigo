var Cookie = (function(){
	function createCookie(name,value,days) {
		days = days || 90;
		if (days) {
			var date = new Date();
			date.setTime(date.getTime()+(days*24*60*60*1000));
			var expires = "; expires="+date.toGMTString();
		}
		else var expires = "";
		document.cookie = name+"="+value+expires+"; path=/";
	}

	function readCookie(name) {
		var nameEQ = name + "=";
		var ca = document.cookie.split(';');
		for(var i=0;i < ca.length;i++) {
			var c = ca[i];
			while (c.charAt(0)==' ') c = c.substring(1,c.length);
			if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
		}
		return null;
	}

	function eraseCookie(name) {
		createCookie(name,"",-1);
	}
	return {
		new: createCookie,
		find: readCookie,
		destroy: eraseCookie
	};
})();

(function($) {
	$(function() {

		// WHEN MANAGING POSTS:
		// confirm the action that the user selected
		$('#save_changes').click(function(){
			var action = $("#action").val();
			$("#confirm_" + action).modal();
		});

		// WHEN EDITING A POST:
		// update the url when the user changes the post title
		$('.post-title').keyup(function(){
    	$('#url-preview').html( $(this).val().replace(/&.{1,4};/ig, '-').replace(/[^a-z0-9]+/ig, '-') );
    });

    $('#save').click(function() {
      $('.post-form').submit();
    });

    // WHEN INTERACTING WITH A TAB:
    // store the selected tab in a cookie, select the last activated tab when the page loads
    var tab_cookie = window.location.href + "-tabs";
    $('a[data-toggle="tab"]').on('shown', function (e) {
    	Cookie.new(tab_cookie, e.target);
		}).filter('[href=#' + (Cookie.find(tab_cookie) || '').split('#')[1] + ']').trigger('click');

    if(Cookie.find(tab_cookie) && window.location.hash){
    	window.location.hash = '#' + Cookie.find(tab_cookie).split('#')[1];
    }

    // WHEN CHOOSING A NEW THEME:
		$('#themes a.btn.themepicker').click(function(e) {
			e.preventDefault();
			var $trigger = $(this), theme = $trigger.attr('theme');

			$trigger.find('.status').show();

			$.ajax({ url: '/admin/themes/' + theme + '/choose', type: 'POST', newtheme: theme })
					.success(function() {
						$('#themes .theme').removeClass('selected');
						$trigger.parents('.theme').addClass('selected');
						$('#notice').slideDown(function() {
							$(this).html('Theme has been changed to "' + theme + '".').glow("#ffff99", 3000);
						});
						setTimeout(function() {
							$('#notice').slideUp(function(){ $(this).html(''); });
						}, 4000);
					})
					.complete(function() {
						$trigger.find('.status').hide();
					});
			return false;
		});
	});
})(jQuery);
