//  This file was automatically generated and should not be edited.

import Apollo

public final class RegisterUserMutation: GraphQLMutation {
  public static let operationString =
    "mutation RegisterUser($username: String!, $email: String!, $password: String!) {" +
    "  registerUser(username: $username, email: $email, password: $password) {" +
    "    __typename" +
    "    username" +
    "    email" +
    "  }" +
    "}"

  public var username: String
  public var email: String
  public var password: String

  public init(username: String, email: String, password: String) {
    self.username = username
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["username": username, "email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("registerUser", arguments: ["username": Variable("username"), "email": Variable("email"), "password": Variable("password")], type: .object(RegisterUser.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(registerUser: RegisterUser? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "registerUser": registerUser])
    }

    public var registerUser: RegisterUser? {
      get {
        return (snapshot["registerUser"]! as! Snapshot?).flatMap { RegisterUser(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "registerUser")
      }
    }

    public struct RegisterUser: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("username", type: .scalar(String.self)),
        GraphQLField("email", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(username: String? = nil, email: String? = nil) {
        self.init(snapshot: ["__typename": "User", "username": username, "email": email])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var username: String? {
        get {
          return snapshot["username"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "username")
        }
      }

      public var email: String? {
        get {
          return snapshot["email"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "email")
        }
      }
    }
  }
}

public final class LoginUserMutation: GraphQLMutation {
  public static let operationString =
    "mutation LoginUser($email: String!, $password: String!) {" +
    "  login(email: $email, password: $password) {" +
    "    __typename" +
    "    username" +
    "    email" +
    "    apiToken" +
    "  }" +
    "}"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("login", arguments: ["email": Variable("email"), "password": Variable("password")], type: .object(Login.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(login: Login? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "login": login])
    }

    public var login: Login? {
      get {
        return (snapshot["login"]! as! Snapshot?).flatMap { Login(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("username", type: .scalar(String.self)),
        GraphQLField("email", type: .scalar(String.self)),
        GraphQLField("apiToken", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(username: String? = nil, email: String? = nil, apiToken: String? = nil) {
        self.init(snapshot: ["__typename": "User", "username": username, "email": email, "apiToken": apiToken])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var username: String? {
        get {
          return snapshot["username"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "username")
        }
      }

      public var email: String? {
        get {
          return snapshot["email"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "email")
        }
      }

      public var apiToken: String? {
        get {
          return snapshot["apiToken"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "apiToken")
        }
      }
    }
  }
}