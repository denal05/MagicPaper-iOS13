//
//  ViewController.swift
//  MagicPaper
//
//  Created by Denis Aleksandrov on 12/30/20.
//

import UIKit
import youtube_ios_player_helper

class ViewController: UIViewController {

    @IBOutlet weak var playerView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // https://johncodeos.com/how-to-embed-youtube-videos-into-your-ios-app-using-swift/
        playerView.load(withVideoId: "YE7VzlLtp-4", playerVars: ["playsinline": "1"])
    }


}

