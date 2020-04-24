# frozen_string_literal: true

require 'sinatra'
require 'sinatra/streaming'

require './csv_generator'

get('/') { stream_csv_file }

get('/numbers.csv') { stream_csv_file }

def stream_csv_file
  gen = CSVGenerator.new.generate

  stream do |out|
    gen.each do |line|
      out.puts line
      sleep 0
    end
  end
end
