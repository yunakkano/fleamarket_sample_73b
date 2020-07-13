class ChangeAncestryRestrictionOnCategory < ActiveRecord::Migration[5.2]
  def change
    change_column_null :categories, :ancestry, true
  end
end
