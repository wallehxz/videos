class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :video_id
      t.integer :reply_id
      t.integer :vote
      t.text :content

      t.timestamps null: false
    end
  end
end
