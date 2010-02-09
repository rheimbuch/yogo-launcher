require 'rake/clean'
Dir.glob('tasks/*.rake').each { |r| import r }

task :default => ["yogo:local_install", "yogo:package"]

CLEAN.include 'pkg/*'