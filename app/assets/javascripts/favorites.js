$('.show-favLink__icon').on('click', function() {
  let $btn = $(this);
  if ($btn.hasClass('on')) {
    $btn.removeClass('on');
    $btn.children("i").attr('class', 'show-favLink__icon');
  } else {
    $btn.addClass('on');
    $btn.children("i").attr('id', 'LikeIcon');
  }
});