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
      out.print line
      sleep 0
    end
  rescue IOError => e
    warn "Error delivering CSV stream: #{e.class}, #{e.message}"
  end
end
