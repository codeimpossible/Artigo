/*
  Artigo MediaLibary Plugin for CKEditor
  Copyright (c) Jared Barboza 2011

  Redistributable under a BSD-style open source license.
  See license.txt for more information.

  You should have recieved a copy of the BSD license with this. If not, please
  check the license.txt file.

  Relies on Showdown, a javascript markdown parser.
*/
(function(undefined) {
    CKEDITOR.plugins.add( 'artigo-media-library',
    {
        init: function( editor ) {
            var path = this.path;
            editor.addCommand( 'mediaLibrary', new CKEDITOR.dialogCommand( 'mediaLibrary' ) );
            editor.ui.addButton( 'MediaLibrary',
            {
                label: 'Media Library',
                command: 'mediaLibrary',
                icon: path + 'images/icon.png'
            });

            CKEDITOR.dialog.add( 'mediaLibrary', function( editor ) {
                console.log(this);
                var CONTENTS = '<iframe src="/admin/media/library_embedded" style="height:450px; width:100%;"></iframe>';
                var TITLE = "Artigo Media Library";
                return {
                    title: TITLE,
                    minWidth: 750,
                    minHeight: 450,
                    contents: [
                        {
                            id: 'tab1',
                            label: '',
                            title: '',
                            expand: true,
                            padding: 0,
                            elements: [
                                {
                                    type: "html",
                                    html: CONTENTS
                                }
                            ]
                        }
                    ],
                    buttons : [ CKEDITOR.dialog.cancelButton ]
                };
            });
        }
    });
})();
