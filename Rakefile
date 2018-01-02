require 'rake'
require 'hanami/rake_tasks'
require 'rake/testtask'

namespace :DSE do
  desc 'Publish share updates'
  task publish_shares_updates: :environment do
    PublishSharesUpdates.new.call('/messages/all', AddShares.new.call.shares)
  end

  desc 'Clear updates of share at mid night'
  task clear_updates_of_shares_at_mid_night: :environment do
    ClearLastTimeShares.new.call
  end
end

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs    << 'spec'
  t.warning = false
end

task default: :test
task spec: :test
