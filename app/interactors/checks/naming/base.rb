# frozen_string_literal: true

module Checks
  module Naming
    class Base < Checks::Base
      SMALL_WORDS = %w[a an and as at but by en for if in of on or the to v v. via vs vs.].freeze

      protected

      def titleize(str)
        str.split(' ').map do |word|
          # Word is all uppercase, like 'ETA'.
          next word if word.upcase == word

          # Word is a small word, like 'by'.
          next word.downcase if word.downcase.in?(SMALL_WORDS)

          # Word is a regular word.
          word.capitalize
        end.join(' ')
      end
    end
  end
end
