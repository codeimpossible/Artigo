require 'ostruct'
class Admin::DebugController < ApplicationController
	layout "admin"
	def index
		#load the log files for the current environment
		env = "#{::Rails.root}/log/#{::Rails.env}.log"
		artigo = "#{::Rails.root}/log/artigo.log"
		db = "#{::Rails.root}/log/artigo_db.log"
		
		#if the logs are big this is going to be PAINFULLY slow...
		#should replace with a seek impl at some point
		@model = OpenStruct.new :env => IO.readlines(env)[-50..-1],
								:artigo => IO.readlines(artigo)[-50..-1],
								:db => IO.readlines(db)[-50..-1]
	end
end