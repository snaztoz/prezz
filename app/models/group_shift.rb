# frozen_string_literal: true

class GroupShift < ApplicationRecord
  include Archivable

  belongs_to :app_group, class_name: "Group", foreign_key: "group_id"
  belongs_to :shift
end
