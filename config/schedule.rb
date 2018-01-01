# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']

every '*/2 10-15 * * 0-5' do
  rake 'DSE:update_share_information'
end

=begin
 # FOR TEST PURPOSE
every '* * * * 0-5' do
  rake 'DSE:update_share_information'
end
=end

every '59 9 * * 0-5' do
  rake 'DSE:clear_last_date_share_information'
end