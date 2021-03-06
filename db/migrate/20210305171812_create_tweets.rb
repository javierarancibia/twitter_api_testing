class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :content
      t.string :hashtag
      t.string :user

      t.timestamps
    end
  end
end
