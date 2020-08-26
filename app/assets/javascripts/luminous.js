$(document).on('turbolinks:load', function () {
  if($('.itemdetail-background').length){
    var luminousTrigger = document.querySelectorAll('.luminous');
    var galleryOpts = {
      // Whether pressing the arrow keys should move to the next/previous slide.
      arrowNavigation: true
    };
    if( luminousTrigger !== null ) {
        new LuminousGallery(luminousTrigger, galleryOpts);
    }
  }
});
$(document).on("click", ".luminous", function(){
  $('.lum-lightbox').css('background-color', 'rgba(0, 0, 0, 0.7)').css('z-index','10');
});