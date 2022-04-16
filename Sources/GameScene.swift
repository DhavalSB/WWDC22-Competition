import PlaygroundSupport
import SpriteKit

struct PhysicsCategory {
    static let none      : UInt32 = 0
    static let all       : UInt32 = UInt32.max
    static let obstacle  : UInt32 = 0b1
    static let projectile: UInt32 = 0b10
}

class GameScene: SKScene {
   
    var ship: SKSpriteNode!
    var station1: SKSpriteNode!
    
    var ast1: SKSpriteNode!
    var ast2: SKSpriteNode!
    var ast3: SKSpriteNode!
    var ast4: SKSpriteNode!
    
    var startInfo: SKNode!
    
    var cam: SKCameraNode!
    
    var cooldownOn = false
    var beamCooldown:  Timer?
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        
        ship = childNode(withName: "//Space Ship") as? SKSpriteNode
        station1 = childNode(withName: "//Space Station") as? SKSpriteNode

        ast1 = childNode(withName: "//Ast1") as? SKSpriteNode
        
        addAstPhysics(astVar: &ast1)

        ast2 = childNode(withName: "//Ast2") as? SKSpriteNode
        addAstPhysics(astVar: &ast2)
        
        ast3 = childNode(withName: "//Ast3") as? SKSpriteNode
        addAstPhysics(astVar: &ast3)
        
        ast4 = childNode(withName: "//Ast4") as? SKSpriteNode
        addAstPhysics(astVar: &ast4)
        
        startInfo = childNode(withName: "//Start")
        
        cam = childNode(withName: "//Camera") as? SKCameraNode
        self.camera = cam
        
        beamCooldown = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            self.resetBeamCooldown()
        })
    }
    
    var leftPressed = false
    var rightPressed = false
    var upPressed = false
    var downPressed = false
    var spacePressed = false
    var shiftPressed = false
    
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
        case 49:
            spacePressed = true
        case 56:
            shiftPressed = true
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
        case 49:
            spacePressed = false
        case 56:
            shiftPressed = false
        default:
            break
        }
    }

    var lastUpdate: TimeInterval!
    var scene1HasBeenStarted: Bool = false
    
    
override func update(_ currentTime: TimeInterval) {
//*        Smooths things out
        defer { lastUpdate = currentTime }
        guard lastUpdate != nil else {
            return
        }
        
        let dt = currentTime - lastUpdate
        guard dt < 1 else {
            return
        }
//*
    
    func movement1() {
            let moveX = SKAction.moveBy(x: 1000, y: 0, duration: 1)
            let rotate = SKAction.rotate(toAngle: Double.pi/2, duration: 0.388)
            let moveY = SKAction.moveBy(x: 0, y: 4000, duration: 1)
            let wait = SKAction.wait(forDuration: 0.5)
            let seq = SKAction.sequence([wait, moveX, rotate, moveY])
            station1.run(seq, completion: {
                self.station1.removeFromParent()
            })
            let shipRotation = SKAction.rotate(toAngle: 0, duration: 0.388)
            let seq2 = SKAction.sequence([wait, shipRotation])
            self.ship.run(seq2)
    }
    
        // HANDLES KEY PRESSES
        if spacePressed && !scene1HasBeenStarted {
            scene1HasBeenStarted = true
            startInfo.removeFromParent()
            movement1()
            
        } else if spacePressed {
            if !cooldownOn && scene1HasBeenStarted && station1.position.y > 100 {
                shootBeam()
            }
        }


        if rightPressed {
//            cam.position.x += 500 * dt
        }
        if leftPressed {
//            cam.position.x -= 500 * dt
        }
        if upPressed {
            if ship.position.y <= 2259.9458 {
                ship.position.y += 600 * dt
            }
        }
        if downPressed {
            if ship.position.y >= -2269.2424 {
                ship.position.y -= 600 * dt
            }
        }
        

    }
    
    func shootBeam() {
        let beam = SKSpriteNode(imageNamed: "Laser")
        beam.position = ship.position
        beam.position.x += ship.size.width/2
        beam.size.height *= 2
        // Handles collissions between beam and asteroids
        beam.physicsBody = SKPhysicsBody(rectangleOf: beam.size)
        beam.physicsBody?.isDynamic = true
        beam.physicsBody?.categoryBitMask = PhysicsCategory.projectile
        beam.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle
        beam.physicsBody?.collisionBitMask = PhysicsCategory.none
        beam.physicsBody?.usesPreciseCollisionDetection = true
        
                
        self.addChild(beam)
        let action = SKAction.moveTo(x: self.size.width, duration: 2)
        beam.run(SKAction.repeatForever(action))
        cooldownOn = true
    }
    
    func addAstPhysics(astVar: inout SKSpriteNode!) {
        astVar.physicsBody = SKPhysicsBody(rectangleOf: astVar.size)
        astVar.physicsBody?.isDynamic = true
        astVar.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        astVar.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
        astVar.physicsBody?.collisionBitMask = PhysicsCategory.none
    }
    
    
 func moveSprite (node : SKNode, moveByX: CGFloat, moveByY: CGFloat, forTheKey: String, duration: TimeInterval) {
    let moveAction = SKAction.moveBy(x: moveByX, y: moveByY, duration: duration)
    let seq = SKAction.sequence([moveAction])
    
    node.run(seq, withKey: forTheKey)
    }
    
    func resetBeamCooldown() {
        cooldownOn = false
    }
     
    @objc public static override var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func projectileDidCollideWithAst(projectile: SKSpriteNode, ast: SKSpriteNode) {
        print("Hit")
        projectile.removeFromParent()
        ast.removeFromParent()
    }

}
 

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.obstacle != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.projectile != 0)) {
            if let obstacle = firstBody.node as? SKSpriteNode,
               let projectile = secondBody.node as? SKSpriteNode {
                projectileDidCollideWithAst(projectile: projectile, ast: obstacle)
            }
        }
    }

}
