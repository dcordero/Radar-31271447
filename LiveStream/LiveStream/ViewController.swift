//
//  ViewController.swift
//  LiveStream
//
//  Created by David Cordero on 27.03.17.
//  Copyright © 2017 David Cordero. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class LiveStreamViewController: AVPlayerViewController, AVPlayerViewControllerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate = self
        play(stream: URL(string: "https://demo-hls5-live.zahs.tv/hd/master.m3u8?timeshift=100")!)
    }
    
    // MARK: AVPlayerViewControllerDelegate
    
    func playerViewController(_ playerViewController: AVPlayerViewController, timeToSeekAfterUserNavigatedFrom oldTime: CMTime, to targetTime: CMTime) -> CMTime {
        
        if let firstSeekableRange = playerViewController.player?.currentItem?.seekableTimeRanges.first?.timeRangeValue {
            
            if targetTime < firstSeekableRange.start {
                print("Seeking a not longer seekable position")
            }
        }
        
        return targetTime
    }
    
    // MARK: - Private
    
    private func play(stream: URL) {
        let asset = AVAsset(url: stream)
        let playetItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playetItem)
        player?.play()
    }
}

