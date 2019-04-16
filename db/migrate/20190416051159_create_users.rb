class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :nickname
      t.string :encrypted_password

      t.timestamps
    end
  end
end
