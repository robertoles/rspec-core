require 'spec_helper'
require 'stringio'

describe RSpec::Core::Formatters::ProgressFormatter do

   before do
     @output = StringIO.new
     @formatter = RSpec::Core::Formatters::ProgressFormatter.new(@output)
     @formatter.start(2)
     @formatter.stub!(:color_enabled?).and_return(false)
   end

   it "should produce line break on start dump" do
     @formatter.start_dump
     @output.string.should == "\n"
   end

   it "should produce standard summary without pending when pending has a 0 count" do
     @formatter.start_dump
     @formatter.dump_summary(0.00001, 2, 0, 0)
     @output.string.should =~ /2 examples, 0 failures/i
     @output.string.should_not =~ /0 pending/i
   end

   it "should push nothing on start" do
     @formatter.start(4)
     @output.string.should == ""
   end

end
