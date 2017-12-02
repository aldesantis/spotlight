# frozen_string_literal: true

module Analyses
  class Perform < ApplicationOrganizer
    class MarkCompleted < ApplicationInteractor
      accept :analysis
      required :analysis

      delegate :project, :commit, to: :analysis

      def call
        project.octokit.create_status(
          project.repo_uri,
          commit,
          'success',
          context: ENV.fetch('GITHUB_CONTEXT'),
          description: 'Your API documentation is good!'
        )

        analysis.update! status: :completed
      end
    end
  end
end
