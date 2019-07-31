//
//  ViewController.swift
//  Scribe
//
//  Created by Teodora Knezevic on 7/10/19.
//  Copyright © 2019 Teodora Knezevic. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class ViewController: UIViewController,AVAudioPlayerDelegate {
    
    @IBOutlet weak var transcriptionTextField: UITextView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    var audioPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activitySpinner.isHidden = true
        
    }
    
    func requestSpeechAuth(){
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a"){
                    
                    do{
                        
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        sound.play()                          //on je ovo stavi ispod delegate
                        self.audioPlayer.delegate = self
                    }catch{
                        print("ERROR")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
                        if let error = error {
                            print("There was error: \(error)")
                        }
                        else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    })
                }
                
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    

    @IBAction func playBtnPressed(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
    
}

