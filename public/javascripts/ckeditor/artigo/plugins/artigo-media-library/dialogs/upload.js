/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
(function(editor) {
    var CONTENTS = '<iframe src="' + this.path + 'html/upload.html" height="300" width="400"></iframe>';

    editor.dialog.add( 'upload', function( editor ) {
        return {
            title: TITLE,
            minWidth: 400,
            minHeight: 300,
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
})(CKEDITOR);