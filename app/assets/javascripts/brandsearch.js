var brand_select_field = $("#brand_select_field");

function buildBrandsList(brands) {
  let brand_options = "";
  brands.forEach(function(brand){
    brand_options += `<li class="brand_list-item" value="${brand.id}">${brand.brand}</li>`;
  });
  return brand_options
}

$(document).on("keyup", "#brand_name_field", function(event){
  var brands_matched = $("#brands_matched");
  var input = $("#brand_name_field").val();
  var p_id = $("#category_form").val();
  var c_id = $(".child_category_id").val();
  var gc_id = $(".gc_category_id").val();
  if(p_id>0 && c_id>0 && gc_id>0){
    $.ajax({
      type: 'GET',
      url: '/items/brand_searches',
      data: { 
        keyword:            input,
        parent_id:          p_id,
        children_id:        c_id,
        grandchildren_id:   gc_id
      },
      dataType: 'json'
    })
    .done(function(brands) {
      brands_matched.empty();
      $("#brand_select_field").val("");
      if (brands.length !== 0) {
        brands_matched.append(buildBrandsList(brands));
        // リストのブランド候補上にマウスを移動するとアクティブにする
        $(".brand_list-item").hover(function(){
          $(this).addClass("active");
        }, function() {
          $(this).removeClass("active");
        });
        // リストのブランド候補をクリックしたら、値をinputにセットしてリストを消す
        $(".brand_list-item").on('click',function(){
          $("#brand_name_field").val($(this).text());
          $("#brand_select_field").val($(this).val());
          brands_matched.empty();
        });
      }
    })
  }
});