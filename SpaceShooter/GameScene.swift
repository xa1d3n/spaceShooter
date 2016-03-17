//
//  GameScene.swift
//  SpaceShooter
//
//  Created by Aldin Fajic on 3/16/16.
//  Copyright (c) 2016 Aldin Fajic. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var Player = SKSpriteNode(imageNamed: "PlayerShip")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        Player.position = CGPointMake(self.size.width / 2, self.size.height / 9)
        
        // spawn bullets every 0.2 seconds
        _ = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "spawnBullets", userInfo: nil, repeats: true)
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "spawnEnemies", userInfo: nil, repeats: true)

        self.addChild(Player)
    }
    
    func spawnEnemies() {
        // create enemy sprite
        let enemy = SKSpriteNode(imageNamed: "EnemyShip")
        // randomly place the images accross x axis
        let minValue = self.size.width / 8
        let maxValue = self.size.width - 20
        let spawnPoint = UInt32(maxValue - minValue)
        // spawn at random position along x axis
        enemy.position = CGPointMake(CGFloat(arc4random_uniform(spawnPoint)), self.size.height)
        
        // move down
        let animation = SKAction.moveToY(-70, duration: 3.0)
        let runForever = SKAction.repeatActionForever(animation)
        enemy.runAction(runForever)
        
        addChild(enemy)
    }
    
    func spawnBullets() {
        // create the bullet
        let bullet = SKSpriteNode(imageNamed: "Bullet")
        // set behind ship
        bullet.zPosition = -5
        // set position right behind ship
        bullet.position = CGPointMake(Player.position.x, Player.position.y)
        // animate so it moves up and disspears over
        let animation = SKAction.moveToY(self.size.height + 30, duration: 1.0)
        // run forever
        let runForever = SKAction.repeatActionForever(animation)
        bullet.runAction(runForever)
        addChild(bullet)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            // move player to touch location
            Player.position.x = location.x
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            // move player to touch location
            Player.position.x = location.x
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
