# Uno

A simple OTP generator written in Swift.

# Installation
Currently this package supports Swift Package Manager only. More dependency managers may be supported in future releases.

## Swift Package Manger
[Swift Package Manager](https://swift.org/package-manager/#conceptual-overview) is a tool for managing the distribution of Swift Code. It's integrated in the Swift build system and can be used to automate the dependency management.

To add this package as a dependency of another Swift package you just need to add it to the `dependencies` value of your package manifest (the `Package.swift` file).

```swift 
dependencies: [
  .package(url: "https://github.com/gaetanomatonti/Uno.git", from: "0.1.0"),
]
```

# One-Time Password
An OTP (One-Time Password) is an authentication code that can only be used once. As such, it is often used in combination with a regular password to provide an extra layer of security (multi-factor authentication).
 
### HMAC-based One-Time Password
A HOTP (where the "H" stands for _Hash-based Message Authentication Code_, or _HMAC_) is a one-time password generated from a cryptographic hash function and a static secret key. It also involves a moving factor that seeds into the generator function, usually a counter. 
Implementation follows the [RFC-4226](https://datatracker.ietf.org/doc/html/rfc4226) specifications.

### Time-based One-Time Password
A TOTP (Time-based One-Time Password) extends the HOTP by replacing the moving factor in the hashing function. While in the HOTP the counter is counter-based, in TOTPs it is time-based. This means that the OTP is only valid in a certain interval of time.
The amount of time in which every OTP is valid is called _timestep_, and tends to be 30 seconds or 60 seconds in length.
Implementation follows the [RFC-6238](https://datatracker.ietf.org/doc/html/rfc6238) specifications.

## Hashing Algorithms
While SHA1 is the most frequently used hash function to generate HMACs, SHA256 and SHA512 could also be used.
