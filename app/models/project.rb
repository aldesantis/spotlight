# frozen_string_literal: true

class Project < ApplicationRecord
  enumerize :repo_provider, in: %i[github]

  attribute :oauth_access_token
  attr_encrypted :oauth_access_token, key: ENV.fetch('ENCRYPTION_KEY')
end
