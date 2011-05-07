(function($) {
	$(function() {
		var config = {
			skin: 'v2',
			toolbar:
			[
				['Source', 'Bold', 'Italic', 'Underline','Strike', 'Blockquote', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink'],
				['Pre', 'Code'],
				['Cut','Copy','Paste','PasteText','PasteFromWord'],
				['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe'],
				['UIColor']
			],
            contentsCss: "/stylesheets/scaffold.css"
		};

		// Initialize the editor.
		// Callback function can be passed and executed after full instance creation.
		$('#content').ckeditor(config);
	});
})(jQuery);