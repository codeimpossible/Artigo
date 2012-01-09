(function($) {
	var config = {
		skin: 'office2003',
		extraPlugins: 'artigo-paste-markdown,artigo-media-library',
		toolbar:
		[
			['Source', 'Bold', 'Italic', 'Underline','Strike', 'Blockquote', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink'],
			['Cut','Copy','Paste','PasteText','PasteFromWord', 'PasteFromMarkdown'],
			['MediaLibrary','Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe'],
			['UIColor'],
			['Maximize', 'ShowBlocks', '-', 'About']
		]
	};

	// Initialize the editor.
	// Callback function can be passed and executed after full instance creation.
	$('#post_body').ckeditor(config);
})(jQuery);
