class CreateAvLibs < ActiveRecord::Migration
  def change
    create_table :av_libs do |t|
      t.string :av_title
      t.string :av_type
      t.string :av_duration
      t.string :av_poster
      t.string :av_source
      t.string :av_introduction

      t.timestamps
    end
  end
end
