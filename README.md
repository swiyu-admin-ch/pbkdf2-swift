![Public Beta banner](https://github.com/swiyu-admin-ch/swiyu-admin-ch.github.io/blob/main/assets/images/github-banner.jpg)

# pbkdf2 (password hashing) for Swift applications

This project contains language bindings required for loading and using the swiyu [pbkdf2](https://github.com/swiyu-admin-ch/pbkdf2-bindgen) library (Rust) in Swift applications.

Here is a simple [usage example]([https://github.com/swiyu-admin-ch/pbkdf2-bindgen/examples](https://github.com/swiyu-admin-ch/pbkdf2-bindgen/blob/main/tests/bindings/test_pbkdf2.swift)):

```swift
import Foundation

import pbkdf2

struct HexEncodingOptions: OptionSet {
    let rawValue: Int
    static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
}

extension Sequence where Element == UInt8 {
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}

var pbkdf2 = Pbkdf2()

let password: Data? = "password".data(using: .utf8)
let salt: Data? = "salt".data(using: .utf8)

var tryError: Error?
do {
    // hash + verify
    var passwordHashAsString = try pbkdf2.hashPasswordAsString(password: password!, salt: salt!) // PHC format
    let verifyPassword = try pbkdf2.verifyPassword(password: password!, passwordHash: passwordHashAsString)
    assert(verifyPassword)
    
    // Test vectors (Test Case 2) from:
    // https://github.com/brycx/Test-Vector-Generation/blob/master/PBKDF2/pbkdf2-hmac-sha2-test-vectors.md#test-case-2
    // Online generators (e.g., https://asecuritysite.com/pbkdf2/pb2) may be used as well.

    var pbkdf2Sha256 = Pbkdf2.newCustom(alg: Algorithm.pbkdf2Sha256, rounds: 2, outputLength: 20)
    var passwordHash = try pbkdf2Sha256.hashPassword(password: password!, salt: salt!)
    assert("ae4d0c95af6b46d32d0adff928f06dd02a303f8e" == passwordHash.hexEncodedString())

    var pbkdf2Sha512 = Pbkdf2.newCustom(alg: Algorithm.pbkdf2Sha512, rounds: 2, outputLength: 20)
    passwordHash = try pbkdf2Sha512.hashPassword(password: password!, salt: salt!)
    assert("e1d9c16aa681708a45f5c7c4e215ceb66e011a2e" == passwordHash.hexEncodedString())

    // Test vectors (Test Case 3) from:
    // https://github.com/brycx/Test-Vector-Generation/blob/master/PBKDF2/pbkdf2-hmac-sha2-test-vectors.md#test-case-3
    // Online generators (e.g., https://asecuritysite.com/pbkdf2/pb2) may be used as well.

    pbkdf2Sha256 = Pbkdf2.newCustom(alg: Algorithm.pbkdf2Sha256, rounds: 4096, outputLength: 20)
    passwordHash = try pbkdf2Sha256.hashPassword(password: password!, salt: salt!)
    assert("c5e478d59288c841aa530db6845c4c8d962893a0" == passwordHash.hexEncodedString())

    pbkdf2Sha512 = Pbkdf2.newCustom(alg: Algorithm.pbkdf2Sha512, rounds: 4096, outputLength: 20)
    passwordHash = try pbkdf2Sha512.hashPassword(password: password!, salt: salt!)
    assert("d197b1b33db0143e018b12f3d1d1479e6cdebdcc" == passwordHash.hexEncodedString())

} catch { tryError = error }
    guard nil == tryError else { fatalError(tryError.debugDescription) }

```

## Contributions and feedback

We welcome any feedback on the code regarding both the implementation and security aspects. Please follow the guidelines for contributing found in [CONTRIBUTING](./CONTRIBUTING.md).

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](./LICENSE.md) file for details.
