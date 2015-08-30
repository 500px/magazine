aspectRatio = 8/11
margins = 100

# Sets the size of the issue based on the 8/11 aspect ratio
setSize = ->
  height = ($(window).height() - (margins * 2))
  width = Math.floor(height * aspectRatio)

  $('.issue').css({
    height: height
    width: width
  })

homeSetup = ->
  $('.page_home').addClass('loaded')
  setTimeout ->
    $('.page_home').addClass('ready_for_hover')
  , 1000

issueSetup = ->
  $('.page_issue').addClass('loaded')

$ ->
  # Animate in the issue when the image is loaded
  # imgLoad = new imagesLoaded($('.issue'))
  # imgLoad.on 'done', (instance) ->
  #   $('.issue').addClass('loaded')
  #   return

  $('#smooth').smoothState
    prefetch: true
    onStart: {
      duration: 1000
      render: ($container) ->
        $('.page_home').addClass('reverse')
        $('.page_issue').addClass('reverse')
    }
    onAfter: ->
      setSize()
      homeSetup()
      issueSetup()

  setSize()
  homeSetup()
  issueSetup()
  $(window).on 'resize', setSize
