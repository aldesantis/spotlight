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

  def full_repo_url
    case repo_provider.to_sym
    when :github
      "git://github.com/#{repo_uri}.git"
    else
      fail "Cannot construct repo URI for provider #{repo_provider}"
    end
  end

  def base_path
    Rails.root.join('tmp', 'analyses', id).to_s
  end
end
