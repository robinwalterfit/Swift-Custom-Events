import XCTest
@testable import Events

class EventsTests: XCTestCase {
    
    func testPlay() {
        
        let zeus = CatTest()
        let stephen = HumanTest()
        
        stephen.testAdoptCat( cat: zeus )
        zeus.testMeow()
        
    }
    
}

class CatTest: XCTestCase {
    
    var eventManager = EventManager()
    
    func testMeow() {
        
        print( "Cat: MRaawwweeee" )
        
        self.eventManager.trigger( tag: "meow", param: "The cat is hungry!" )
        
    }
    
}

class HumanTest: XCTestCase {
    
    func testAdoptCat( cat: CatTest ) {
        
        let _ = cat.eventManager.addListener( tag: "meow", action: {
            
            print( "Human: Awww, what a cute kitty *pets cat*" )
            
        } )
        
        let _ = cat.eventManager.addListener( tag: "meow", action: self.testDayDream, priority: 0 )
        
        let _ = cat.eventManager.addListener( tag: "meow", action: self.testPonderCat )
        
    }
    
    func testDayDream() {
        
        print( "Human daydreams about owning a dog" )
        
    }
    
    func testPonderCat( param: Any? ) {
        
        if let info = param as? String {
            
            print( "Oooh, I think I know:" )
            
            print( info )
            
        }
        
        
    }
    
}
