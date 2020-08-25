$(document).on('turbolinks:load', function(){
// $(function (){
  function buildHTML(comment){
    var html = 
      `<div class="itemcomment__box__content__comment__member__list">
        ${comment.user_name}
        :
        ${comment.text}
      </div>`
    return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.itemcomment__box__content__comment__member').prepend(html)
      $('.textbox').val('');
      $('.form__submit').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  });
});