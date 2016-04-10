require File.expand_path(File.dirname(__FILE__) + "/../test_helper")
require 'artoo/drivers/mpu6050'

describe Artoo::Drivers::Mpu6050 do
  before do
    @device = mock('device')
    @driver = Artoo::Drivers::Mpu6050.new(:parent => @device)
  end

  it 'must do things'
end
