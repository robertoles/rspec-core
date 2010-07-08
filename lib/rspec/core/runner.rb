require 'drb/drb'

module RSpec
  module Core
    class Runner

      def self.disable_autorun!
        RSpec.deprecate("disable_autorun!")
      end

      def self.run(args, err, out)
        options = ConfigurationOptions.new(args)
        options.parse_options

        if options.options[:drb]
          run_over_drb(options, err, out) || run_in_process(options, err, out)
        else
          run_in_process(options, err, out)
        end
      end

      def self.run_over_drb(options, err, out)
        DRbCommandLine.new(options).run(err, out)
      end

      def self.run_in_process(options, err, out)
        CommandLine.new(options, RSpec::configuration, RSpec::world).run(err, out)
      end

    end

  end
end
