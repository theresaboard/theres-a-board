class UpdateUser < ActiveRecord::Migration
  change_table :users do |t|
    t.boolean :email_notify, null: false, default: true
    t.boolean :text_notify, null: false, default: false
    t.string  :cellphone, limit: 15
  end
end
