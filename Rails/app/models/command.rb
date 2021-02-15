class Command < ApplicationRecord
    validates :sub_total, presence: true
    validates :tps, presence: true
    validates :tvq, presence: true
    validates :total, presence: true
    validates :store_pickup, presence: true
    validates :state, presence: true, allow_blank: false
    validates :shipping_adress, presence: true, allow_blank: false
    validates :user_email, presence: true, allow_blank: false

end
