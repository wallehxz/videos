class CreateColumns < ActiveRecord::Migration
  def change
    create_table :columns do |t|
      t.string :name
      t.string :english
      t.string :cover
      t.text :summary

      t.timestamps null: false
    end
  end
end
