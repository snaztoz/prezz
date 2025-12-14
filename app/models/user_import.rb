# frozen_string_literal: true

class UserImport < ApplicationRecord
  belongs_to :organization
  has_one_attached :file

  enum :status, %i[ waiting processing success failed ], validate: true

  validates :file,
    attached: true,
    limit: { min: 1, max: 1 },
    content_type: :csv,
    size: { less_than: 500.kilobytes }

  scope :where_status, ->(status) {
    if %w[ waiting processing success failed ].include?(status)
      where(status:)
    end
  }

  after_commit :process, on: :create

  def csv
    @csv ||= file.open { |f| CSV.parse(f.read, headers: true) }
  end

  private

  def process
    UserImportJob.perform_later(self)
  end
end
