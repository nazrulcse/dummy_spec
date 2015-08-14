class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.boolean :status

      t.timestamps null: false
    end
  end
end
