desc "Configure and build the yogo rails app"
task :yogo_app => 'yogo:setup'
namespace :yogo do    
  file "resource/yogo_app" do |t|
    sh "thor yogo:build:complete #{t.name} -t package"
  end
  
  CLEAN.include "resource/yogo_app"
  
  task :setup => "resource/yogo_app"
end