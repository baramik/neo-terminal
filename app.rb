require 'rubygems'
require 'bundler/setup'

ENV['APP_ENV'] ||= 'development'

Bundler.require(:default, ENV['APP_ENV'])
Dir[File.expand_path("lib/**/*.rb")].each {|file| require file }