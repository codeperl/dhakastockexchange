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

# Publish share update in every 2 minutes.
every '*/2 10-15 * * 0-5' do
  rake 'DSE:publish_share_information'
end

# Clear share updates for previous day at mid night (12:00 AM)
every '0 0 * * 0-5' do
  rake 'DSE:clear_updates_of_share_at_mid_night'
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