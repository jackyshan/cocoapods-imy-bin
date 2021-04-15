
module CBin
  VERSION = '3.3.1.5'
  #自研
  #修改去掉binary生成podspec
  #修改specification.from_file过滤subspecs集合到bin
end

module Pod
  def self.match_version?(*version)
    Gem::Dependency.new('', *version).match?('', Pod::VERSION)
  end
end
