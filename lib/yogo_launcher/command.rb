require 'thor'
load File.join(YogoLauncher::YOGO_LAUNCHER_HOME,'tasks','yogo.thor')
module YogoLauncher
    class Command < Thor
      include Thor::Actions
      argument :path, :optional => true, :default => '.'
            
      desc "start", "Start the yogo installation at PATH"
      def start
        require 'jettr'
        require 'jettr/command'
        
        expected_dirs = ['yogo','persvr'].map{|dir| File.expand_path(File.join(path, dir))}
        found_dirs = expected_dirs.inject([]){|dirs_found, dir| dirs_found | Dir[dir]}
        missing_dirs = expected_dirs - found_dirs
        unless missing_dirs.empty?
          puts "No yogo install was found at #{File.expand_path(path)}"
          exit 1
        end
        
        rails_cmd = Jettr::Command.new([])
        persvr_cmd = Jettr::Command.new([], :port => 8080)
        inside File.join(path,'persvr') do
          persvr_cmd.invoke(:start)
        end
        inside File.join(path,'yogo') do
          rails_cmd.invoke(:start)
        end
      end
      
      desc "create", "Create a yogo installation at PATH"
      def create
        require 'persvr'
        require 'persvr/command'
        inside path do
          persvr = Persvr::Command.new
          persvr.invoke(:create, ['persvr'])
          
          yogo = Yogo::Build.new(['yogo'], :type => 'package')
          yogo.invoke(:complete)
          create_file 'yogo/jettr.yml', FILES['yogo_jettr.yml']
        end
        
      end
      
FILES = {}
FILES['yogo_jettr.yml'] = <<-JETTR
server:
  port: 3000
apps:
  - type: rails
    app_path: '.'
    app_uri: '/'
    rails:
      environment: 'production'
JETTR
    end
end
