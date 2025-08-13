class CreateRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.boolean :is_default_admin, default: false

      t.timestamps
    end
  end
end
