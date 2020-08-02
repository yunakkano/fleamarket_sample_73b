$(document).on('turbolinks:load', function(){
  $(function(){

    function buildHTML(count) {
      var html = `<div class="preview-box" id="preview-box__${count}">
                    <div class="upper-box">
                      <img src="" alt="preview">
                    </div>
                    <div class="lower-box">
                      <div class="update-box">
                        <label class="edit_btn">編集</label>
                      </div>
                      <div class="delete-box" id="delete_btn_${count}">
                        <span>削除</span>
                      </div>
                    </div>
                  </div>`
      return html;
    }

    function setLabel() {
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
    }

    $(document).on('change', '.hidden-field', function() {
      setLabel();
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      $('.label-box').attr({id: `label-box--${id}`,for: `item_item_imgs_attributes_${id}_url`});
      var file = this.files[0];
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function() {
        var image = this.result;
        if ($(`#preview-box__${id}`).length == 0) {
          var count = $('.preview-box').length;
          var html = buildHTML(id);
          var prevContent = $('.label-content').prev();
          $(prevContent).append(html);
        }
        $(`#preview-box__${id} img`).attr('src', `${image}`);
        var count = $('.preview-box').length;
        if (count == 5) { 
          $('.label-content').hide();
        }

        setLabel();
        if(count < 5){
          $('.label-box').attr({id: `label-box--${count}`,for: `item_item_imgs_attributes_${count}_url`});
        }
      }
    });

    $(document).on('click', '.delete-box', function() {
      var count = $('.preview-box').length;
      setLabel(count);
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      $(`#preview-box__${id}`).remove();
      console.log("new")
      $(`#item_images_attributes_${id}_image`).val("");

      var count = $('.preview-box').length;
      if (count == 4) {
        $('.label-content').show();
      }
      setLabel(count);

      if(id < 5){
        $('.label-box').attr({id: `label-box--${id}`,for: `item_item_imgs_attributes_${id}_url`});
      }
    });
  });
})

// 商品出品ページ > カテゴリ選択機能

function build_childSelect() {
  let child_select = `
      <select name="item[category_id]" class="child_category_id select_field">
        <option value="">選択してください</option>
      </select>
      `
  return child_select;
}

function build_option(children) {
  let option_html = `
      <option value=${children.id}>${children.category}</option>
      `
  return option_html;
}

function build_gcSelect() {
  let gc_select = `
      <select name="item[category_id]" class="gc_category_id select_field">
        <option value="">選択してください</option>
      </select>
      `
  return gc_select;
}

$(document).on("change", "#category_form", function(){
  let parentValue = $("#category_form").val();
  if (parentValue.length != 0) {
    $.ajax({
      url: '/items/search',
      type: 'GET',
      data: { parent_id: parentValue },
      dataType: 'json'
    })
      .done(function (data) {
        $(".child_category_id").remove();
        let child_select = build_childSelect
        $("#category_field").append(child_select);
        data.forEach(function(d) {
          let option_html = build_option(d)
          $(".child_category_id").append(option_html)
        })
      })
      .fail(function () {
        alert("通信エラーです");
      });
  }
});

$(document).on("change", ".child_category_id", function(){
  $(".gc_category_id").remove();
  let childValue = $(".child_category_id").val();
  console.log(childValue);
  if (childValue.length != 0) {
    $.ajax({
      url: '/items/search',
      type: 'GET',
      data: { children_id: childValue },
      dataType: 'json'
    })
      .done(function (gc_data) {
        let gc_select = build_gcSelect
        $("#category_field").append(gc_select);
        gc_data.forEach(function(gc_d) {
          let option_html = build_option(gc_d)
          $(".gc_category_id").append(option_html)
        })
      })
      .fail(function () {
        alert("通信エラーです");
      });
  }
});

// topページ > headerカテゴリメニュー表示機能

$(document).ready(function() {

  $(".header-categories").hover(function() {
    $(this).addClass("active");
    let parent = $(".active").children(".header-category-parent");
    parent.show();
  }, function() {
    $(this).removeClass("active");
    $(this).children(".header-category-parent").hide();
  });

  $(".header-parent-list").hover(function() {
    $(this).addClass("active2");
    let child = $(".active2").children(".header-category-child");
    child.show();
  }, function() {
    $(this).removeClass("active2");
    $(this).children(".header-category-child").hide();
  });

  $(".header-child-list").hover(function() {
    $(this).addClass("active3");
    let grandchild = $(".active3").children(".header-category-grandchild");
    grandchild.show();
  }, function() {
    $(this).removeClass("active3");
    $(this).children(".header-category-grandchild").hide();
  });

});

// カテゴリ一覧ページ > スクロール機能

$(function () {
  // "#"クリックでイベント発火（categories/index > "##{i}"）
  $('a[href^="#"]').click(function() {
    let speed = 400;
    // this：クリックされたリンク要素
    let href = $(this).attr("href");
    // 三項目演算子（「条件式 ? A : B;」 *true -> A, false -> B） 
    let target = $(href == "#" || href == "" ? 'html' : href);
    let position = target.offset().top;
    $('body, html').animate({scrollTop:position}, speed, 'swing');
    return false;
  });
});
