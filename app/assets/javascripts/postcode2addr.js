$(document).on('turbolinks:load', function(){
    $("#sending_destination_post_code").jpostal({
        postcode : [ "#sending_destination_post_code" ],
        address  : {
            "#sending_destination_prefecture_code" : "%3",
            "#sending_destination_city" : "%4",
            "#sending_destination_street_number" : "%5%6%7"
        }
  });
});