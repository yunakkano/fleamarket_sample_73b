$(document).on('turbolinks:load', function () {
    $("#reveal_password").on('click',function() {
        if ($("#user_password").attr('type') === 'password') {
            $("#user_password").attr('type', 'text');
            $("#user_password_confirmation").attr('type', 'text');
            $(".icon-check").css('background','#000');
        } else {
            $("#user_password").attr('type', 'password');
            $("#user_password_confirmation").attr('type', 'password');
            $(".icon-check").css('background','#fff');
        }
    });
});