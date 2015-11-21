class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :column_id
      t.integer :recommend, default: 0
      t.integer :video_type
      t.string :tv_code, null:false
      t.string :title
      t.string :cover
      t.string :duration
      t.text :summary

      t.timestamps null: false
    end

    add_index :videos, :tv_code,  unique: true
  end
end
