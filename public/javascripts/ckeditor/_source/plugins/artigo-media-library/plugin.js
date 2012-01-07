/*
  Artigo MediaLibary Plugin for CKEditor
  Copyright (c) Jared Barboza 2011

  Redistributable under a BSD-style open source license.
  See license.txt for more information.

  You should have recieved a copy of the BSD license with this. If not, please
  check the license.txt file.

  Relies on Showdown, a javascript markdown parser. 
*/
(function(editor,undefined) {
    CKEDITOR.plugins.add( 'artigo-media-library',
    {
        init: function( editor ) {
            editor.addCommand( 'mediaLibrary', new CKEDITOR.dialogCommand( 'mediaLibrary' ) );
            editor.ui.addButton( 'MediaLibrary',
            {
                label: 'Media Library',
                command: 'mediaLibrary',
                icon: this.path + 'images/icon.png'
            });
        }
    });
})(CKEDITOR);