(function($) {
	var ckeditorBasePath = CKEDITOR.basePath.substr(0, CKEDITOR.basePath.indexOf("editor/")) + "editor/",
		customPluginsRoot = ckeditorBasePath + 'artigo/plugins/';

	console.log(customPluginsRoot);

	CKEDITOR.plugins.addExternal('artigo-paste-markdown',customPluginsRoot+'artigo-paste-markdown/', 'plugin.js');
	CKEDITOR.plugins.addExternal('artigo-media-library',customPluginsRoot+'artigo-media-library/', 'plugin.js');

	var config = {
		skin: 'artigo,' + ckeditorBasePath + 'artigo/skins/artigo/',
		extraPlugins: 'artigo-media-library,artigo-paste-markdown',
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
