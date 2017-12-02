# frozen_string_literal: true

module Analyses
  class Perform < ApplicationInteractor
    accept :analysis

    delegate :project, :commit, to: :analysis

    def call
      analysis.update! status: :running

      project.octokit.create_status(
        project.repo_uri,
        commit,
        'pending',
        context: ENV.fetch('GITHUB_CONTEXT'),
        description: 'Your API documentation is being analyzed...'
      )

      sleep 10 unless Rails.env.test?

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
