# frozen_string_literal: true

class ShiftFutureOccurencesGenerationJob < ApplicationJob
  queue_as :default

  def perform(shift)
    ActiveRecord::Base.transaction do
      Shift::FutureOccurencesRemoval.remove_for(shift)
      Shift::FutureOccurencesGeneration.generate_for(shift)
    end
  end
end
