# frozen_string_literal: true

class UserImport < ApplicationRecord
  belongs_to :tenant
  has_one_attached :file

  enum :status, %i[ waiting processing success failed ], validate: true

  validates :file,
    attached: true,
    limit: { min: 1, max: 1 },
    content_type: :csv,
    size: { less_than: 2.megabytes }
end
