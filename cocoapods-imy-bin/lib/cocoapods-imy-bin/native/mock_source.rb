class MockSource < Pod::Source
  
  def specification(name, version)
    s = @_pods_by_name[name].find { |s| s.version == Pod::Version.new(version) }
    puts 'hhhhhhhhhhhhhh'
    puts s.default_subspecs
    s
  end

  def search(query)
  	puts 'search(query)----'
    query = query.root_name if query.is_a?(Pod::Dependency)
    set(query) if @_pods_by_name.key?(query)
  end


end