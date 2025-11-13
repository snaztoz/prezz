# frozen_string_literal: true

class Shift < ApplicationRecord
  include Archivable

  belongs_to :tenant
end
