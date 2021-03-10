class Command < ApplicationRecord
    VALID_STATES = ['Payé', 'Envoyé', 'Livré']
    validates :sub_total, presence: true
    validates :tps, presence: true,numericality: {greater_than_or_equal_to:1}
    validates :tvq, presence: true,numericality: {greater_than_or_equal_to:1}
    validates :total, presence: true,numericality: {greater_than_or_equal_to:1}
    validates :state, inclusion: {in: VALID_STATES}
    validates :shipping_adress, presence: true, allow_blank: false
    has_many   :command_products
    belongs_to :user
end
