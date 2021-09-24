class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.string :description
      t.integer :moderater_id

      t.timestamps
    end
    add_index :subs, :moderater_id
  end
end
