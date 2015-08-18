require 'rspec/expectations'

RSpec::Matchers.define :fit do |expected|
  match do |actual|
    actual.fits_to?(expected)
  end
  failure_message_for_should do |actual|
    "expected that #{actual} would fit to #{expected}"
  end
end
