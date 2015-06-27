# Meteor.startup ->
#   AutoForm.setDefaultTemplate "materialize";
#
# Template.homeLayout.rendered = ->
#   $('.button-collapse').sideNav()
#   $('.scrollspy').scrollSpy()
#
#   animationDelay = 2500
#   barAnimationDelay = 3800
#   barWaiting = barAnimationDelay - 3000
#   lettersDelay = 50
#   typeLettersDelay = 150
#   selectionDuration = 500
#   typeAnimationDelay = selectionDuration + 800
#   revealDuration = 600
#   revealAnimationDelay = 1500
#
#   singleLetters = ($words) ->
#     $words.each ->
#       word = $(this)
#       letters = word.text().split('')
#       selected = word.hasClass('is-visible')
#       for i of letters
#         `i = i`
#         if word.parents('.rotate-2').length > 0
#           letters[i] = '<em>' + letters[i] + '</em>'
#         letters[i] = if selected then '<i class="in">' + letters[i] + '</i>' else '<i>' + letters[i] + '</i>'
#       newLetters = letters.join('')
#       word.html(newLetters).css 'opacity', 1
#       return
#     return
#
#   animateHeadline = ($headlines) ->
#     duration = animationDelay
#     $headlines.each ->
#       headline = $(this)
#       if headline.hasClass('loading-bar')
#         duration = barAnimationDelay
#         setTimeout (->
#           headline.find('.cd-words-wrapper').addClass 'is-loading'
#           return
#         ), barWaiting
#       else if headline.hasClass('clip')
#         spanWrapper = headline.find('.cd-words-wrapper')
#         newWidth = spanWrapper.width() + 10
#         spanWrapper.css 'width', newWidth
#       else if !headline.hasClass('type')
#         #assign to .cd-words-wrapper the width of its longest word
#         words = headline.find('.cd-words-wrapper b')
#         width = 0
#         words.each ->
#           wordWidth = $(this).width()
#           if wordWidth > width
#             width = wordWidth
#           return
#         headline.find('.cd-words-wrapper').css 'width', width
#       #trigger animation
#       setTimeout (->
#         hideWord headline.find('.is-visible').eq(0)
#         return
#       ), duration
#       return
#     return
#
#   initHeadline = ->
#     singleLetters $('.cd-headline.letters').find('b')
#     animateHeadline $('.cd-headline')
#     return
#
#   initHeadline()
#
#
#   hideWord = ($word) ->
#     nextWord = takeNext($word)
#     if $word.parents('.cd-headline').hasClass('type')
#       parentSpan = $word.parent('.cd-words-wrapper')
#       parentSpan.addClass('selected').removeClass 'waiting'
#       setTimeout (->
#         parentSpan.removeClass 'selected'
#         $word.removeClass('is-visible').addClass('is-hidden').children('i').removeClass('in').addClass 'out'
#         return
#       ), selectionDuration
#       setTimeout (->
#         showWord nextWord, typeLettersDelay
#         return
#       ), typeAnimationDelay
#     else if $word.parents('.cd-headline').hasClass('letters')
#       bool = if $word.children('i').length >= nextWord.children('i').length then true else false
#       hideLetter $word.find('i').eq(0), $word, bool, lettersDelay
#       showLetter nextWord.find('i').eq(0), nextWord, bool, lettersDelay
#     else if $word.parents('.cd-headline').hasClass('clip')
#       $word.parents('.cd-words-wrapper').animate { width: '2px' }, revealDuration, ->
#         switchWord $word, nextWord
#         showWord nextWord
#         return
#     else if $word.parents('.cd-headline').hasClass('loading-bar')
#       $word.parents('.cd-words-wrapper').removeClass 'is-loading'
#       switchWord $word, nextWord
#       setTimeout (->
#         hideWord nextWord
#         return
#       ), barAnimationDelay
#       setTimeout (->
#         $word.parents('.cd-words-wrapper').addClass 'is-loading'
#         return
#       ), barWaiting
#     else
#       switchWord $word, nextWord
#       setTimeout (->
#         hideWord nextWord
#         return
#       ), animationDelay
#     return
#
#   showWord = ($word, $duration) ->
#     if $word.parents('.cd-headline').hasClass('type')
#       showLetter $word.find('i').eq(0), $word, false, $duration
#       $word.addClass('is-visible').removeClass 'is-hidden'
#     else if $word.parents('.cd-headline').hasClass('clip')
#       $word.parents('.cd-words-wrapper').animate { 'width': $word.width() + 10 }, revealDuration, ->
#         setTimeout (->
#           hideWord $word
#           return
#         ), revealAnimationDelay
#         return
#     return
#
#   showLetter = ($letter, $word, $bool, $duration) ->
#     $letter.addClass('in').removeClass 'out'
#     if !$letter.is(':last-child')
#       setTimeout (->
#         showLetter $letter.next(), $word, $bool, $duration
#         return
#       ), $duration
#     else
#       if $word.parents('.cd-headline').hasClass('type')
#         setTimeout (->
#           $word.parents('.cd-words-wrapper').addClass 'waiting'
#           return
#         ), 200
#       if !$bool
#         setTimeout (->
#           hideWord $word
#           return
#         ), animationDelay
#     return
#
#   takeNext = ($word) ->
#     if !$word.is(':last-child') then $word.next() else $word.parent().children().eq(0)
#
#   takePrev = ($word) ->
#     if !$word.is(':first-child') then $word.prev() else $word.parent().children().last()
#
#   switchWord = ($oldWord, $newWord) ->
#     $oldWord.removeClass('is-visible').addClass 'is-hidden'
#     $newWord.removeClass('is-hidden').addClass 'is-visible'
#     return
#
#   $('.button-collapse').sideNav
#     menuWidth: 240
#     activationWidth: 70
#   $('.parallax').parallax()
#
#   card = document.querySelectorAll('.card-work')
#
#   transEndEventNames =
#     'WebkitTransition': 'webkitTransitionEnd'
#     'MozTransition': 'transitionend'
#     'transition': 'transitionend'
#
#   transEndEventName = transEndEventNames[Modernizr.prefixed('transition')]
#
#   addDashes = (name) ->
#     name.replace /([A-Z])/g, (str, m1) ->
#       '-' + m1.toLowerCase()
#
#   getPopup = (id) ->
#     document.querySelector '.popup[data-popup="' + id + '"]'
#
#   getDimensions = (el) ->
#     el.getBoundingClientRect()
#
#   getDifference = (card, popup) ->
#     cardDimensions = getDimensions(card)
#     popupDimensions = getDimensions(popup)
#     {
#       height: popupDimensions.height / cardDimensions.height
#       width: popupDimensions.width / cardDimensions.width
#       left: popupDimensions.left - (cardDimensions.left)
#       top: popupDimensions.top - (cardDimensions.top)
#     }
#
#   transformCard = (card, size) ->
#     card.style[Modernizr.prefixed('transform')] = 'translate(' + size.left + 'px,' + size.top + 'px)' + ' scale(' + size.width + ',' + size.height + ')'
#
#   hasClass = (elem, cls) ->
#     str = ' ' + elem.className + ' '
#     testCls = ' ' + cls + ' '
#     str.indexOf(testCls) != -1
#
#   closest = (e) ->
#     el = e.target or e.srcElement
#     if el = el.parentNode
#       loop
#         #its an inverse loop
#         cls = el.className
#         if cls
#           cls = cls.split(' ')
#           if -1 != cls.indexOf('card-work')
#             return el
#             break
#         unless el = el.parentNode
#           break
#     return
#
#   scaleCard = (e) ->
#     el = closest(e)
#     target = el
#     id = target.getAttribute('data-popup-id')
#     popup = getPopup(id)
#     size = getDifference(target, popup)
#     target.style[Modernizr.prefixed('transitionDuration')] = '0.5s'
#     target.style[Modernizr.prefixed('transitionTimingFunction')] = 'cubic-bezier(0.4, 0, 0.2, 1)'
#     target.style[Modernizr.prefixed('transitionProperty')] = addDashes(Modernizr.prefixed('transform'))
#     target.style['borderRadius'] = 0
#     transformCard target, size
#     onAnimated target, popup
#     onPopupClick target, popup
#     return
#
#   onAnimated = (card, popup) ->
#     card.addEventListener transEndEventName, ->
#       card.style['opacity'] = 0
#       popup.style['visibility'] = 'visible'
#       popup.style['zIndex'] = 9999
#       card.removeEventListener transEndEventName, transitionEnded
#       return
#     return
#
#   onPopupClick = (card, popup) ->
#     popup.addEventListener 'click', ((e) ->
#       size = getDifference(popup, card)
#       card.style['opacity'] = 1
#       card.style['borderRadius'] = '6px'
#       hidePopup e
#       transformCard card, size
#       return
#     ), false
#     return
#
#   hidePopup = (e) ->
#     e.target.style['visibility'] = 'hidden'
#     e.target.style['zIndex'] = 2
#     return
