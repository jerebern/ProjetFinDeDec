class UserCommandsSummary < ApplicationRecord
    self.table_name = "user_commands_summary"
    before_validation do
        throw :abort
    end
end
