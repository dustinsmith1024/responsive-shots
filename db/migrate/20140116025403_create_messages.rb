class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :description
      t.boolean :error
      t.string :token
      t.string :email
      t.string :url
      t.boolean :delivered

      t.timestamps
    end
  end
end
