require 'rspec/expectations'

RSpec::Matchers.define :fit do |expected|
  match do |actual|
    actual.fits_to?(expected)
  end
  failure_message do |actual|
    "expected that #{actual} would fit to #{expected}"
  end
end
