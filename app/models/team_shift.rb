# frozen_string_literal: true

class TeamShift < ApplicationRecord
  include Archivable

  belongs_to :app_team, class_name: "Team", foreign_key: "team_id"
  belongs_to :shift
end
