![Public Beta banner](https://github.com/swiyu-admin-ch/swiyu-admin-ch.github.io/blob/main/assets/images/github-banner.jpg)

# pbkdf2 (password hashing) for Swift applications

This project contains language bindings required for loading and using the swiyu [pbkdf2](https://github.com/swiyu-admin-ch/pbkdf2-bindgen) library (Rust) in Swift applications.

Here is a simple [usage example]([https://github.com/swiyu-admin-ch/pbkdf2-bindgen/examples](https://github.com/swiyu-admin-ch/pbkdf2-bindgen/blob/main/tests/bindings/test_pbkdf2.swift)):

```swift
import pbkdf2
import CoreData

var pbkdf2 = Pbkdf2()

let password: Data? = "password".data(using: .utf8)
let salt: Data? = "salt".data(using: .utf8)

var tryError: Error?
do {
    var passwordHashAsString = try pbkdf2.hashPasswordAsString(password: password!, salt: salt!)

    let verifyPassword = try pbkdf2.verifyPassword(password: password!, passwordHash: passwordHashAsString)
    
    pbkdf2 = Pbkdf2.newCustom(alg: Algorithm.pbkdf2Sha512, rounds: 1000, outputLength: 20)
    passwordHashAsString = try pbkdf2.hashPasswordAsString(password: password!, salt: salt!) // PHC format

} catch { tryError = error }
    guard nil == tryError else { fatalError(tryError.debugDescription) }

```

## Contributions and feedback

We welcome any feedback on the code regarding both the implementation and security aspects. Please follow the guidelines for contributing found in [CONTRIBUTING](./CONTRIBUTING.md).

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](./LICENSE.md) file for details.
