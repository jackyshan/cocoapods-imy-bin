require 'fileutils'
require 'cocoapods-imy-bin/helpers/subspec_auto'

module Pod
	class Sandbox
		def specification(name)
      		@stored_podspecs[name] ||= if file = specification_path(name)
                                   original_path = development_pods[name]
                                   SubspecAuto.from_file(original_path || file)
	      	end
	    end

	end
end