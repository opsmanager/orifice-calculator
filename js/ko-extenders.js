(function() {
  define('ko-extenders', ['knockout'], function(ko) {
    return ko.extenders.toNumber = function(target) {
      return ko.pureComputed({
        read: target,
        write: function(newValue) {
          return target(Number(newValue));
        }
      });
    };
  });

}).call(this);
