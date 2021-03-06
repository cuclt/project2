class CreateSuggests < ActiveRecord::Migration[5.0]
  def change
    create_table :suggests do |t|
      t.string :name
      t.float :price
      t.string :image
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
