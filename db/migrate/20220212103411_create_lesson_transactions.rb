class CreateLessonTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :lesson_transactions do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.string :currency
      t.integer :price
      t.datetime :expired_time

      t.timestamps
    end
  end
end
