require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-livephoto"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-livephoto
                   DESC
  s.homepage     = "https://github.com/NarekChang/react-native-livephoto"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "Narek Changlyan" => "narek.changlyan@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/NarekChang/react-native-livephoto.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
	
  # s.dependency "..."
end

