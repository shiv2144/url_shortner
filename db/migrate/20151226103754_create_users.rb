class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :api_token
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
