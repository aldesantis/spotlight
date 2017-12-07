# frozen_string_literal: true

module Checks
  module Naming
    class GroupTitle < Checks::Naming::Base
      ERROR = "Group '%<actual>s' should be named '%<expected>s'"

      def call
        context.errors = []

        context.swagger['x-stoplight']['version']['groups']['docs'].each do |group|
          expected = titleize(group['name'])
          actual = group['name']

          next unless expected != actual

          context.errors << format(ERROR, actual: actual, expected: expected)
        end
      end
    end
  end
end
