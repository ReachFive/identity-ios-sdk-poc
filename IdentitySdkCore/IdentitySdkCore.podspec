Pod::Spec.new do |spec|
  spec.name         = "IdentitySdkCore"
  spec.version      = "4.0.0"
  spec.summary      = "ReachFive IdentitySdkCore"
  spec.description  = <<-DESC
      ReachFive Identity Sdk Core
  DESC
  spec.homepage     = "http://EXAMPLE/IdentitySdkCore"
  spec.license      = { :type => "MIT", :file => "IdentitySdkCore/LICENSE" }
  spec.author       = "ReachFive"
  spec.authors      = { "egor" => "egor@reach5.co" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/ReachFive/identity-ios-sdk-poc.git", :branch => "new-sdk" }
  # spec.source       = { :git => "https://github.com/ReachFive/identity-ios-sdk-poc.git", :tag => "#{spec.version}" }
  spec.source_files  = "IdentitySdkCore/Classes/*.swift"
end
