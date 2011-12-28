/*
  Artigo Paste From Markdown Plugin for CKEditor
  Copyright (c) Jared Barboza 2011

  Redistributable under a BSD-style open source license.
  See license.txt for more information.

  You should have recieved a copy of the BSD license with this. If not, please
  check the license.txt file.

  Relies on Showdown, a javascript markdown parser. 
*/

(function(CKEDITOR) {

  //
  // showdown.js -- A javascript port of Markdown.
  //
  // Copyright (c) 2007 John Fraser.
  //
  // Original Markdown Copyright (c) 2004-2005 John Gruber
  //   <http://daringfireball.net/projects/markdown/>
  //
  // Redistributable under a BSD-style open source license.
  // See license.txt for more information.
  //
  // The full source distribution is at:
  //
  //        A A L
  //        T C A
  //        T K B
  //
  //   <http://www.attacklab.net/>
  //

  //
  // Wherever possible, Showdown is a straight, line-by-line port
  // of the Perl version of Markdown.
  //
  // This is not a normal parser design; it's basically just a
  // series of string substitutions.  It's hard to read and
  // maintain this way,  but keeping Showdown close to the original
  // design makes it easier to port new features.
  //
  // More importantly, Showdown behaves like markdown.pl in most
  // edge cases.  So web applications can do client-side preview
  // in Javascript, and then build identical HTML on the server.
  //
  // This port needs the new RegExp functionality of ECMA 262,
  // 3rd Edition (i.e. Javascript 1.5).  Most modern web browsers
  // should do fine.  Even with the new regular expression features,
  // We do a lot of work to emulate Perl's regex functionality.
  // The tricky changes in this file mostly have the "attacklab:"
  // label.  Major or self-explanatory changes don't.
  //
  // Smart diff tools like Araxis Merge will be able to match up
  // this file with markdown.pl in a useful way.  A little tweaking
  // helps: in a copy of markdown.pl, replace "#" with "//" and
  // replace "$text" with "text".  Be sure to ignore whitespace
  // and line endings.
  //
  var Showdown={};Showdown.converter=function(){var a;var b;var c;var d=0;this.makeHtml=function(d){a=new Array;b=new Array;c=new Array;d=d.replace(/~/g,"~T");d=d.replace(/\$/g,"~D");d=d.replace(/\r\n/g,"\n");d=d.replace(/\r/g,"\n");d="\n\n"+d+"\n\n";d=F(d);d=d.replace(/^[ \t]+$/mg,"");d=f(d);d=e(d);d=h(d);d=D(d);d=d.replace(/~D/g,"$$");d=d.replace(/~T/g,"~");return d};var e=function(c){var c=c.replace(/^[ ]{0,3}\[(.+)\]:[ \t]*\n?[ \t]*<?(\S+?)>?[ \t]*\n?[ \t]*(?:(\n*)["(](.+?)[")][ \t]*)?(?:\n+|\Z)/gm,function(c,d,e,f,g){d=d.toLowerCase();a[d]=z(e);if(f){return f+g}else if(g){b[d]=g.replace(/"/g,""")}return""});return c};var f=function(a){a=a.replace(/\n/g,"\n\n");var b="p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math|ins|del";var c="p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math";a=a.replace(/^(<(p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math|ins|del)\b[^\r]*?\n<\/\2>[ \t]*(?=\n+))/gm,g);a=a.replace(/^(<(p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math)\b[^\r]*?.*<\/\2>[ \t]*(?=\n+)\n)/gm,g);a=a.replace(/(\n[ ]{0,3}(<(hr)\b([^<>])*?\/?>)[ \t]*(?=\n{2,}))/g,g);a=a.replace(/(\n\n[ ]{0,3}<!(--[^\r]*?--\s*)+>[ \t]*(?=\n{2,}))/g,g);a=a.replace(/(?:\n\n)([ ]{0,3}(?:<([?%])[^\r]*?\2>)[ \t]*(?=\n{2,}))/g,g);a=a.replace(/\n\n/g,"\n");return a};var g=function(a,b){var d=b;d=d.replace(/\n\n/g,"\n");d=d.replace(/^\n/,"");d=d.replace(/\n+$/g,"");d="\n\n~K"+(c.push(d)-1)+"K\n\n";return d};var h=function(a){a=o(a);var b=t("<hr />");a=a.replace(/^[ ]{0,2}([ ]?\*[ ]?){3,}[ \t]*$/gm,b);a=a.replace(/^[ ]{0,2}([ ]?\-[ ]?){3,}[ \t]*$/gm,b);a=a.replace(/^[ ]{0,2}([ ]?\_[ ]?){3,}[ \t]*$/gm,b);a=q(a);a=s(a);a=r(a);a=x(a);a=f(a);a=y(a);return a};var i=function(a){a=u(a);a=j(a);a=A(a);a=m(a);a=k(a);a=B(a);a=z(a);a=w(a);a=a.replace(/  +\n/g," <br />\n");return a};var j=function(a){var b=/(<[a-z\/!$]("[^"]*"|'[^']*'|[^'">])*>|<!(--.*?--\s*)+>)/gi;a=a.replace(b,function(a){var b=a.replace(/(.)<\/?code>(?=.)/g,"$1`");b=G(b,"\\`*_");return b});return a};var k=function(a){a=a.replace(/(\[((?:\[[^\]]*\]|[^\[\]])*)\][ ]?(?:\n[ ]*)?\[(.*?)\])()()()()/g,l);a=a.replace(/(\[((?:\[[^\]]*\]|[^\[\]])*)\]\([ \t]*()<?(.*?)>?[ \t]*((['"])(.*?)\6[ \t]*)?\))/g,l);a=a.replace(/(\[([^\[\]]+)\])()()()()()/g,l);return a};var l=function(c,d,e,f,g,h,i,j){if(j==undefined)j="";var k=d;var l=e;var m=f.toLowerCase();var n=g;var o=j;if(n==""){if(m==""){m=l.toLowerCase().replace(/ ?\n/g," ")}n="#"+m;if(a[m]!=undefined){n=a[m];if(b[m]!=undefined){o=b[m]}}else{if(k.search(/\(\s*\)$/m)>-1){n=""}else{return k}}}n=G(n,"*_");var p='<a href="'+n+'"';if(o!=""){o=o.replace(/"/g,""");o=G(o,"*_");p+=' title="'+o+'"'}p+=">"+l+"</a>";return p};var m=function(a){a=a.replace(/(!\[(.*?)\][ ]?(?:\n[ ]*)?\[(.*?)\])()()()()/g,n);a=a.replace(/(!\[(.*?)\]\s?\([ \t]*()<?(\S+?)>?[ \t]*((['"])(.*?)\6[ \t]*)?\))/g,n);return a};var n=function(c,d,e,f,g,h,i,j){var k=d;var l=e;var m=f.toLowerCase();var n=g;var o=j;if(!o)o="";if(n==""){if(m==""){m=l.toLowerCase().replace(/ ?\n/g," ")}n="#"+m;if(a[m]!=undefined){n=a[m];if(b[m]!=undefined){o=b[m]}}else{return k}}l=l.replace(/"/g,""");n=G(n,"*_");var p='<img src="'+n+'" alt="'+l+'"';o=o.replace(/"/g,""");o=G(o,"*_");p+=' title="'+o+'"';p+=" />";return p};var o=function(a){function b(a){return a.replace(/[^\w]/g,"").toLowerCase()}a=a.replace(/^(.+)[ \t]*\n=+[ \t]*\n+/gm,function(a,c){return t('<h1 id="'+b(c)+'">'+i(c)+"</h1>")});a=a.replace(/^(.+)[ \t]*\n-+[ \t]*\n+/gm,function(a,c){return t('<h2 id="'+b(c)+'">'+i(c)+"</h2>")});a=a.replace(/^(\#{1,6})[ \t]*(.+?)[ \t]*\#*\n+/gm,function(a,c,d){var e=c.length;return t("<h"+e+' id="'+b(d)+'">'+i(d)+"</h"+e+">")});return a};var p;var q=function(a){a+="~0";var b=/^(([ ]{0,3}([*+-]|\d+[.])[ \t]+)[^\r]+?(~0|\n{2,}(?=\S)(?![ \t]*(?:[*+-]|\d+[.])[ \t]+)))/gm;if(d){a=a.replace(b,function(a,b,c){var d=b;var e=c.search(/[*+-]/g)>-1?"ul":"ol";d=d.replace(/\n{2,}/g,"\n\n\n");var f=p(d);f=f.replace(/\s+$/,"");f="<"+e+">"+f+"</"+e+">\n";return f})}else{b=/(\n\n|^\n?)(([ ]{0,3}([*+-]|\d+[.])[ \t]+)[^\r]+?(~0|\n{2,}(?=\S)(?![ \t]*(?:[*+-]|\d+[.])[ \t]+)))/g;a=a.replace(b,function(a,b,c,d){var e=b;var f=c;var g=d.search(/[*+-]/g)>-1?"ul":"ol";var f=f.replace(/\n{2,}/g,"\n\n\n");var h=p(f);h=e+"<"+g+">\n"+h+"</"+g+">\n";return h})}a=a.replace(/~0/,"");return a};p=function(a){d++;a=a.replace(/\n{2,}$/,"\n");a+="~0";a=a.replace(/(\n)?(^[ \t]*)([*+-]|\d+[.])[ \t]+([^\r]+?(\n{1,2}))(?=\n*(~0|\2([*+-]|\d+[.])[ \t]+))/gm,function(a,b,c,d,e){var f=e;var g=b;var j=c;if(g||f.search(/\n{2,}/)>-1){f=h(E(f))}else{f=q(E(f));f=f.replace(/\n$/,"");f=i(f)}return"<li>"+f+"</li>\n"});a=a.replace(/~0/g,"");d--;return a};var r=function(a){a+="~0";a=a.replace(/(?:\n\n|^)((?:(?:[ ]{4}|\t).*\n+)+)(\n*[ ]{0,3}[^ \t\n]|(?=~0))/g,function(a,b,c){var d=b;var e=c;d=v(E(d));d=F(d);d=d.replace(/^\n+/g,"");d=d.replace(/\n+$/g,"");d="<pre><code>"+d+"\n</code></pre>";return t(d)+e});a=a.replace(/~0/,"");return a};var s=function(a){a+="~0";a=a.replace(/\n```(.*)\n([^`]+)\n```/g,function(a,b,c){var d=b;var e=c;e=v(e);e=F(e);e=e.replace(/^\n+/g,"");e=e.replace(/\n+$/g,"");e="<pre><code class="+d+">"+e+"\n</code></pre>";return t(e)});a=a.replace(/~0/,"");return a};var t=function(a){a=a.replace(/(^\n+|\n+$)/g,"");return"\n\n~K"+(c.push(a)-1)+"K\n\n"};var u=function(a){a=a.replace(/(^|[^\\])(`+)([^\r]*?[^`])\2(?!`)/gm,function(a,b,c,d,e){var f=d;f=f.replace(/^([ \t]*)/g,"");f=f.replace(/[ \t]*$/g,"");f=v(f);return b+"<code>"+f+"</code>"});return a};var v=function(a){a=a.replace(/&/g,"&");a=a.replace(/</g,"<");a=a.replace(/>/g,">");a=G(a,"*_{}[]\\",false);return a};var w=function(a){a=a.replace(/(\*\*|__)(?=\S)([^\r]*?\S[*_]*)\1/g,"<strong>$2</strong>");a=a.replace(/(\*|_)(?=\S)([^\r]*?\S)\1/g,"<em>$2</em>");return a};var x=function(a){a=a.replace(/((^[ \t]*>[ \t]?.+\n(.+\n)*\n*)+)/gm,function(a,b){var c=b;c=c.replace(/^[ \t]*>[ \t]?/gm,"~0");c=c.replace(/~0/g,"");c=c.replace(/^[ \t]+$/gm,"");c=h(c);c=c.replace(/(^|\n)/g,"$1  ");c=c.replace(/(\s*<pre>[^\r]+?<\/pre>)/gm,function(a,b){var c=b;c=c.replace(/^  /mg,"~0");c=c.replace(/~0/g,"");return c});return t("<blockquote>\n"+c+"\n</blockquote>")});return a};var y=function(a){a=a.replace(/^\n+/g,"");a=a.replace(/\n+$/g,"");var b=a.split(/\n{2,}/g);var d=new Array;var e=b.length;for(var f=0;f<e;f++){var g=b[f];if(g.search(/~K(\d+)K/g)>=0){d.push(g)}else if(g.search(/\S/)>=0){g=i(g);g=g.replace(/^([ \t]*)/g,"<p>");g+="</p>";d.push(g)}}e=d.length;for(var f=0;f<e;f++){while(d[f].search(/~K(\d+)K/)>=0){var h=c[RegExp.$1];h=h.replace(/\$/g,"$$$$");d[f]=d[f].replace(/~K\d+K/,h)}}return d.join("\n\n")};var z=function(a){a=a.replace(/&(?!#?[xX]?(?:[0-9a-fA-F]+|\w+);)/g,"&");a=a.replace(/<(?![a-z\/?\$!])/gi,"<");return a};var A=function(a){a=a.replace(/\\(\\)/g,H);a=a.replace(/\\([`*_{}\[\]()>#+-.!])/g,H);return a};var B=function(a){a=a.replace(/<((https?|ftp|dict):[^'">\s]+)>/gi,'<a href="$1">$1</a>');a=a.replace(/<(?:mailto:)?([-.\w]+\@[-a-z0-9]+(\.[-a-z0-9]+)*\.[a-z]+)>/gi,function(a,b){return C(D(b))});return a};var C=function(a){function b(a){var b="0123456789ABCDEF";var c=a.charCodeAt(0);return b.charAt(c>>4)+b.charAt(c&15)}var c=[function(a){return"&#"+a.charCodeAt(0)+";"},function(a){return"&#x"+b(a)+";"},function(a){return a}];a="mailto:"+a;a=a.replace(/./g,function(a){if(a=="@"){a=c[Math.floor(Math.random()*2)](a)}else if(a!=":"){var b=Math.random();a=b>.9?c[2](a):b>.45?c[1](a):c[0](a)}return a});a='<a href="'+a+'">'+a+"</a>";a=a.replace(/">.+:/g,'">');return a};var D=function(a){a=a.replace(/~E(\d+)E/g,function(a,b){var c=parseInt(b);return String.fromCharCode(c)});return a};var E=function(a){a=a.replace(/^(\t|[ ]{1,4})/gm,"~0");a=a.replace(/~0/g,"");return a};var F=function(a){a=a.replace(/\t(?=\t)/g,"    ");a=a.replace(/\t/g,"~A~B");a=a.replace(/~B(.+?)~A/g,function(a,b,c){var d=b;var e=4-d.length%4;for(var f=0;f<e;f++)d+=" ";return d});a=a.replace(/~A/g,"    ");a=a.replace(/~B/g,"");return a};var G=function(a,b,c){var d="(["+b.replace(/([\[\]\\])/g,"\\$1")+"])";if(c){d="\\\\"+d}var e=new RegExp(d,"g");a=a.replace(e,H);return a};var H=function(a,b){var c=b.charCodeAt(0);return"~E"+c+"E"}};if(typeof exports!="undefined")exports.Showdown=Showdown;

  CKEDITOR.plugins.add("artigo-paste-markdown",{init:function(a){a.addCommand("pasteFromMarkdown",new CKEDITOR.dialogCommand("pasteFromMarkdown"));a.ui.addButton("PasteFromMarkdown",{label:"Paste Markdown",command:"pasteFromMarkdown",icon:this.path+"images/icon.png"});CKEDITOR.dialog.add("pasteFromMarkdown",function(a){return{title:"Paste Markdown",minWidth:400,minHeight:200,contents:[{id:"general",label:"Content",elements:[{type:"html",html:'Enter the markdown content in the field below and click "Ok".'},{type:"textarea",id:"contents",label:"Markdown Text",validate:CKEDITOR.dialog.validate.notEmpty("The markdown text field cannot be empty."),required:true,commit:function(a){converter=(new Showdown.converter).makeHtml;a.contents=converter(this.getValue())}}]}],onOk:function(){var b=this,c={};this.commitContent(c);a.insertHtml(c.contents)}}})}})
})(CKEDITOR);