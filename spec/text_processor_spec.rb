require 'support/spec_helper'
require './text_processor'

RSpec.describe TextProcessor do
  describe "::new" do
    it "can be initialized" do
      subject.class.new
    end
  end
end
