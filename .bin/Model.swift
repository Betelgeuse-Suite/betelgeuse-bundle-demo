import Foundation

public class Model {

    public let index: Index
    public class Index {
    
        public let source: String
        public let test: String
        public let tesyy: String
        
        init(_ jsonData: NSDictionary) {
            self.source = jsonData["source"] as! String
            self.test = jsonData["test"] as! String
            self.tesyy = jsonData["tesyy"] as! String
        }
    }
    public let nested: Nested
    public class Nested {
    
        public let nested: Nested
        public class Nested {
        
            public let file: File
            public class File {
            
                public let value: Int
                public let anotherValue: Int
                
                init(_ jsonData: NSDictionary) {
                    self.value = jsonData["value"] as! Int
                    self.anotherValue = jsonData["anotherValue"] as! Int
                }
            }
            
            init(_ jsonData: NSDictionary) {
                self.file = File(jsonData["file"] as! NSDictionary)
            }
        }
        
        init(_ jsonData: NSDictionary) {
            self.nested = Nested(jsonData["nested"] as! NSDictionary)
        }
    }
    
    init(_ jsonData: NSDictionary) {
        self.index = Index(jsonData["index"] as! NSDictionary)
        self.nested = Nested(jsonData["nested"] as! NSDictionary)
    }
}