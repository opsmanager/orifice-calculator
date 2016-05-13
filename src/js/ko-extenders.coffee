define 'ko-extenders', ['knockout'], (ko) ->
  ko.extenders.toNumber = (target) ->
    ko.pureComputed
      read: target
      write: (newValue) ->
        target Number(newValue)
