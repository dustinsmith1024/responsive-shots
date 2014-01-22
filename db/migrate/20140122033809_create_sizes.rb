class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.string :slug
      t.string :display
      t.string :icon
      t.boolean :primary
      t.integer :height
      t.integer :width

      t.timestamps
    end
  end
end
