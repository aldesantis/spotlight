# frozen_string_literal: true

module Webhooks
  class Process < ApplicationInteractor
    accept :payload
    required :payload

    def call
      repo_uri = payload['repository']['full_name']

      project = Project.find_by(
        repo_provider: :github,
        repo_uri: repo_uri
      )

      fail! :no_project, "Could not find project '#{repo_uri}'" unless project

      commit = payload['after']

      Analysis.create!(
        project: project,
        commit: commit
      )
    end
  end
end
