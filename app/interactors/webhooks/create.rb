# frozen_string_literal: true

module Webhooks
  class Create < ApplicationInteractor
    accept :project
    required :project

    def call
      webhook = project.octokit.create_hook(
        project.repo_uri,
        'web',
        url: Rails.application.routes.url_helpers.push_webhook_url(
          host: ENV.fetch('HOST'),
          protocol: ENV.fetch('PROTOCOL')
        ),
        content_type: 'json',
        events: ['push'],
        active: true
      )

      project.update! webhook_id: webhook.id
    end
  end
end
