# frozen_string_literal: true

require 'minitest/autorun'
require './csv_generator'

describe CSVGenerator do
  subject { CSVGenerator.new }

  describe :header do
    it 'has fields' do
      actual = subject.header
      assert_includes actual, 'bravo'
    end
  end

  describe :body_line do
    it 'has numbers' do
      actual = subject.body_line

      assert_equal subject.header.count, actual.count

      assert_kind_of Numeric, actual.sample
      assert_kind_of Numeric, actual.sample
    end
  end

  describe :line do
    it 'generates lines' do
      actual = subject.line
      assert_equal subject.header, actual

      actual = subject.line
      assert_kind_of Numeric, actual.sample
      assert_kind_of Numeric, actual.sample
    end
  end

  describe :generate do
    let(:limit) { 100 }
    let(:gen) { subject.generate limit }

    it 'generates numeric lines after printing a header' do
      assert_includes gen.next, 'delta'

      refute_includes gen.next, 'delta'
      assert_match /[0-9]/, gen.next
    end
  end
end
