require 'hanami/utils/duplicable'
require 'transproc'

# HACK: Patching Hanami::Utils::Hash to add deep_symbolize method.
# This hack should be removed as soon as hanami-utils version is bumped.

# Deprecation warning
patched_version = '1.0.0'

if Hanami::Utils::VERSION != patched_version
  ::Kernel.warn("WARNING: You are running hanami-utils version #{Hanami::Utils::VERSION}. The monkey patch located at #{__FILE__} only applies to #{patched_version}, so please remove it.")
end

module Hanami
  module Utils
    # Hash on steroids
    # @since 0.1.0
    class Hash
      extend Transproc::Registry
      import Transproc::HashTransformations

      # Symbolize the given hash
      #
      # @param input [::Hash] the input
      #
      # @return [::Hash] the symbolized hash
      #
      # @since x.x.x
      #
      # @see .deep_symbolize
      #
      # @example Basic Usage
      #   require 'hanami/utils/hash'
      #
      #   hash = Hanami::Utils::Hash.symbolize("foo" => "bar", "baz" => {"a" => 1})
      #     # => {:foo=>"bar", :baz=>{"a"=>1}}
      #
      #   hash.class
      #     # => Hash
      def self.symbolize(input)
        self[:symbolize_keys].call(input)
      end

      # Deep symbolize the given hash
      #
      # @param input [::Hash] the input
      #
      # @return [::Hash] the deep symbolized hash
      #
      # @since x.x.x
      #
      # @see .symbolize
      #
      # @example Basic Usage
      #   require 'hanami/utils/hash'
      #
      #   hash = Hanami::Utils::Hash.deep_symbolize("foo" => "bar", "baz" => {"a" => 1})
      #     # => {:foo=>"bar", :baz=>{a:=>1}}
      #
      #   hash.class
      #     # => Hash
      def self.deep_symbolize(input)
        self[:deep_symbolize_keys].call(input)
      end
    end
  end
end
