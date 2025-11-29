# frozen_string_literal: true

class UserImport::Row
  def initialize(row)
    @row = row
  end

  def attributes
    {
      full_name: row["Full Name"],
      employee_number: row["Employee Number"],
      email_address: row["Email Address"],
      phone_number: row["Phone Number"],
      team: row["Team"],
      password: row["Phone Number"].gsub(/\D/, "")
    }
  end

  private

  attr_reader :row
end
