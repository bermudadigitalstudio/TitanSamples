import Titan
import TitanKituraAdapter
import Foundation

/// Generate a unique identifier that we associate with a Thread
extension Thread {
  var id: String {
    if let currentID = self.threadDictionary["titan_id"] as? String {
      return currentID
    } else {
      let newID = UUID().uuidString
      self.threadDictionary["titan_id"] = NSString(string: newID)
      return newID
    }
  }
}

final class MyThreadSafeDatabase {
  func read() -> String {
    return ""
  }
  func store(_ st: String) {

  }
}

final class MyUnsafeDatabase {
  func read() -> String {
    return ""
  }
  func store(_ st: String) {

  }
}

let titanInstance = Titan()

let db = MyThreadSafeDatabase()
func createOrRetrieveUnsafeDB() -> MyUnsafeDatabase {
  if let unsafeDB = Thread.current.threadDictionary["unsafe_db"] as? MyUnsafeDatabase {
    return unsafeDB
  } else {
    let newDB = MyUnsafeDatabase()
    Thread.current.threadDictionary["unsafe_db"] = newDB
    return newDB
  }
}

titanInstance.get("/") {
  db.read()
  createOrRetrieveUnsafeDB().read()
  return Thread.current.id + "\n"
}

TitanKituraAdapter.serve(titanInstance.app, on: 8000)
