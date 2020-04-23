# frozen_string_literal: true

task default: %i[test lint]

desc 'Run minitest test suite'
task :test do
  require 'minitest/pride'
  Dir.glob('./test/**/*_test.rb').sort.each { |file| require file }
end

desc 'Lint Ruby files with Rubocop'
task :lint do
  system 'rubocop .'
end
