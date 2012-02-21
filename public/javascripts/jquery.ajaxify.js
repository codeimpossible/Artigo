(function($){
    $.fn.ajaxify = function( options ) {
        var settings = $.extend( { 'method': 'POST' }, options);

        var $form = this;
        var inputs = $('input, select, textarea', $form);

        var data = {};

        inputs.each(function(){
           var name = this.attr['name'];
           var value = this.val();
           data[name] = value;
        });

        function submit () {
            var action = this.attr('action');
            var action_suffix = settings.action_suffix || "";
            var method = this.attr('method') || settings.method;
            var success = settings.success || function(){};
            var error = settings.error || function(){};
            $.ajax({
                url: action + action_suffix,
                data: data,
                dataType: 'json',
                type: method,
                success: success,
                error: error
            });
        }

        submit();

        return this;
    };
})(jQuery);
