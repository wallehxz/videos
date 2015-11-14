class CreateVideoComments < ActiveRecord::Migration
  def change
    create_table :video_comments do |t|
      t.integer :channel_video_id
      t.integer :user_id
      t.integer :reply_id
      t.integer :vote_count
      t.text :content

      t.timestamps
    end
    add_index :video_comments, :id
  end
end
