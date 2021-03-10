class UserCommandsSummary < ApplicationRecord
    self.table_name = "user_commands_summary"
    before_validation do
        throw :abort
    end
    attribute :email, :string
    attribute :fullname, :string
    attribute :unit_product_value_average, :string
    attribute :average_unit_per_product, :decimal
    attribute :minimum_command_value_sub_total, :decimal
    attribute :Average_command_value_sub_total, :decimal
    attribute :maximum_command_value_sub_total, :decimal
    attribute :total_command_value, :decimal
end
