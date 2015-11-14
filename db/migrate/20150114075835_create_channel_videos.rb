class CreateChannelVideos < ActiveRecord::Migration
  def change
    create_table :channel_videos do |t|
      t.integer :channel_id
      t.string :youku_id
      t.integer :is_recommend, default: 0
      t.integer :video_type, default: 0
      t.string :title
      t.text :content
      t.string :video_cover
      t.text :youku_json

      t.timestamps
    end
    add_index :channel_videos, :youku_id, unique: true
  end
end
