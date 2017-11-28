# frozen_string_literal: true

module Projects
  class SetUp < ApplicationInteractor
    accept :project
    required :project

    def call
      Webhooks::Create.call! project: project

      project.update! set_up_at: Time.zone.now
    end
  end
end
