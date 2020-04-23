require 'thin'
require 'rack'
require 'csv'
require 'json'

class App

  def initialize
    @counter = 0
  end

  def call(env)
    [200, { 'Content-Type' => 'application/json' }, body]
  end 

  def header
    %w[alpha bravo charlie delta echo].map{ |n| "#{n}" }
  end

  def line
    header.count.times.map { rand(10..1000) }
  end

  def body
    return enum_for :body unless block_given?

    lines.each do |l|
      c = csvify l
      pp c
      yield c
    end
  end

  def lines
    1000.times.map do
      current_line = @counter.zero? ? header : line
      @counter += 1
      current_line
    end
  end

  def csvify(fields)
    fields
      .map { |el| "\"#{el}\"" }
      .join(',')
      .+("\n")
  end
end
