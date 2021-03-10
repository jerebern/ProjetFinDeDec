class Command < ApplicationRecord
    VALID_STATES = ['Payé', 'Envoyé', 'Livré']
    validates :sub_total, presence: true
    validates :tps, presence: true
    validates :tvq, presence: true
    validates :total, presence: true
    validates :state, inclusion: {in: VALID_STATES}
    validates :shipping_adress, presence: true, allow_blank: false
    has_many   :command_products
    belongs_to :user
end
