# Changelog

## v5.0.0

Use [Futures](https://github.com/Thomvis/BrightFutures) instead of callbacks
Passwordless Start

### Breaking changes
Transform yours callaback into the Future handling
```swift
AppDelegate.reachfive()
  .loginWithPassword(username: email, password: password)
  .onSuccess { authToken in
    // Handle success
  }
  .onFailure { error in
    // Handle error
  }
```

Callbacks handling

```swift
AppDelegate.reachfive()
  .loginWithPassword(
    username: email,
    password: password,
    callback: { response in
        switch response {
          case .success(let authToken):
            // Handle success
          case .failure(let error):
            // handle error
          }
    }
)
```


## v4.0.0-beta.15
Use SFSafariViewController instead of WKWebView

## v4.0.0-beta.13
Fix UserConsent

## v4.0.0-beta.12
Add getProfile

## v4.0.0

### 9th July 2019

### Changes

New modular version of the Identity SDK iOS:

- [`IdentitySdkCore`](IdentitySdkCore)
- [`IdentitySdkFacebook`](IdentitySdkFacebook)
- [`IdentitySdkGoogle`](IdentitySdkGoogle)
- [`IdentitySdkWebView`](IdentitySdkWebView)
