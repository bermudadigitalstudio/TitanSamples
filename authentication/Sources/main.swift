import Titan

let titanInstance = Titan()

typealias UserRecord = (email: String, password: String, superSecretInformation: String)
let userDB: [String : UserRecord] = [
  "swizzlr": (email: "me@swizzlr.co", password: "password", superSecretInformation: "My cat's name is mittens"),
  "larry": (email: "larry@", password: "password", superSecretInformation: "My cat's name is mittens"),,
  "verity": "verity@mi6.gov.uk"
]

let userIDHeaderKey = "X-Sample-Titan-This-Is-A-Bad-Idea-Do-Not-Copy-And-Paste-UserID"

titanInstance.get("/me") { (request: RequestType) -> String in
  guard let userID = request.headers.first(where: { (header) -> Bool in
    return header.0.lowercased() == userIDHeaderKey.lowercased()
  }) else {
    return "400 Bad Request: please supply the following header: \(userIDHeaderKey)"
  }

  return ""
}
