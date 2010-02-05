require 'thor'
require File.join(File.dirname(__FILE__),'..','lib','yogo_launcher')
require 'yogo_launcher/command'

YogoLauncher::Command.namespace('yogo:install')