# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  # ------------------------------------------------
  # Handle Stripe Forms
  # ------------------------------------------------

  Stripe.setPublishableKey $('meta[name=stripe-key]').attr('content')

  subscription =
    handleForm: ->
      $('#add_card form').submit ->
        $('input[type=submit]').attr 'disabled', true
        if $('#card_number').length
          subscription.processCard()
          false
        else
          true

    stripeCallback: (status, response) ->
      if status == 200
        console.log response
        $('#user_stripe_token').val(response.id)
        $('#stripe_token').val(response.id)
        $('#add_card form')[0].submit()
      else
        alert response.error.message
        $('input[type=submit]').attr('disabled', false)
    
    processCard: ->
      card =
        number: $('#card_number').val()
        cvc: $('#card_code').val()
        expMonth: $('#card_month').val()
        expYear: $('#card_year').val()

      Stripe.createToken card, subscription.stripeCallback
  
  subscription.handleForm()

  # ------------------------------------------------
  # Image Fader Plugin
  # ------------------------------------------------

  # this needs serious work and should extend jquery. temporary for now

  imgfade = (el, time) ->
    el.hover ->
      fadeover = $("<span class='fadeover' />")
      fadeover.css
        width: el.width(),
        height: el.height() - 2,
        position: 'absolute',
        top: 0,
        left: 0,
        'background-position': "0 -#{el.height() + 2 }px",
        display: 'none',
        'background-image': el.css('background-image')
        'z-index': 100
      fadeover.appendTo(el).fadeIn(time)
    , ->
      $('.fadeover').fadeOut time, ->
        $(this).remove()
  
  imgfade($('.h1'), 300)

  # ------------------------------------------------
  # Page Interaction
  # ------------------------------------------------

  $('.current-goals li').hover ->
    $(this).find('.actions').stop().fadeToggle(500)








