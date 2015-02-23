class Example
  
  constructor: ($el, type) ->
    @el = $el
    @type = type
    @select = $el.find('.example__select')
    @list = $el.find('.example__list')
    @autoUpdate()


  autoUpdate: =>
    currentState = @select.val()
    @select.off('change')
           .on('change', =>
      @list.removeClass 'f-' + @type + '--' + currentState
      @list.addClass    'f-' + @type + '--' + @select.val()
      @autoUpdate()
    )


new Example($('.example--align'), 'align')
new Example($('.example--dir'), 'dir')
new Example($('.example--gap'), 'gap')
