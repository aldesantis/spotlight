# frozen_string_literal: true

module Analyses
  class Perform < ApplicationOrganizer
    accept :analysis
    required :analysis

    delegate :project, :commit, to: :analysis

    organize MarkRunning, Checkout, ParseConfig, MarkCompleted

    around :handle_errors

    private

    # rubocop:disable Lint/RescueWithoutErrorClass
    def handle_errors(interactor)
      interactor.call
    rescue => e
      analysis.update! status: :failed

      project.octokit.create_status(
        project.repo_uri,
        commit,
        'error',
        context: ENV.fetch('GITHUB_CONTEXT'),
        description: 'Spotlight could not analyze your commit.'
      )

      raise e
    end
    # rubocop:enable Lint/RescueWithoutErrorClass
  end
end
