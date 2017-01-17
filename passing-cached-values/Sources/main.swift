import Titan
import Foundation

/* 
 Here's the situation: in conventional "middleware" frameworks, some method of passing state
 through the chain of middlewares is used. A context object or a context property on request
 or response works nicely.
 
 Unfortunately, this destroys the ideological purity of Titan, which is, if anything,
 a reactionary framework against the evils of modern software development.
 
 Let's get to it.
*/

// In our example, this little API we're building needs to process very big JSON files uploaded by POST.

// (You should probably do this separately from your frontend)

let instance = Titan()

// You might feel tempted to frontend your "middleware" with a JSON parser:

instance.route(path: "*") { (req, res) -> (RequestType, ResponseType) in
  let json = try? JSONSerialization.jsonObject(with: req.body.data(using: .utf8)!,
                                          options: [])
  // req.json = json... ???
  return (req, res)
}

/* 
 This isn't how you do that kind of thing in Titan. We're embracing Swift and
 its typechecker. 
*/

// Let's try again:

extension RequestType {
  var json: Any? {
    guard let bodyAsData = self.body.data(using: .utf8) else {
      return nil
    }
    return try? JSONSerialization.jsonObject(with: bodyAsData,
                                                 options: [])
  }
}

// That's better.

instance.post("/receiveStatistics") { (request) -> Int in
  guard let json = request.json else {
    return 400 // Bad request, couldn't parse the input
  }

  // process JSON, store in a database?
  return 201 // Created
}

/*
 You can see that the notion of passing data around between "middlewares" is a
 result of outdated thinking about ownership inside server applications.
 
 Any code that makes its way into your app is something you are responsible for.
 
 Swift allows an expressivity in protocols and types that is simply impossible in
 many other languages. You don't need "JSON parsing middleware" – you just need 
 a JSON parser. This extension to `RequestType` is something you can write 
 yourself, tuning just for your app. Or perhaps someone has a really good one 
 you can add as a package.
 
 Let's turn to error handling. Surely this needs some kind of per request context!
*/

/// Encode JSON and store in database.
/// Throws if cannot connect to database
func processJSON(_ json: Any) throws {
  throw Foundation.NSError(domain: "com.titan", code: -1,
                           userInfo: [NSLocalizedDescriptionKey: "Couldn't connect to database"])
}

// So our processJSON function always throws. What happens if we try to call it in a route?

instance.post("/receiveStatisticsCrashy") { (request) -> Int in
  do {
    try processJSON(request.json as Any)
  } catch {
    return 500
  }
  return 201
}

// That sucks though! We have to write "return 500" all the time – what if we want a nice error page? What if we want a custom handler?

// There's a few ways to do this. I prefer this one.

extension Titan {
  func post(_ path: String, errorHandler: @escaping (Error) -> (ResponseType), handler: @escaping (RequestType) throws -> Int) {
    // Uncomment the following to get a very nice compiler error.
    // self.post(path, handler)

    self.post(path, toNonThrowing(handler, errorHandler: errorHandler))
  }

  func toNonThrowing(_ handler: @escaping (RequestType) throws -> Int,
                     errorHandler: @escaping (Error) -> (ResponseType))
    -> Function {
    return { req, res in
      do {
        let code = try handler(req)
        return (req, Response(code, ""))
      } catch {
        return (req, errorHandler(error))
      }
    }
  }
}

// We now have a global error handler to deal with all kinds of issues!

let globalErrorHandler: (Error) -> (ResponseType) = { err in
  return Response(500, err.localizedDescription)
}

instance.post("/receiveStatistics", errorHandler: globalErrorHandler) { (req) -> Int in
  try processJSON(req.json as Any) // No do/catch required!
  return 201
}



















