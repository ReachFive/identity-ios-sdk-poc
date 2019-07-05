# Identity iOS SDK

## Installation

### Cocoapods
Follow the instructions to install [Cocoapods](https://cocoapods.org)

## Getting Started

This SDK is modular and you only need to import what you really plan on using. The only mandatory part is SDK Core.

### SDK Core (required)

It contains all the main tools and interfaces, as well as methods related to standard authentication by identifier and password.

It contains all common tools and interfaces, authentication with passwords.

add thes dependency into your Podfile

```ruby
pod 'IdentitySdkCore'
```

### SDK WebView

This module uses a WebView to authenticate users, it enables all providers that are supported by ReachFive.

```ruby
pod 'IdentitySdkWebView'
```

### Facebook native provider

This module uses the Facebook native SDK to provider better user experience.

#### Dependencies

```ruby
pod 'IdentitySdkFacebook'
```

#### Configuration
[Facebook Connect](https://support.reach5.co/article/4-create-facebook-application)

in your `Info.plist` file add those lines, you can get your config in facebook official documentation [Facebook SDK iOS](https://developers.facebook.com/docs/facebook-login/ios)
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>fb000000000000000</string>
    </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>00000000000000</string>
<key>FacebookDisplayName</key>
<string>My Facebook Application name</string>

<key>LSApplicationQueriesSchemes</key>
<array>
  <string>fbapi</string>
  <string>fb-messenger-share-api</string>
  <string>fbauth2</string>
  <string>fbshareextension</string>
</array>
```

### Google native provider

This module uses the Google native SDK to provide a better user experience.

#### Dependency

```ruby
pod 'IdentitySdkGoogle'
```
