# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :analyses, inverse_of: :project, dependent: :destroy

  enumerize :repo_provider, in: %i[github]

  attribute :oauth_access_token
  attr_encrypted :oauth_access_token, key: ENV.fetch('ENCRYPTION_KEY')

  scope :pending_setup, -> { where 'set_up_at IS NULL' }

  def octokit
    Octokit::Client.new(access_token: oauth_access_token)
  end

  def base_path
    Rails.root.join('tmp', 'analyses', id).to_s
  end
end
