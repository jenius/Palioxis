# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
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