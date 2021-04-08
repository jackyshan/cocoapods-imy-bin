
module CBin
  VERSION = '3.3.1.4'#自研修改去掉binary生成podspec
end

module Pod
  def self.match_version?(*version)
    Gem::Dependency.new('', *version).match?('', Pod::VERSION)
  end
end
