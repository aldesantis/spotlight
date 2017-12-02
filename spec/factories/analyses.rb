# frozen_string_literal: true

FactoryBot.define do
  factory :analysis do
    project
    commit { Digest::SHA1.hexdigest SecureRandom.hex }
    status { Analysis.status.values.sample }
  end
end
