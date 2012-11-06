class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :email
      t.string :user_name
      t.string :ip
      t.string :comment

      t.timestamps
    end
  end
end
