require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # Mpu6050 gyro and accelerometer driver for i2c
    class Mpu6050 < Driver
      COMMANDS = [:heading].freeze

      attr_reader :heading

      MPU6050_RA_ACCEL_XOUT_H = 0x3B
      MPU6050_RA_PWR_MGMT_1 = 0x6B
      MPU6050_PWR1_CLKSEL_BIT = 2
      MPU6050_PWR1_CLKSEL_LENGTH = 3
      MPU6050_CLOCK_PLL_XGYRO = 0x01
      MPU6050_GYRO_FS_250 = 0x00
      MPU6050_RA_GYRO_CONFIG = 0x1B
      MPU6050_GCONFIG_FS_SEL_LENGTH = 2
      MPU6050_GCONFIG_FS_SEL_BIT = 4
      MPU6050_RA_ACCEL_CONFIG = 0x1C
      MPU6050_ACONFIG_AFS_SEL_BIT = 4
      MPU6050_ACONFIG_AFS_SEL_LENGTH = 2
      MPU6050_ACCEL_FS_2 = 0x00
      MPU6050_PWR1_SLEEP_BIT = 6
      MPU6050_PWR1_ENABLE_BIT = 0

      def address; 0x68; end

      def initialize(params={})
        @heading = 0.0
        super
      end

      def start_driver
        begin
          connection.i2c_start(address >> 1)
          # setClockSource
          connection.i2c_write([MPU6050_RA_PWR_MGMT_1,
                                MPU6050_PWR1_CLKSEL_BIT,
                                MPU6050_PWR1_CLKSEL_LENGTH,
                                MPU6050_CLOCK_PLL_XGYRO])

          # setFullScaleGyroRange
          connection.i2c_write([Mpu6050.RA_GYRO_CONFIG,
                                Mpu6050.GCONFIG_FS_SEL_BIT,
                                Mpu6050.GCONFIG_FS_SEL_LENGTH,
                                Mpu6050.GYRO_FS_250])

          # setFullScaleAccelRange
          connection.i2c_write([Mpu6050.RA_ACCEL_CONFIG,
                                Mpu6050.ACONFIG_AFS_SEL_BIT,
                                Mpu6050.ACONFIG_AFS_SEL_LENGTH,
                                Mpu6050.ACCEL_FS_2])

          every(interval) do
          end

          super
        rescue Exception => e
          Logger.error "Error starting Mpu6050 driver!"
          Logger.error e.message
          Logger.error e.backtrace.inspect
        end
      end

      def update(val)
        puts val.inspect
        return if val.nil? || val == "bad byte"
      end
    end
  end
end
