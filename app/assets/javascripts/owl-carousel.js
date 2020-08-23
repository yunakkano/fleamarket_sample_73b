$(document).on('turbolinks:load', function () {
    if($('.itemdetail-background').length !==0 ){
        var owl = $('.owl-carousel');
        owl.owlCarousel({
            loop: false,
            mouseDrag: true,
            margin:0,
            nav:  false,
            dots: true,
            //owl-dotsを%ul#slide-control-boxに格納し、スライドを操作できるように設定
            dotsContainer: '#slide-control-box',
            autoWidth:true,
            autoplayHoverPause:true
        });
        //マウスオーバーだけで商品画像がスライド
        $('.owl-dot').hover(function () {
            owl.trigger('to.owl.carousel', [$(this).index(), 300]);
        },function(){});

        let ctrl = document.getElementById("slide-control-box");
        ctrl.addEventListener("mouseover", function( event ) {
            event.target.style.opacity = 1;
        }, false);
        ctrl.addEventListener("mouseout", function( event ) {
            event.target.style.opacity = 0.7;
        }, false);
    }
});
