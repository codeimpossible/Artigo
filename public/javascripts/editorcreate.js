GENTICS.Aloha.settings = {
	"i18n": {"current": "en"},
	"ribbon": false,
	"plugins": { 
		"com.gentics.aloha.plugins.GCN": { 
			"enabled": false 
		},
		"com.gentics.aloha.plugins.Format": { 
			config : [ 'b', 'i','u','del','sub','sup', 'p', 'title', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'pre', 'removeFormat'],
		} 
	}
};

(function($) {
	$(function() {
		$('#title').aloha();
		$('#summary').aloha();
		$('#content').aloha();
	});
})(jQuery);

GENTICS.Aloha.EventRegistry.subscribe(GENTICS.Aloha, "editableDeactivated", save);