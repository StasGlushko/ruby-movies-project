class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :name
      t.text :description
      t.date :release_date
      t.string :director
      t.integer :length

      t.timestamps
    end
  end
end
