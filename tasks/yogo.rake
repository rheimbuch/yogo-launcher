require 'rake/packagetask'

namespace :yogo do    
  file "yogo" do
    sh "thor yogo:install:create"
  end
  
  file "persvr" do
    sh "thor yogo:install:create"
  end
  
  CLEAN.include ["yogo","persvr"]
  
  task :local_install => ['yogo','persvr']
  task :package => :local_install
  
  Rake::PackageTask.new("yogo-dist", :noversion) do |p|
    p.need_zip = true
    p.need_tar_gz = true
    p.package_files.include "bin/*", "lib/**/*", "tasks/*.thor", "templates/*", "vendor/**/*", "yogo/**/*", "persvr/**/*"
    p.package_files.exclude "vendor/gems/**/cache/*.gem"
  end
  
  
end