# frozen_string_literal: true

class TeamShift < ApplicationRecord
  include Archivable

  belongs_to :team
  belongs_to :shift
end
