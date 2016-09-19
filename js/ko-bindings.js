(function() {
  define('ko-bindings', ['knockout'], function(ko) {
    return ko.bindingHandlers.copyToClipboard = {
      init: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
        var ref;
        this.callback = (ref = valueAccessor()) != null ? ref.callback : void 0;
        return element.onclick = (function(_this) {
          return function() {
            var temp;
            temp = document.createElement('input');
            temp.setAttribute('value', element.innerHTML);
            document.body.appendChild(temp);
            temp.select();
            document.execCommand('copy');
            document.body.removeChild(temp);
            if (typeof _this.callback === 'function') {
              return _this.callback();
            }
          };
        })(this);
      }
    };
  });

}).call(this);
