Pod::Spec.new do |s|
  s.name         = "Objectify"
  s.version      = "0.0.4"
  s.summary      = "Make override NSObject methods simple and easy."
  s.homepage     = "http://github.com/crazytonyli/Objectify"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Tony Li" => "crazygemini.lee@gmail.com" }
  s.social_media_url   = "https://twitter.com/crazytonyli"
  s.source       = {
      :git => "https://github.com/crazytonyli/Objectify.git",
      :tag => s.version
  }
  s.source_files  = "Objectify/*.h"
  s.dependency "libextobjc/EXTKeyPathCoding", "~> 0.4.1"
end
