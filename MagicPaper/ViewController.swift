//
//  ViewController.swift
//  MagicPaper
//
//  Created by Denis Aleksandrov on 12/30/20.
//  https://svetotnabibi.mk/svetot-na-bibi-od-a-do-sh
//  https://deca.mk/category/bibiverzum/
//  http://bibiland.mk

import UIKit
import SceneKit
import ARKit
import youtube_ios_player_helper

class ViewController: UIViewController, ARSCNViewDelegate, YTPlayerViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var ytPlayerView: YTPlayerView!
    
    static let vAzbukataNaBibiId  = "VyyyNQn0-jw"
    static let vAzbukataNaBibiUrl = "https://www.youtube.com/watch?v=" + vAzbukataNaBibiId
    static let vAzbukataNaBibiMp4 = "azbukata-na-bibi.mp4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        ytPlayerView.delegate = self
        
        sceneView.showsStatistics = true
        
        //ytPlayerView.load(withVideoId: ViewController.vAzbukataNaBibiId, playerVars: ["playsinline": "1"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "ImagesOnPaper", bundle: Bundle.main) {
            configuration.trackingImages = trackedImages
            configuration.maximumNumberOfTrackedImages = trackedImages.count
        }

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    // The anchor is the tracked image that was found
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let videoNode = SKVideoNode(fileNamed: ViewController.vAzbukataNaBibiMp4)
            videoNode.play()
            let videoScene = SKScene(size: CGSize(width: 480, height: 360))
            videoNode.position = CGPoint(
                x: videoScene.size.width / 2,
                y: videoScene.size.height / 2
            )
            videoNode.yScale = -1.0
            videoScene.addChild(videoNode)
            
            // https://hackernoon.com/playing-videos-in-augmented-reality-using-arkit-7df3db3795b7
            //let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
            //let request = URLRequest(url: URL(string: "http://www.amazon.com")!)
            //webView.loadRequest(request)
            
            let plane = SCNPlane(
                width:  imageAnchor.referenceImage.physicalSize.width,
                height: imageAnchor.referenceImage.physicalSize.height
            )
            plane.firstMaterial?.diffuse.contents = videoScene //webView //UIColor(white: 1.0, alpha: 0.5)
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
        }
        
        return node
    }
}
