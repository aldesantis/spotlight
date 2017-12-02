# frozen_string_literal: true

module Projects
  class SetUpJob < ApplicationJob
    queue_as :default

    def perform(project)
      Projects::SetUp.call! project: project
    end
  end
end
