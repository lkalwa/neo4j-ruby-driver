# frozen_string_literal: true

module PlatformRequirements

  def self.run_checks!
    unless RUBY_PLATFORM.match?(/java/)
      raise 'In order to use MRI version, SEABOLT_LIB env variable has to be set' unless ENV.key?('SEABOLT_LIB')
    end
  end
end
