//
//  animatedImage.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import Foundation
import SwiftUI
import UIKit
import ImageIO

struct AnimatedImage: View {
    let gifName: String
    // @Binding var animateCompleted: Bool
    
    @State private var currentFrame: Int = 0
    @State private var totalFrames: Int = 0
    @State private var timer: Timer?
    
    var body: some View {
        Image(uiImage: frameImage(at: currentFrame))
            .resizable()
            .scaledToFit()
            .onAppear {
               loadFrames()
                startAnimating()
            }
            .onDisappear {
                stopAnimating()
            }
//            .onChange(of: currentFrame) { newValue in
//                if newValue == totalFrames - 1 {
//                  //  animateCompleted = true
//                }
           // }
    }
    
    private func loadFrames() {
        guard let gifURL = Bundle.main.url(forResource: gifName, withExtension: "gif"),
              let gifSource = CGImageSourceCreateWithURL(gifURL as CFURL, nil) else {
            return
        }
        
        totalFrames = CGImageSourceGetCount(gifSource)
    }
    
    private func frameImage(at index: Int) -> UIImage {
        guard let gifURL = Bundle.main.url(forResource: gifName, withExtension: "gif"),
              let gifSource = CGImageSourceCreateWithURL(gifURL as CFURL, nil),
              let cgImage = CGImageSourceCreateImageAtIndex(gifSource, index, nil) else {
            return UIImage()
        }
        
        return UIImage(cgImage: cgImage)
    }
    
    private func startAnimating() {
        guard totalFrames > 1 else {
            return
        }
        
        let frameDuration = 1.0 / 10.0 // Assuming 10 frames per second
        
        timer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
            currentFrame = (currentFrame + 1) % totalFrames
        }
    }
    
    private func stopAnimating() {
        timer?.invalidate()
        timer = nil
    }
}

