// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AuthenticateIdTokenMutation: GraphQLMutation {
  public static let operationName: String = "authenticateIdToken"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation authenticateIdToken($input: AuthenticateIdTokenInput!) { authenticateIdToken(input: $input) { __typename user { __typename id email firstName lastName familyTitle familyId partnerId } accessToken refreshToken } }"#
    ))

  public var input: AuthenticateIdTokenInput

  public init(input: AuthenticateIdTokenInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: GraphqlAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GraphqlAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("authenticateIdToken", AuthenticateIdToken?.self, arguments: ["input": .variable("input")]),
    ] }

    public var authenticateIdToken: AuthenticateIdToken? { __data["authenticateIdToken"] }

    /// AuthenticateIdToken
    ///
    /// Parent Type: `AuthPayload`
    public struct AuthenticateIdToken: GraphqlAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GraphqlAPI.Objects.AuthPayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("user", User.self),
        .field("accessToken", String.self),
        .field("refreshToken", String.self),
      ] }

      public var user: User { __data["user"] }
      public var accessToken: String { __data["accessToken"] }
      public var refreshToken: String { __data["refreshToken"] }

      /// AuthenticateIdToken.User
      ///
      /// Parent Type: `User`
      public struct User: GraphqlAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { GraphqlAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", String.self),
          .field("email", String.self),
          .field("firstName", String?.self),
          .field("lastName", String?.self),
          .field("familyTitle", String?.self),
          .field("familyId", String?.self),
          .field("partnerId", String?.self),
        ] }

        public var id: String { __data["id"] }
        public var email: String { __data["email"] }
        public var firstName: String? { __data["firstName"] }
        public var lastName: String? { __data["lastName"] }
        public var familyTitle: String? { __data["familyTitle"] }
        public var familyId: String? { __data["familyId"] }
        public var partnerId: String? { __data["partnerId"] }
      }
    }
  }
}
