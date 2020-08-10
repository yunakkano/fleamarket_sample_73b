class Category < ApplicationRecord
  has_many :items
  has_ancestry

  # カテゴリーが親or子or孫の内のどれに当たるかで条件分岐
  def set_items
    # 親カテゴリーの場合
    ## root?：レコードがルートであれば、trueを返す
    if self.root?
      ## indirects：孫レコード以下を返す
      start_id = self.indirects.first.id
      end_id = self.indirects.last.id
      # 自身が持つ孫カテゴリーのid範囲を指定して商品を取得
      items = Item.where(category_id: start_id..end_id)
      return items

    # 子カテゴリーの場合
    ## has_children?：レコードが子を持っていれば、trueを返す
    elsif self.has_children?
      start_id = self.children.first.id
      end_id = self.children.last.id
      items = Item.where(category_id: start_id..end_id)
      return items

    # 孫カテゴリーの場合
    else
      return self.items
    end
  end

end
