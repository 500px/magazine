aspectRatio = 8/11
margins = 150
mobile = $(window).width() < 480

# Sets the size of the issue based on the 8/11 aspect ratio
setSize = ->
  height = ($(window).height() - (margins * 2))
  width = Math.floor(height * aspectRatio)

  $('.issue').css({
    height: height
    width: width
    left: $(window).width() / 2 - (width / 2)
  })

homeSetup = ->
  $('.page_home').addClass('loaded')
  magazineStand()
  setTimeout ->
    $('.page_home').addClass('ready_for_hover')
  , 1000

magazineStand = ->
  try
    focused = $('[data-position="0"]')
    issueOffset = parseFloat(focused.css('left').replace(/[^-\d\.]/g, ''))
    issueWidth = parseFloat($('.issue').css('width').replace(/[^-\d\.]/g, ''))
    halfIssue = issueWidth / 2
    gap = issueOffset - halfIssue


  setPosition = ->
    $('.issue').each ->
      if mobile
        mobilePeek = 40
        mobileGap = ($(window).width() - issueWidth - (mobilePeek * 2)) / 2
        if $(this).attr('data-position') >= 0 # is to the right
          $(this).css({
            left: ( parseFloat($(this).attr('data-position')) ) * ( mobileGap + issueWidth) + issueOffset
          })
        else # is to the right
          $(this).css({
            left: (( parseFloat($(this).attr('data-position')) ) * issueWidth ) + ((( parseFloat($(this).attr('data-position')) ) + 1) * mobileGap) + mobilePeek
          })
      else
        if $(this).attr('data-position') >= 0 # is to the right
          $(this).css({
            left: ( parseFloat($(this).attr('data-position')) * (gap + issueWidth)) + issueOffset
          })
        else # is to the right
          $(this).css({
            left: ( parseFloat($(this).attr('data-position')) + 1 ) * (gap + issueWidth) - halfIssue
          })

  $(window).keydown (event) ->
    if event.keyCode == 37 # left
      shiftRight()
    else if event.keyCode == 39 # right
      shiftLeft()
    else if event.keyCode == 13 # enter key
      $('[data-position="0"]').click()

  $('.controls_arrow.left').on 'click', ->
    shiftRight()

  $('.controls_arrow.right').on 'click', ->
    shiftLeft()

  delete Hammer.defaults.cssProps.userSelect

  hammerOptions =
    dragLockToAxis: true
    dragBlockHorizontal: true

  hammer = new Hammer(document.body, hammerOptions)
  hammer.on 'swipeleft swiperight', (ev) ->
    if ev.type == 'swipeleft'
      shiftLeft()
    else if ev.type == 'swiperight'
      shiftRight()

  shiftLeft = ->
    lastIndex = -($('.issue').length - 1)
    unless $('[data-position="' + lastIndex + '"]').length
      $('.issue').each ->
        $(this).attr('data-position', (parseFloat($(this).attr('data-position')) - 1))
      setPosition()

  shiftRight = ->
    lastIndex = ($('.issue').length - 1)
    unless $('[data-position="' + lastIndex + '"]').length
      $('.issue').each ->
        $(this).attr('data-position', (parseFloat($(this).attr('data-position')) + 1))
      setPosition()

  setPosition()

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
