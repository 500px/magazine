aspectRatio = 8/11
margins = 100

setSize = ->
  height = ($(window).height() - (margins * 2))
  width = Math.floor(height * aspectRatio)

  $('.issue').css({
    height: height
    width: width
  })

$ ->
  setSize()
  $(window).on 'resize', setSize
