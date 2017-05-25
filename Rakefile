require 'rake'
require 'hanami/rake_tasks'
require 'rake/testtask'

Dir['lib/tasks/**/*.rake'].each { |filepath| load filepath }

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs    << 'spec'
  t.warning = false
end

task default: :test
task spec: :test
