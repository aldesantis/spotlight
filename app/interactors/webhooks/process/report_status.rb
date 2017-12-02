# frozen_string_literal: true

module Webhooks
  class Process < ApplicationOrganizer
    class ReportStatus < ApplicationInteractor
      accept :project, :commit
      required :project, :commit

      def call
        project.octokit.create_status(
          project.repo_uri,
          commit,
          'pending',
          context: ENV.fetch('GITHUB_CONTEXT'),
          description: 'Spotlight has queued your analysis.'
        )
      end
    end
  end
end
