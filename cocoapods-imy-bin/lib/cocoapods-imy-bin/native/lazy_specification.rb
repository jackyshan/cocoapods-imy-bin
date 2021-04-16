require 'delegate'
module Pod
  class Specification
    class Set

      class LazySpecification < DelegateClass(Specification)

        def subspec_by_name(name = nil, raise_if_missing = true, include_non_library_specifications = false)
          subspec =
            if !name || name == self.name
              self
            else
              specification.subspec_by_name(name, raise_if_missing, include_non_library_specifications)
            end
          return unless subspec

          SpecWithSource.new subspec, spec_source
        end

        def specification
          @specification ||= spec_source.specification(name, version.version)
          puts "specification #{specification.name}"
          @specification
        end
      end
    end
  end
end
