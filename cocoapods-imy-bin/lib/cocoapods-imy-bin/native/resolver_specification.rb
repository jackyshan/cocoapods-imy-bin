require 'cocoapods-imy-bin/helpers/subspec_auto'


module Pod
  class Resolver
    # A small container that wraps a resolved specification for a given target definition. Additional metadata
    # is included here such as if the specification is only used by tests.
    #
    class ResolverSpecification
      def initialize(spec, used_by_non_library_targets_only, source)
        @spec = spec
        @spec = SubspecAuto.handle(spec)
        @used_by_non_library_targets_only = used_by_non_library_targets_only
        @source = source
      end
	end
  end
end