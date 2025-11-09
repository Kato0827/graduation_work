class CreateStones < ActiveRecord::Migration[7.1]
  def change
    create_table :stones do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, foreign_key: true
      t.decimal :stone_size, precision: 3, scale: 1   # 石のサイズ（mm）
      t.date :record_date, null: false                # 記録日
      t.timestamps
    end
  end
end
