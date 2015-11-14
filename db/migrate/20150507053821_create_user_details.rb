class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.integer :user_id
      t.string :avatar
      t.string :nick_name
      t.string :iphone
      t.string :qq
      t.string :web_style, default: 'sidebar-mini wysihtml5-supported skin-blue'

      t.timestamps
    end
  end
end
