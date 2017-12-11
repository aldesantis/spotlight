# frozen_string_literal: true

module Analyses
  class MarkFailure < ApplicationInteractor
    accept :analysis, :message
    required :analysis, :message

    def call
      analysis.update! status: :failed

      analysis.project.octokit.create_status(
        analysis.project.repo_uri,
        analysis.commit,
        'error',
        context: ENV.fetch('GITHUB_CONTEXT'),
        description: message
      )
    end
  end
end
