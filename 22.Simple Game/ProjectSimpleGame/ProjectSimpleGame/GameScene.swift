//
//  GameScene.swift
//  ProjectSimpleGame
//
//  Created by 刘庆文 on 5-26.
//  Copyright © 2018 Liuqingwens. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory
{
    static let none      :UInt32 = 0b00
    static let all       :UInt32 = UInt32.max
    static let monster   :UInt32 = 0b01
    static let projectile:UInt32 = 0b10
}

class GameScene: SKScene, SKPhysicsContactDelegate
{
    private let player = SKSpriteNode(imageNamed: "player")
    private let labelInfo = SKLabelNode()
    private var enemiesDestroyed = 0
    
    override func didMove(to view: SKView)
    {
        super.didMove(to: view)
        self.backgroundColor = SKColor.white
        self.setupWorld()
        
        self.setupPlayer()
        self.setupEnemies()
    }
    
    private func setupWorld()
    {
        self.physicsWorld.gravity = CGVector.zero
        self.physicsWorld.contactDelegate = self
        
        self.labelInfo.fontSize = 24
        self.labelInfo.fontColor = SKColor.red
        self.labelInfo.position = CGPoint(x: self.size.width * 0.5, y: self.size.height - 40)
        self.addChild(self.labelInfo)
        
        updateLabelText()
    }
    
    private func updateLabelText()
    {
        self.labelInfo.text = "Killed enemies: \(self.enemiesDestroyed)"
    }
    
    private func setupPlayer()
    {
        self.player.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.5)
        self.addChild(self.player)
    }
    
    private func setupEnemies()
    {
        let actions = [SKAction.run(addEnemy), SKAction.wait(forDuration: 1.0)]
        self.run(SKAction.repeatForever(SKAction.sequence(actions)))
    }
    
    private func addEnemy()
    {
        let enemy = SKSpriteNode(imageNamed: "monster")
        
        let random = drand48() //from 0.0-0.1
        let side = random < 0.5 ? -1 : 1
        
        enemy.xScale = CGFloat(side)
        
        let halfSize = self.size.width * 0.5 + enemy.size.width * 0.5
        let x = CGFloat(side) * halfSize + self.size.width * 0.5
        let y = CGFloat(random) * (self.size.height - enemy.size.height) + enemy.size.height * 0.5
        enemy.position = CGPoint(x: x, y: y)
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.categoryBitMask = PhysicsCategory.monster
        enemy.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
        enemy.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        self.addChild(enemy)
        
        let duration = random * 2.0 + 2.0
        let endX = CGFloat(-side) * halfSize + self.size.width * 0.5
        
        let actionMove = SKAction.move(to: CGPoint(x: endX, y: y), duration: duration)
        let actionMoveDone = SKAction.removeFromParent()
        enemy.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard let touch = touches.first else{
            return
        }
        let touchLocation = touch.location(in: self)
        let offset = touchLocation - self.player.position
        if (offset.x < 0 || offset.length < 1.0)
        {
            return
        }
        
        let projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = self.player.position
        
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width * 0.5)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.monster
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.none
        projectile.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(projectile)
        
        let endPosition = offset.normalized * 1000 + self.player.position
        let actionMove = SKAction.move(to: endPosition, duration: 2.0)
        let actionModeDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionModeDone]))
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) != (PhysicsCategory.projectile | PhysicsCategory.monster) {
            return
        }
        
        if let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node {
            nodeA.run(SKAction.removeFromParent())
            nodeB.run(SKAction.removeFromParent())
            
            self.enemiesDestroyed += 1
            self.updateLabelText()
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact)
    {
        print("No dealing of contacts: \(contact.bodyA.categoryBitMask) & \(contact.bodyB.categoryBitMask)")
    }
    
}
