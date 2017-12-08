# frozen_string_literal: true

module Checks
  module Naming
    class EndpointTitle < Checks::Naming::Base
      ERROR = "Endpoint '%<actual>s' should be named '%<expected>s'"

      def call
        context.errors = []

        swagger['paths'].each_value do |path|
          path.except('parameters').each_value do |endpoint|
            expected = titleize(endpoint['summary'])
            actual = endpoint['summary']

            next unless expected != actual
            context.errors << format(ERROR, actual: actual, expected: expected)
          end
        end
      end
    end
  end
end
