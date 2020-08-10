$(document).on('turbolinks:load', function () {
  var luminousTrigger = document.querySelectorAll('.luminous');
  if( luminousTrigger !== null ) {
      new LuminousGallery(luminousTrigger);
  }
});
$(document).on("click", ".itemdetail__content__photo", function(){
  $('.lum-lightbox-image-wrapper').css('background-color', 'rgba(0, 0, 0, 0.7)');
});