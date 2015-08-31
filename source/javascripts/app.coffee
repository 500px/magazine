aspectRatio = 8/11
margins = 100
mobile = $(window).width() < 480

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

openDrawer = ->
  $('.sliding_toc').addClass('visible')
  $('.dark_overlay').fadeIn(500)
  $('.sticky_nav_toc_link').text('Close')

closeDrawer = ->
  $('.sliding_toc').removeClass('visible')
  $('.dark_overlay').fadeOut(500)
  $('.sticky_nav_toc_link').text('Table of contents')

issueSetup = ->
  section_one_offset = $('.section_one').offset().top - 40
  section_two_offset = $('.section_two').offset().top - 40
  section_three_offset = $('.section_three').offset().top - 40
  section_four_offset = $('.section_four').offset().top - 40

  $('.goto_one').click ->
    $('html, body').animate { scrollTop: section_one_offset}
    if $('.sliding_toc').hasClass('visible')
      closeDrawer()
  $('.goto_two').click ->
    $('html, body').animate { scrollTop: section_two_offset}
    if $('.sliding_toc').hasClass('visible')
      closeDrawer()
  $('.goto_three').click ->
    $('html, body').animate { scrollTop: section_three_offset}
    if $('.sliding_toc').hasClass('visible')
      closeDrawer()
  $('.goto_four').click ->
    $('html, body').animate { scrollTop: section_four_offset}
    if $('.sliding_toc').hasClass('visible')
      closeDrawer()

  $('.page_issue').addClass('loaded')
  showNavOffset = $('.section_one').offset().top - 40

  $(window).on 'scroll', ->
    # unless mobile || $('.sliding_toc').hasClass('visible')
    unless $('.sliding_toc').hasClass('visible')
      if $(window).scrollTop() >= showNavOffset
        $('.sticky_nav').fadeIn(200).addClass('show')
      else
        $('.sticky_nav').removeClass('show').fadeOut(200)
  $('.sticky_nav_toc_link').on 'click', ->
    if $('.sliding_toc').hasClass('visible')
      closeDrawer()
    else
      openDrawer()
$ ->

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
  $(window).on 'resize', ->
    setSize
    section_one_offset = $('.section_one').offset().top - 40
    section_two_offset = $('.section_two').offset().top - 40
    section_three_offset = $('.section_three').offset().top - 40
    section_four_offset = $('.section_four').offset().top - 40
