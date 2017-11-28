# frozen_string_literal: true

module Projects
  class ScheduleSetupsJob < ApplicationJob
    queue_as :default

    def perform
      Project.pending_setup.find_each do |project|
        SetUpJob.perform_later project
      end
    end
  end
end
