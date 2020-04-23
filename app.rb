# frozen_string_literal: true

require 'sinatra'
require 'sinatra/streaming'

require './csv_generator'

get '/' do
  gen = CSVGenerator.new.generate

  stream do |out|
    gen.each do |line|
      out.puts line
      sleep 1
    end
  end
end
