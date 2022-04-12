import PlaygroundSupport
import SpriteKit

class GameScene: SKScene {
    
    var bg: SKSpriteNode?

    override func didMove(to view: SKView) {
        bg = childNode(withName: "//Empty Space") as? SKSpriteNode
      

    }
    
    public override func keyDown(with event: NSEvent) {
    }

    override func update(_ currentTime: TimeInterval) {
        
//        End Screen for completing game
    }
    
    @objc public static override var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
}
 
