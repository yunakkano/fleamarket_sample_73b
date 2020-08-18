$(document).on('turbolinks:load', function () {
    var owl = $('.owl-carousel');
    owl.owlCarousel({
        loop: true,
        rewind: true,
        mouseDrag: true,
        margin:0,
        nav:false,
        dots:false,
        autoWidth:true,
        URLhashListener:true,
        autoplayHoverPause:true,
        startPosition: 'URLHash',
    });
    let ctrl = document.getElementById("slide-control-box");
    ctrl.addEventListener("mouseover", function( event ) {
        event.target.style.opacity = 1;
    }, false);
    ctrl.addEventListener("mouseout", function( event ) {
        event.target.style.opacity = 0.7;
    }, false);
});
