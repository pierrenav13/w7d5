class ChangeColumnNameOfSubs < ActiveRecord::Migration[5.2]
  def change
    rename_column :subs, :moderater_id, :moderator_id
  end
end
