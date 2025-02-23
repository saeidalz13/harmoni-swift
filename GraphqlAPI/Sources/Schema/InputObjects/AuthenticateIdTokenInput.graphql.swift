// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct AuthenticateIdTokenInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    idToken: String
  ) {
    __data = InputDict([
      "idToken": idToken
    ])
  }

  public var idToken: String {
    get { __data["idToken"] }
    set { __data["idToken"] = newValue }
  }
}
