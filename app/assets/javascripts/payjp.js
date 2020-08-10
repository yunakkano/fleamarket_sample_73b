$(document).on('turbolinks:load', function () {
    Payjp.setPublicKey("pk_test_edb1398ecec5f03fc683f0fe");
    var form = $("#payjp_cardForm");
      number = form.find("#payjp_cardNum"),
      cvc = form.find("#payjp_cardCVC"),
      exp_month = form.find("#payjp_cardExpMonth"),
      exp_year = form.find("#payjp_cardExpYear");
  
    $("#payjp_cardForm").on("click", "#addCard", function (e) {
      e.preventDefault();
      form.find("input[type=submit]").prop("disabled", true);
      var card = {
        number:     number.val(),
        cvc:        cvc.val(),
        exp_month:  exp_month.val(),
        exp_year:   exp_year.val()
      };
      Payjp.createToken(card, function (status, response) {
        console.log("creating token")
        if (response.error) {
          alert("error")
          form.find('button').prop('disabled', false);
        }
        else {
          $("#payjp_cardNum").removeAttr("name");
          $("#payjp_cardCVC").removeAttr("name");
          $("#payjp_cardExpMonth").removeAttr("name");
          $("#payjp_cardExpYear").removeAttr("name");
  
          var token = response.id;
          $("#payjp_cardForm").append(`<input type="hidden" name="card_token" class="payjp-token" value=${token} />`)
          $("#payjp_cardForm").get(0).submit();
        }
      });
    });
  });