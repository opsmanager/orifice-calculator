(function() {
  define('ko-bindings', ['knockout'], function(ko) {
    return ko.bindingHandlers.copyToClipboard = {
      init: function(element) {
        return element.onclick = function() {
          var temp;
          temp = document.createElement('input');
          temp.setAttribute('value', element.innerHTML);
          document.body.appendChild(temp);
          temp.select();
          document.execCommand('copy');
          return document.body.removeChild(temp);
        };
      }
    };
  });

}).call(this);
