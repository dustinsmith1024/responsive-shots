class AddSizeIdToScreenshot < ActiveRecord::Migration
  def change
    add_column :screenshots, :size_id, :integer
    remove_column :screenshots, :height, :integer
    remove_column :screenshots, :width, :integer
  end
end
