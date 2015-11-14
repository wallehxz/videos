class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :title
      t.text :description
      t.string :english
      t.string :cover

      t.timestamps
    end
  end
end
