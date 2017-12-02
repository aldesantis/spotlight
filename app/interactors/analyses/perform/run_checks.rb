# frozen_string_literal: true

module Analyses
  class Perform < ApplicationOrganizer
    class RunChecks < ApplicationInteractor
      accept :analysis
      required :analysis

      def call
        sleep 10 unless Rails.env.test?
      end
    end
  end
end
