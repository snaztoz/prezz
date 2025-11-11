# frozen_string_literal: true

class UserImport::Row
  def initialize(row)
    @row = row
  end

  def attributes
    {
      full_name: row[0],
      employee_number: row[1],
      email_address: row[2],
      phone_number: row[3],
      password: row[3].gsub(/\D/, "")
    }
  end

  private

  attr_reader :row
end
