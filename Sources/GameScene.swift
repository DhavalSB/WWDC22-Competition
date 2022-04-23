import PlaygroundSupport
import SpriteKit
import AVFoundation

struct PhysicsCategory {
    static let none      : UInt32 = 0
    static let all       : UInt32 = UInt32.max
    static let obstacle  : UInt32 = 0b1
    static let projectile: UInt32 = 0b10
    static let ship      : UInt32 = 0b11
    static let planet    : UInt32 = 0b100
}

class GameScene: SKScene {
    
    var soundtrackPlayer = AVAudioPlayer()
    var shipAstCollSFX = AVAudioPlayer()
    
    var bd0b: SKNode!
    var ad0b: SKNode!
    
    var gameOver: Bool = false
    var storyOver: Bool = false
   
    var ship: SKSpriteNode!
    var rocket: SKSpriteNode!
    var station1: SKSpriteNode!
    
    var astronaut: SKSpriteNode!
   
//    Scene 1
    var ast1: SKSpriteNode!
    var ast2: SKSpriteNode!
    var ast3: SKSpriteNode!
    var ast4: SKSpriteNode!
    var ast5: SKSpriteNode!
    var ast6: SKSpriteNode!
    var ast7: SKSpriteNode!
    var ast8: SKSpriteNode!
    
//    Scene 2
    var ast9: SKSpriteNode!
    var ast10: SKSpriteNode!
    var ast11: SKSpriteNode!
    var ast12: SKSpriteNode!
    var ast13: SKSpriteNode!
    var ast14: SKSpriteNode!
    var ast15: SKSpriteNode!
    var ast16: SKSpriteNode!
    var ast17: SKSpriteNode!
    var ast18: SKSpriteNode!
    var ast19: SKSpriteNode!
    var ast20: SKSpriteNode!
    var ast21: SKSpriteNode!
    var ast22: SKSpriteNode!
    
//    Scene 3
    var ast23: SKSpriteNode!
    var ast24: SKSpriteNode!
    var ast25: SKSpriteNode!
    var ast26: SKSpriteNode!
    var ast27: SKSpriteNode!
    var ast28: SKSpriteNode!
    var ast29: SKSpriteNode!
    var ast30: SKSpriteNode!
    var ast31: SKSpriteNode!
    var ast32: SKSpriteNode!
    var ast33: SKSpriteNode!
    var ast34: SKSpriteNode!
    var ast35: SKSpriteNode!
    var ast36: SKSpriteNode!
    
    
    var mars: SKSpriteNode!
    var marsBg: SKSpriteNode!
    
    var phobos: SKSpriteNode!
    var phobosBg: SKSpriteNode!
    
    var earth : SKSpriteNode!
    var office: SKSpriteNode!
    var bd1b  : SKNode!
    var ad1b  : SKNode!
 
    
    var bg: SKSpriteNode!
    var bg2: SKSpriteNode!
    var bg3: SKSpriteNode!
    
    var startInfo: SKNode!
    var endScreen: SKNode!
    var thanksScreen: SKNode!
    
    var cam: SKCameraNode!
    
    var cooldownOn = false
    var beamCooldown:  Timer?
    
    override func didMove(to view: SKView) {
        
        //        DEFINES AUDIO PLAYERS
        let soundtrack = Bundle.main.path(forResource: "greendale", ofType: "mp3")
        do {
            soundtrackPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundtrack!))
        } catch {
            print(error)
        }
        //        -1 loops forever
        soundtrackPlayer.numberOfLoops = -1
        soundtrackPlayer.volume = 0.6
        soundtrackPlayer.prepareToPlay()
        
        let collSfx = Bundle.main.path(forResource: "Gameoversfx", ofType: "wav")
        do {
            shipAstCollSFX = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: collSfx!))
        } catch {
            print(error)
        }
        shipAstCollSFX.prepareToPlay()

        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
       
        bg = childNode(withName: "//SP1") as? SKSpriteNode
        
        station1 = childNode(withName: "//Space Station") as? SKSpriteNode
        
        ship = childNode(withName: "//Space Ship") as? SKSpriteNode
        //initializes collision physics
        ship.physicsBody = SKPhysicsBody(rectangleOf: ship.size)
        ship.physicsBody?.isDynamic = true
        ship.physicsBody?.categoryBitMask = PhysicsCategory.ship
        ship.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle
        ship.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        

        bd0b = childNode(withName: "//BD0B")
        ad0b = childNode(withName: "//AD0B")
        
//MARK: -        Scene 1
        
        ast1 = childNode(withName: "//Ast1") as? SKSpriteNode
        addAstPhysics(astVar: &ast1)

        ast2 = childNode(withName: "//Ast2") as? SKSpriteNode
        addAstPhysics(astVar: &ast2)
        
        ast3 = childNode(withName: "//Ast3") as? SKSpriteNode
        addAstPhysics(astVar: &ast3)
        
        ast4 = childNode(withName: "//Ast4") as? SKSpriteNode
        addAstPhysics(astVar: &ast4)
        
        ast5 = childNode(withName: "//Ast5") as? SKSpriteNode
        addAstPhysics(astVar: &ast5)
        
        ast6 = childNode(withName: "//Ast6") as? SKSpriteNode
        addAstPhysics(astVar: &ast6)
        
        ast7 = childNode(withName: "//Ast7") as? SKSpriteNode
        addAstPhysics(astVar: &ast7)
        
        ast8 = childNode(withName: "//Ast8") as? SKSpriteNode
        addAstPhysics(astVar: &ast8)
        
        mars = childNode(withName: "//Mars") as? SKSpriteNode
        marsBg = childNode(withName: "//Mars Bg 1") as? SKSpriteNode
       
        astronaut = childNode(withName: "//Astronaut") as? SKSpriteNode
        astronaut.physicsBody = SKPhysicsBody(rectangleOf: astronaut.size)
        astronaut.physicsBody?.isDynamic = true
        astronaut.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        
        rocket = childNode(withName: "//Rocket") as? SKSpriteNode
        
//MARK: -        Scene 2
  
        bg2 = childNode(withName: "//SP2") as? SKSpriteNode
        
        ast9 = childNode(withName: "//Ast9") as? SKSpriteNode
        addAstPhysics(astVar: &ast9)
        
        ast10 = childNode(withName: "//Ast10") as? SKSpriteNode
        addAstPhysics(astVar: &ast10)
        
        ast11 = childNode(withName: "//Ast11") as? SKSpriteNode
        addAstPhysics(astVar: &ast11)
        
        ast12 = childNode(withName: "//Ast12") as? SKSpriteNode
            addAstPhysics(astVar: &ast12)
        
        ast13 = childNode(withName: "//Ast13") as? SKSpriteNode
            addAstPhysics(astVar: &ast13)
        
        ast14 = childNode(withName: "//Ast14") as? SKSpriteNode
            addAstPhysics(astVar: &ast14)
        
        ast15 = childNode(withName: "//Ast15") as? SKSpriteNode
            addAstPhysics(astVar: &ast15)
        
        ast16 = childNode(withName: "//Ast16") as? SKSpriteNode
            addAstPhysics(astVar: &ast16)
        
        ast17 = childNode(withName: "//Ast17") as? SKSpriteNode
            addAstPhysics(astVar: &ast17)
       
        ast18 = childNode(withName: "//Ast18") as? SKSpriteNode
            addAstPhysics(astVar: &ast18)
        
        ast19 = childNode(withName: "//Ast19") as? SKSpriteNode
            addAstPhysics(astVar: &ast19)
        
        ast20 = childNode(withName: "//Ast20") as? SKSpriteNode
            addAstPhysics(astVar: &ast20)
       
        ast21 = childNode(withName: "//Ast21") as? SKSpriteNode
            addAstPhysics(astVar: &ast21)
        
        ast22 = childNode(withName: "//Ast22") as? SKSpriteNode
            addAstPhysics(astVar: &ast22)
        
        phobos = childNode(withName: "//Phobos") as? SKSpriteNode
        phobosBg = childNode(withName: "//Phobos Bg 1") as? SKSpriteNode
       
//MARK: -       Scene 3
        
        bg3 = childNode(withName: "//SP3") as? SKSpriteNode
        
        ast23 = childNode(withName: "//Ast23") as? SKSpriteNode
        addAstPhysics(astVar: &ast23)
        
        ast24 = childNode(withName: "//Ast24") as? SKSpriteNode
        addAstPhysics(astVar: &ast24)
        
        ast25 = childNode(withName: "//Ast25") as? SKSpriteNode
        addAstPhysics(astVar: &ast25)
        
        ast26 = childNode(withName: "//Ast26") as? SKSpriteNode
            addAstPhysics(astVar: &ast26)
        
        ast27 = childNode(withName: "//Ast27") as? SKSpriteNode
            addAstPhysics(astVar: &ast27)
        
        ast28 = childNode(withName: "//Ast28") as? SKSpriteNode
            addAstPhysics(astVar: &ast28)
        
        ast29 = childNode(withName: "//Ast29") as? SKSpriteNode
            addAstPhysics(astVar: &ast29)
        
        ast30 = childNode(withName: "//Ast30") as? SKSpriteNode
            addAstPhysics(astVar: &ast30)
        
        ast31 = childNode(withName: "//Ast31") as? SKSpriteNode
            addAstPhysics(astVar: &ast31)
       
        ast32 = childNode(withName: "//Ast32") as? SKSpriteNode
            addAstPhysics(astVar: &ast32)
        
        ast33 = childNode(withName: "//Ast33") as? SKSpriteNode
            addAstPhysics(astVar: &ast33)
        
        ast34 = childNode(withName: "//Ast34") as? SKSpriteNode
            addAstPhysics(astVar: &ast34)
       
        ast35 = childNode(withName: "//Ast35") as? SKSpriteNode
            addAstPhysics(astVar: &ast35)
        
        ast36 = childNode(withName: "//Ast36") as? SKSpriteNode
            addAstPhysics(astVar: &ast36)
        
        earth = childNode(withName: "//Earth") as? SKSpriteNode
        office = childNode(withName: "//Office") as? SKSpriteNode
        
        bd1b = childNode(withName: "//BD1B")
        ad1b = childNode(withName: "//AD1B")

        startInfo = childNode(withName: "//Start")
        endScreen = childNode(withName: "//Game Over")
        thanksScreen = childNode(withName: "//Story Over")
        
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
    var backstoryDone: Bool = false
    var scene1HasBeenStarted: Bool = false
    
    var onPlanet: Bool = false
    
    var onMars        : Bool = false
    var doneMarsFlag  : Bool = false
    
    var onPhobos      : Bool = false
    var donePhobosFlag: Bool = false
    
    
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
    
    if gameOver {
        endScreen.run(SKAction.fadeIn(withDuration: 1))
        ship.removeFromParent()
    }
    
    if storyOver {
        thanksScreen.run(SKAction.fadeIn(withDuration: 1))
        ship.removeFromParent()
    }
    
    func movement1(completionFunc: @escaping () -> Void) {
        let moveX = SKAction.moveBy(x: 1000, y: 0, duration: 1)
        let rotate = SKAction.rotate(toAngle: Double.pi/2, duration: 0.388)
        let moveY = SKAction.moveBy(x: 0, y: 4000, duration: 1)
        let wait = SKAction.wait(forDuration: 0.5)
        let seq = SKAction.sequence([wait, moveX, rotate, moveY])
        station1.run(seq, completion: {
            self.station1.removeFromParent()
            completionFunc()
        })
        let shipRotation = SKAction.rotate(toAngle: 0, duration: 0.388)
        let seq2 = SKAction.sequence([wait, shipRotation])
        self.ship.run(seq2)
        
    }
    func shipMove1() {
        moveSprite(node: bg, moveByX: -17901, moveByY: 0, forTheKey: "left", duration: 16)
        // camera 17901
    }
    func shipMove2() {
        moveSprite(node: bg2, moveByX: -17901, moveByY: 0, forTheKey: "left", duration: 16)
    }
    func shipMove3() {
        moveSprite(node: bg3, moveByX: -17901, moveByY: 0, forTheKey: "left", duration: 16)
    }
        
    if !backstoryDone {
//        Transition Scene to planet
        self.backstoryDone = true
        onPlanet = true
        cam.position = CGPoint(x: 0, y: -31300)
        
        astronaut.position = CGPoint(x: -3785.5, y: -32280.8)
        let walk = SKAction.moveTo(x: -1785.5, duration: 1)
        let wait = SKAction.wait(forDuration: 1)
        
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let wait2 = SKAction.wait(forDuration: 4)
        
        let seq1 = SKAction.sequence([wait, walk, wait])
        let seq2 = SKAction.sequence([fadeIn, wait2, fadeOut])
        astronaut.run(seq1) {
            self.bd0b.run(seq2) {
                self.ad0b.run(seq2) {
                    self.astronaut.texture = SKTexture(imageNamed: "astronautB")
                    self.astronaut.run(SKAction.moveTo(x: -3785.5, duration: 1)) {
                        self.astronaut.texture = SKTexture(imageNamed: "astronautA")
                        self.cam.position = CGPoint(x: 0, y: 0)
                        self.onPlanet = false
                    }
                }
        }
        }
    }
    
        // HANDLES KEY PRESSES
    if spacePressed && !scene1HasBeenStarted && backstoryDone && cam.position.y == 0 {
            scene1HasBeenStarted = true
            startInfo.removeFromParent()
            movement1() { //Completion
                shipMove1()
            }
            
        } else if spacePressed {
            if !cooldownOn && station1.position.y > 100 {
                shootBeam()
            }
        }


        if rightPressed {
            if ship.position.x < -840.190 && !onPlanet {
                ship.position.x += 500 * dt
            }
            else if onMars && astronaut.position.x < 12150 {
                astronaut.texture = SKTexture(imageNamed: "astronautA")
                astronaut.position.x += 1500 * dt
            }
            else if onPhobos && phobosBg.position.x > -9620 {
                astronaut.texture = SKTexture(imageNamed: "astronautA")
                phobosBg.position.x -= 1500 * dt
                rocket.position.x -= 1500 * dt
            }
            
        }
        if leftPressed {
            if ship.position.x > -2075.547 && !onPlanet {
                ship.position.x -= 500 * dt
            }
            else if onMars && astronaut.position.x > -1785.5 {
                astronaut.texture = SKTexture(imageNamed: "astronautB")
                astronaut.position.x -= 1500 * dt
            }
            else if onPhobos && phobosBg.position.x < 0 {
                astronaut.texture = SKTexture(imageNamed: "astronautB")
                phobosBg.position.x += 1500 * dt
                rocket.position.x += 1500 * dt
            }
        }
        if upPressed {
            if ship.position.y <= 2259.9458 && !onPlanet {
                ship.position.y += 600 * dt
            }
        }
        if downPressed {
            if ship.position.y >= -2269.2424 && !onPlanet {
                ship.position.y -= 600 * dt
            }
        }
    
    if (onPlanet){
        if onMars {
            if astronaut.position.x > -484 && astronaut.position.x < 9500 {
                cam.position.x = astronaut.position.x + 484
            } else if astronaut.position.x < 2500 {
                cam.position.x = 0
            }
        }
        
        if onMars && !doneMarsFlag {
            if astronaut.position.x >= 8573.737 {
                doneMarsFlag = true
                let wait = SKAction.wait(forDuration: 1)
                let seq = SKAction.sequence([wait])
                onPlanet = false
                onMars = false
                astronaut.run(seq) {
                    
//MARK:    REPLACES OLD BG WITH NEW ONE TO MAKE THINGS EASIER
                    
                    self.bg.position = CGPoint(x: 0, y: 6000)
                    self.bg2.position = CGPoint(x: 0, y: 0)
                    
                    self.ship.position = CGPoint(x: -1920, y: 0)
                    self.cam.position = CGPoint(x: 0, y: 0)
                    
                    shipMove2()
                }
            }
        }
        if onPhobos && !donePhobosFlag {
            if phobosBg.position.x <= -9620 {
                donePhobosFlag = true
                let wait = SKAction.wait(forDuration: 1)
                let seq = SKAction.sequence([wait])
                onPlanet = false
                onPhobos = false
                astronaut.run(seq) {
//MARK:    REPLACES OLD BG WITH NEW ONE TO MAKE THINGS EASIER
                    
                    self.bg2.position = CGPoint(x: 0, y: 6000)
                    self.bg3.position = CGPoint(x: 0, y: 0)
                    
                    self.ship.position = CGPoint(x: -1920, y: 0)
                    self.cam.position = CGPoint(x: 0, y: 0)
                    
                    shipMove3()
                }
            }
        }
    }
        
    if ship.intersects(mars) && !gameOver {
    //        Transition Scene to planet
        ship.position.x = -10000
        
        bg.removeFromParent()
        
        onPlanet = true
        astronaut.alpha = 0
        rocket.position = CGPoint(x: -1722, y: -2403.5)
        cam.position = CGPoint(x: 0, y: -6460)
        let land = SKAction.moveTo(y: -7384, duration: 2)
        rocket.run(land) {
            
            self.astronaut.position = CGPoint(x: -1785.5, y: -7870.72)
            self.astronaut.alpha = 1
            let walkOut = SKAction.moveBy(x: 1300, y: 0, duration: 1)
            let wait = SKAction.wait(forDuration: 0.5)
            let seq = SKAction.sequence([wait, walkOut])
            self.astronaut.run(seq)
            
            self.onMars = true

        }
    }
    
    if ship.intersects(phobos) && !gameOver {
      //        Transition Scene to planet
        ship.position.x = -10000
        
        bg2.removeFromParent()
               
        onPlanet = true
        astronaut.alpha = 0
        rocket.position = CGPoint(x: -1722, y: -14100)
        cam.position = CGPoint(x: 0, y: -19140)
        let land = SKAction.moveTo(y: -20200, duration: 2)
        rocket.run(land) {
            
            self.astronaut.position = CGPoint(x: -1785.5, y: -20740)
            self.astronaut.alpha = 1
            let walkOut = SKAction.moveBy(x: 1300, y: 0, duration: 1)
            let wait = SKAction.wait(forDuration: 0.5)
            let seq = SKAction.sequence([wait, walkOut])
            self.astronaut.run(seq)
            
            self.onPhobos = true

        }
    }
    if ship.intersects(earth) && !gameOver {
      //        Transition Scene to planet
        ship.position.x = -10000
        
        bg3.removeFromParent()
               
        onPlanet = true
        cam.position = CGPoint(x: 0, y: -31300)
        
        astronaut.position = CGPoint(x: -3785.5, y: -32280.8)
        let walk = SKAction.moveTo(x: -1785.5, duration: 1)
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let wait = SKAction.wait(forDuration: 5)
        let seq = SKAction.sequence([fadeIn, wait, fadeOut])
        astronaut.run(walk) {
            self.bd1b.run(seq) {
                self.ad1b.run(seq) {
//                   Fade game out and show end screen
                    self.storyOver = true
                }
        }
        
    }
            

    }
}
    
    func shootBeam() {
        if !gameOver {
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
            
//MARK: ATTEMPT TO DELETE BEAMS AFTER A BIT
//            let repAction = SKAction.repeat(action, count: 1)
//            beam.run(repAction) {
//                beam.removeFromParent()
//            }
            cooldownOn = true
        }
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
    
    
    func shipDidCollideWithAst(ship: SKSpriteNode, ast: SKSpriteNode) {
        print("Collision!")
        ship.alpha = 0
        gameOver = true
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
        
        if ((firstBody.categoryBitMask & PhysicsCategory.obstacle != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.ship != 0)) {
            if let ship = firstBody.node as? SKSpriteNode,
               let obstacle = secondBody.node as? SKSpriteNode {
                shipDidCollideWithAst(ship: ship, ast: obstacle)
            }
        }
    }

}
