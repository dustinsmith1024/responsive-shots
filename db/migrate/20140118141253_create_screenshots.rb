class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.integer :height
      t.integer :width
      t.string :file
      t.references :message

      t.timestamps
    end
  end
end
