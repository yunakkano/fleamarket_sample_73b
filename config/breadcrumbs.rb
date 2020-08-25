crumb :root do
  link "フリマ", root_path
end

crumb :category do
  link "カテゴリー一覧", categories_path
end

crumb :parent_category do |category|
  category = Category.find(params[:id]).root
  link "#{category.root.category}", category_path(category)
  parent :category
end

crumb :child_category do |category|
  category = Category.find(params[:id])
  link "#{category.parent.category}", category_path(category)
  parent :parent_category
end

crumb :grandchild_category do |category|
  category = Category.find(params[:id])
  link "#{category.category}", category_path(category)
  parent :child_category
end

crumb :item_detail do |item|
  @item = Item.find_by(id:params[:id])
  link "#{@item.name}"
  parent :root
end

crumb :mypage do
  link "マイページ", user_path(current_user.id)
end

crumb :notice do
  link "お知らせ", user_path(current_user.id)
  parent :mypage
end

crumb :favarites do
  link "いいね一覧", favorites_user_path(current_user.id)
  parent :mypage
end

crumb :user_on_sale_items do
  link "出品した商品 - 出品中", user_on_sale_items_path(current_user.id)
  parent :mypage
end

crumb :sold_items do
  link "出品した商品 - 売却済み", user_sold_items_path(current_user.id)
  parent :mypage
end

crumb :purchased_items do
  link "購入した商品 - 過去の取引", user_purchased_items_path(current_user.id)
  parent :mypage
end

crumb :self_introduction do
  link "プロフィール", new_user_self_introduction_path(current_user.id)
  parent :mypage
end

crumb :edit_user_sending_destination do
  link "発送元・お届け先住所変更", edit_user_sending_destination_path(current_user.id, current_user.sending_destination.id)
  parent :mypage
end

crumb :user_cards do
  link "支払い方法", user_cards_path(current_user.id)
  parent :mypage
end

crumb :email_password do
  link "メール/パスワード", edit_user_registration_path
  parent :mypage
end

crumb :user_profile do
  link "本人情報", edit_user_profile_path(current_user.id, current_user.profile.id)
  parent :mypage
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).