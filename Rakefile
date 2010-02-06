require 'rake/clean'
Dir.glob('tasks/*.rake').each { |r| import r }

task :default => ["yogo:local_package", "yogo:package"]

CLEAN.include 'pkg/*'