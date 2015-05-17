Pod::Spec.new do |s|
  s.name         = "ObjectEquality"
  s.version      = "0.0.3"
  s.summary      = "Override `isEqual:` and `hash` methods with one line of code."
  s.description  = <<-DESC
                   Override `isEqual:` and `hash` methods according to object
                   properties.
                   DESC
  s.homepage     = "http://github.com/crazytonyli/ObjectEquality"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Tony Li" => "crazygemini.lee@gmail.com" }
  s.social_media_url   = "https://twitter.com/crazytonyli"
  s.source       = {
      :git => "https://github.com/crazytonyli/ObjectEquality.git",
      :tag => s.version
  }
  s.source_files  = "ObjectEquality/ObjectEquality.h"
  s.dependency "libextobjc/EXTKeyPathCoding", "~> 0.4.1"
end
