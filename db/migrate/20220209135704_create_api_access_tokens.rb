class CreateApiAccessTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :api_access_tokens do |t|
      t.integer :user_id
      t.string :key
      t.datetime :expired_time

      t.timestamps
    end
  end
end
