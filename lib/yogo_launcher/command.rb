require 'thor'
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
          
          # puts "Source Paths: #{source_paths}"
          #           puts destination_root
          #           puts relative_to_original_destination_root(destination_root, false)
          #           puts find_in_source_paths('resource/yogo_app')
          #           directory 'yogo_app'
        end
        directory 'yogo_app', File.join(path,'yogo')
        copy_file 'yogo_jettr.yaml', File.join(path,'yogo','jettr.yaml')
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
