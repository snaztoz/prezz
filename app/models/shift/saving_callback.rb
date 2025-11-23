# frozen_string_literal: true

class Shift::SavingCallback
  def after_commit(shift)
    if affecting_future_occurences?(shift)
      ShiftFutureOccurencesGenerationJob.perform_later(shift)
    end
  end

  private

  def affecting_future_occurences?(shift)
    (shift.saved_changes.keys & triggering_keys).any?
  end

  def triggering_keys
    %w[ recurrence_rule effective_from effective_to start_time end_time ]
  end
end
