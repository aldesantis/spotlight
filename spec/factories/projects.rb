# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    repo_provider { Project.repo_provider.values.sample }
    sequence(:repo_uri) { |n| "my-org/project-#{n}" }
    oauth_access_token { SecureRandom.hex }
  end
end
