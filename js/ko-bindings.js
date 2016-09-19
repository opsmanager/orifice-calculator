(function() {
  define('ko-bindings', ['knockout'], function(ko) {
    return ko.bindingHandlers.copyToClipboard = {
      init: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
        var _findNestedValue, ref;
        this.callback = (ref = valueAccessor()) != null ? ref.callback : void 0;
        element.onclick = (function(_this) {
          return function() {
            var nestedElement, temp;
            temp = document.createElement('input');
            nestedElement = _findNestedValue(element);
            temp.setAttribute('value', nestedElement.innerHTML);
            document.body.appendChild(temp);
            temp.select();
            document.execCommand('copy');
            document.body.removeChild(temp);
            if (typeof _this.callback === 'function') {
              return _this.callback();
            }
          };
        })(this);
        return _findNestedValue = function(element) {
          var lastChildren;
          if (element.children.length > 0) {
            lastChildren = element.children[0];
            while (lastChildren.children.length !== 0) {
              lastChildren = lastChildren.children[0];
            }
          } else {
            lastChildren = element;
          }
          return lastChildren;
        };
      }
    };
  });

}).call(this);
