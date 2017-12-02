require 'clockwork'

require './config/boot'
require './config/environment'

module Clockwork
  handler do |job|
    "#{job.tr('.', '/').camelize}Job".constantize.perform_later
  end

  every(10.seconds, 'projects.schedule_setups')
  every(5.seconds, 'analyses.schedule')
end
