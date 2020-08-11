$(document).on('turbolinks:load', function () {
  var luminousTrigger = document.querySelectorAll('.luminous');
  if( luminousTrigger !== null ) {
      new LuminousGallery(luminousTrigger);
  }
});
$(document).on("click", ".luminous", function(){
  $('.lum-lightbox').css('background-color', 'rgba(0, 0, 0, 0.7)').css('z-index','10');
});