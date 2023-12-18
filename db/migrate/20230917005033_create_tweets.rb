class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :target
      t.date :deadline
      t.text :about
      t.string :image

      t.timestamps
    end
  end
end
