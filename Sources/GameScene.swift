import PlaygroundSupport
import SpriteKit

class GameScene: SKScene {
   
    var ship: SKSpriteNode!
    
    var cam: SKCameraNode!

    override func didMove(to view: SKView) {
       
//        ship = childNode(withName: "//Space Ship") as? SKSpriteNode
        
        cam = childNode(withName: "//Camera") as? SKCameraNode
    }
    
    var leftPressed = false
    var rightPressed = false
    var upPressed = false
    var downPressed = false
    
    public override func keyDown(with event: NSEvent) {
        switch Int(event.keyCode) {
        case 123:
            leftPressed = true
        case 124:
            rightPressed = true
        case 125:
            downPressed = true
        case 126:
            upPressed = true
        default:
            break
        }
    }
    
    public override func keyUp(with event: NSEvent) {
        switch Int(event.keyCode) {
        case 123:
            leftPressed = false
        case 124:
            rightPressed = false
        case 125:
            downPressed = false
        case 126:
            upPressed = false
        default:
            break
        }
    }

    var lastUpdate: TimeInterval!
    override func update(_ currentTime: TimeInterval) {
//        Smooths things out
        defer { lastUpdate = currentTime }
        guard lastUpdate != nil else {
            return
        }
        
        let dt = currentTime - lastUpdate
        guard dt < 1 else {
            return //so nothing "jumps" when the the game is unpaused
        }
//
        if rightPressed {
            camera!.position.x -= 500 * dt
        }
        if leftPressed {
            camera!.position.x += 500 * dt
        }
        if upPressed {
//            ship.position.y += 100 * dt
        }
        if downPressed {
//            ship.position.y -= 100 * dt
        }
        

    }
    
    @objc public static override var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
}
 
func moveSprite (node : SKNode, moveByX: CGFloat, moveByY: CGFloat, forTheKey: String, duration: TimeInterval) {
    let moveAction = SKAction.moveBy(x: moveByX, y: moveByY, duration: duration)
    let seq = SKAction.sequence([moveAction])
    
    node.run(seq, withKey: forTheKey)
    }
