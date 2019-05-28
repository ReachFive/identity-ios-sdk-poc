Pod::Spec.new do |spec|
  spec.name           = "IdentitySdkCore"
  spec.version        = "4.0.0"
  spec.summary        = "ReachFive IdentitySdkCore"
  spec.description    = <<-DESC
      ReachFive Identity Sdk Core
  DESC
  spec.homepage       = "https://github.com/ReachFive/identity-ios-sdk-poc"
  spec.license        = { :type => "MIT", :file => "LICENSE" }
  spec.author         = "ReachFive"
  spec.authors        = { "egor" => "egor@reach5.co" }
  spec.platform       = :ios, "12"
  spec.swift_versions = ["5.0"]
  spec.source         = { :git => "https://github.com/ReachFive/identity-ios-sdk-poc.git", :branch => "new-sdk" }
  # spec.source       = { :git => "https://github.com/ReachFive/identity-ios-sdk-poc.git", :tag => "#{spec.version}" }
  spec.source_files   = "IdentitySdkCore/Classes/*.swift"
  spec.ios.deployment_target = "12"
end
