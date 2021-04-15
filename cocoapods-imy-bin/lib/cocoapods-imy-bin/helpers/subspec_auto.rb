require 'cocoapods'

class SubspecAuto
    attr_reader :spec
    attr_reader :code_spec

	def initialize(argv)
		@podspec = argv
	end

	def init_spec(fs)
		@spec = fs
	end

	def self.from_file(argv)
		SubspecAuto.new(argv).run
	end

	def self.handle(fromspec)
		s = SubspecAuto.new('')
		s.init_spec(fromspec)
		s.handle_spec
		s.spec
	end

	def run
		@code_spec = Pod::Specification.from_file(@podspec)
		@spec = code_spec.dup
		handle_spec
		@spec
		# write_spec_file
	end

	def handle_spec
		puts spec.name
		if spec.default_subspecs.empty?
			puts '不存在default_subspecs'
			return
		end
		puts '存在default_subspecs，修改spec_hash'
		spec_hash = @spec.to_hash
		subspecs = spec_hash['subspecs']

		#把subspec的依赖集合到最上层
		dps_hash = Hash[]
		subdps = subspecs.each do |sub| 
			dps_hash = dps_hash.merge(Hash(sub['dependencies']))
		end
		dps_hash = dps_hash.reject { |key, value| key.include?(spec_hash['name'])}
		spec_hash['dependencies'] = dps_hash

		#把subspec集合到Bin
		subnames = subspecs.map { |sub| sub['name']}
		spec_hash['default_subspecs'] = 'Bin'
		bin = Hash["name" => 'Bin']
		dependencies = Hash[]
		subnames.each { |name|
			dependencies["#{spec_hash['name']}/#{name}"] = Array.new
		}
		bin['dependencies'] = dependencies
		subspecs.insert(0, bin)

		@spec = Pod::Specification.from_hash(spec_hash)
	end


	def write_spec_file(file = filename)
		File.open(file, 'w+') do |f|
		  f.write(spec.to_pretty_json)
		end

		@filename = file
	end

	def filename
		# @filename ||= "#{spec.name}.binary.podspec.json"
		@filename ||= "#{spec.name}.podspec.json"
	end

end

# s = SubspecAuto.from_file(ARGV)
# puts s.default_subspecs
