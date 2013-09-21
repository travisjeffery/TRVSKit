Pod::Spec.new do |s|
  s.name = "TRVSKit"
  s.version = "0.0.1"
  s.summary = "A collection of useful APIs for iOS."
  s.homepage = "http://github.com/travisjeffery/trvskit"
  s.license = 'MIT'
  s.author = { "Travis Jeffery" => "tj@travisjeffery.com" }
  s.platform = :ios, '7.0'
  s.source       = { :git => "http://github.com/travisjeffery/TRVSKit.git", :tag => "0.0.1" }
  s.source_files  = 'TRVSKit', 'TRVSKit/**/*.{h,m}'
  s.exclude_files = 'TRVSKit/Exclude'
  s.requires_arc = true
end
