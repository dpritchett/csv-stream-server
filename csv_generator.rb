# frozen_string_literal: true

require 'csv'

class CSVGenerator
  def generate(row_limit = 1_000_000, wait_secs = 0.00)
    Enumerator.new do |enum|
      (1 + row_limit).times do
        r = CSV.generate_line next_row
        enum.yield r
        sleep wait_secs
      end
    end
  end

  def next_row
    @counter ||= 0
    out = @counter.zero? ? header : body_line
    @counter += 1
    out
  end

  def header
    %w[alpha bravo charlie delta echo fox"trot]
  end

  def body_line
    header.count.times.map { rand(10..1000) }
  end
end
