(function($) {
	$(function() {
		var config = {
			skin: 'v2',
			toolbar:
			[
				['Source', 'Bold', 'Italic', 'Underline','Strike', 'Blockquote', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink'],
				['Cut','Copy','Paste','PasteText','PasteFromWord'],
				['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe'],
				['UIColor'],
				['Maximize', 'ShowBlocks', '-', 'About']
			]
		};

		// Initialize the editor.
		// Callback function can be passed and executed after full instance creation.
		$('#content').ckeditor(config);
	});
})(jQuery);
