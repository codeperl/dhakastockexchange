require 'rake'
require 'hanami/rake_tasks'
require 'rake/testtask'

namespace :DSE do
  desc 'Fetch and insert update for share'
  task update_share_information: :environment do
    PublishSharesUpdates.new.call('/messages/all', AddShares.new.call.shares)
  end

  desc 'Clear last date share information'
  task clear_last_date_share_information: :environment do
    ClearLastDateShares.new.call
  end
end

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs    << 'spec'
  t.warning = false
end

task default: :test
task spec: :test
