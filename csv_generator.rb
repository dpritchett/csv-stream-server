require 'csv'

class CSVGenerator
  def generate(limit=100)
    Enumerator.new do |enum|
      limit.times do
        l = csvify(line)
        enum.yield l
        sleep 0.2
      end
    end
  end

  def line
    @counter ||= 0
    out = @counter.zero? ? header : body_line
    @counter += 1
    out
  end

  def header
    %w[alpha bravo charlie delta echo].map{ |n| "#{n}" }
  end

  def body_line
    header.count.times.map { rand(10..1000) }
  end

  def csvify(fields)
    fields
      .map { |el| "\"#{el}\"" }
      .join(',')
      .+("\n")
  end
end
