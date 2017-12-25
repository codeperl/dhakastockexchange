require 'rake'
require 'hanami/rake_tasks'
require 'rake/testtask'

desc 'Fetch and insert update for share of Dhaka Stock Exchange'
task update_share_information: :environment do
  AddShares.new.call
end

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs    << 'spec'
  t.warning = false
end

task default: :test
task spec: :test
