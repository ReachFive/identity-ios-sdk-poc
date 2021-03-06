require_relative './version'

Pod::Spec.new do |spec|
  spec.name                  = "IdentitySdkFacebook"
  spec.version               = $VERSION
  spec.summary               = "ReachFive IdentitySdkFacebook"
  spec.description           = <<-DESC
      ReachFive Identity Sdk Facebook
  DESC
  spec.homepage              = "https://github.com/ReachFive/identity-ios-sdk"
  spec.license               = { :type => "MIT", :file => "LICENSE" }
  spec.author                = "ReachFive"
  spec.authors               = { "egor" => "egor@reach5.co", "guillaume" => "guillaume@reach5.co", "roxane" => "roxane@reach5.co", "Pierre" => "pierre.bar@reach5.co", "gbe" => "guillaume.bersac@reach5.co", "Matthieu" => "matthieu@reach5.co" }
  spec.swift_versions        = ["5"]
  spec.source                = { :git => "https://github.com/ReachFive/identity-ios-sdk.git", :tag => "#{spec.version}" }
  spec.source_files          = "IdentitySdkFacebook/IdentitySdkFacebook/Classes/**/*.*"
  spec.platform              = :ios
  spec.ios.deployment_target = $IOS_DEPLOYMENT_TARGET

  spec.dependency 'IdentitySdkCore', '~> 5'
  spec.dependency 'FacebookCore'
  spec.dependency 'FacebookLogin'
end
