class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :role
      t.string :token
      t.string :username
      t.string :password_reset_token
      t.bigint :mobile_no
      t.integer :verification_code
      t.decimal :latitude
      t.decimal :longitude
      t.boolean :status, default: false
      t.boolean :email_confirmed, default: false

      t.timestamps
    end
  end
end
