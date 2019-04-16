class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :body
      t.belongs_to :user, foreign_key: true
      t.belongs_to :question, foreign_key: true
      t.boolean :correct

      t.timestamps
    end
  end
end
