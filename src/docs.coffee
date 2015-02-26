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


class ExampleForFill

  constructor: ->
    @el = $('.example--fill')
    @range = @el.find('.example__input')
    @sidebar = @el.find('.example__unit--sidebar')    
    @init()
    

  setSidebarWidth: =>
    @sidebar.css(
      width: @range.val()
      height: @range.val() / 5
    )

  updSidebarWidth: =>
    @range.change =>
      @setSidebarWidth()

  init: =>
    @setSidebarWidth()
    @updSidebarWidth()

new ExampleForFill()


