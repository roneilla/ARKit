//
//  ViewController.swift
//  Drawing App
//
//  Created by Roneilla Bumanlag on 2020-02-28.
//  Copyright © 2020 Roneilla Bumanlag. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.autoenablesDefaultLighting = true
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
        
        // Create a new scene
       // let scene = SCNScene()
        
        let scene = SCNScene(named: "JordansRoom_test6.dae")!
        
        sceneView.scene = scene

        let wait:SCNAction = SCNAction.wait(duration: 3)
        
        let runAfter:SCNAction = SCNAction.run { _ in
            self.addSceneContent()
        }
        
        let seq:SCNAction = SCNAction.sequence( [wait, runAfter] )
        sceneView.scene.rootNode.runAction(seq)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
//        guard let sceneView = sender.view as? ARSCNView else {
//            return
//        }
        
        let touchLocation = sender.location(in: sceneView)
        
        let hitTestResult = sceneView.hitTest(touchLocation, options: [:])
        
        if !hitTestResult.isEmpty {
            for hitResult in hitTestResult {
               if (hitResult.node.name == "Room") {
                print(hitResult.node.name)
                }
            }
        } else {
            
        }
        
    }
    
    func addSceneContent(){
        
          guard let modelNode = self.sceneView.scene.rootNode.childNode(withName: "Room", recursively: true) else { fatalError("model not found") }
                 
        modelNode.position = SCNVector3(0,0,-0.5)
                
        self.sceneView.scene.rootNode.addChildNode(modelNode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints, SCNDebugOptions.showPhysicsShapes]

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func view(_ view: ARSCNView, didAdd node: SCNNode, for anchor: ARAnchor){
       let newModelNode = SCNNode()
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
