Pod::Spec.new do |spec|
  spec.name           = "IdentitySdkFacebook"
  spec.version        = "4.0.0"
  spec.summary        = "ReachFive IdentitySdkFacebook"
  spec.description    = <<-DESC
      ReachFive Identity Sdk Facebook
  DESC
  spec.homepage       = "https://github.com/ReachFive/identity-ios-sdk-poc"
  spec.license        = { :type => "MIT", :file => "LICENSE" }
  spec.author         = "ReachFive"
  spec.authors        = { "egor" => "egor@reach5.co" }
  spec.swift_versions = ["5"]
  # spec.source         = { :git => "https://github.com/ReachFive/identity-ios-sdk-poc.git", :branch => "new-sdk" }
  spec.source       = { :git => "https://github.com/ReachFive/identity-ios-sdk-poc.git", :tag => "#{spec.version}" }
  spec.source_files   = "IdentitySdkFacebook/Classes/*.*"
  spec.platform       = :ios
  spec.ios.deployment_target = '12.2'

  spec.dependency 'IdentitySdkCore', '4.0.0'
end
