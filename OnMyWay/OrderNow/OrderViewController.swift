//
//  OrderViewController.swift
//  OnMyWay
//
//  Created by Tony Li on 10/6/17.
//  Copyright © 2017 Tony Li. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import googleapis

let SAMPLE_RATE = 16000
class OrderViewController: UIViewController, AudioControllerDelegate, UITextFieldDelegate {
    
    public var orders: OrderCollection = OrderCollection()
    //@IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var itemTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    var audioData: NSMutableData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AudioController.sharedInstance.delegate = self
        itemTextField.delegate = self;
        locationTextField.delegate = self;
    }
    @IBAction func confirmOrder(_ sender: UIButton) {
        orders.addOrder(location: locationTextField.text!, item: itemTextField.text!)
        var viewController = self.tabBarController?.viewControllers![2] as! MyOrdersTableViewController
        viewController.orders = orders
        tabBarController?.selectedIndex = 2
    }
    
    @IBAction func recordAudio(_ sender: NSObject) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
        } catch {
            
        }
        audioData = NSMutableData()
        _ = AudioController.sharedInstance.prepare(specifiedSampleRate: SAMPLE_RATE)
        SpeechRecognitionService.sharedInstance.sampleRate = SAMPLE_RATE
        _ = AudioController.sharedInstance.start()
    }
    
    @IBAction func stopAudio(_ sender: NSObject) {
        _ = AudioController.sharedInstance.stop()
        SpeechRecognitionService.sharedInstance.stopStreaming()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func processSampleData(_ data: Data) -> Void {
        audioData.append(data)
        
        // We recommend sending samples in 100ms chunks
        let chunkSize : Int /* bytes/chunk */ = Int(0.1 /* seconds/chunk */
            * Double(SAMPLE_RATE) /* samples/second */
            * 2 /* bytes/sample */);
        
        if (audioData.length > chunkSize) {
            SpeechRecognitionService.sharedInstance.streamAudioData(audioData,
                                                                    completion:
                { [weak self] (response, error) in
                    guard let strongSelf = self else {
                        return
                    }
                    
                    if let error = error {
                        strongSelf.textView.text = error.localizedDescription
                    } else if let response = response {
                        var finished = false
                        print(response)
                        for result in response.resultsArray! {
                            if let result = result as? StreamingRecognitionResult {
                                if result.isFinal {
                                    finished = true
                                }
                            }
                        }
                        
                        //strongSelf.textView.text = response.description
                        if finished {
                            for result in response.resultsArray! {
                                if let result = result as? StreamingRecognitionResult {
                                    if let alternative = result.alternativesArray[0] as? SpeechRecognitionAlternative{
                                        strongSelf.textView.text = alternative.transcript!
                                        let parser: Parser = Parser()
                                        var (item, location) = parser.match(transcript: alternative.transcript!)
                                        self!.itemTextField.text! = item
                                        self!.locationTextField.text! = location
                                    }
                                }
                            }
                        }
                        
                        
                        if finished {
                            strongSelf.stopAudio(strongSelf)
                        }
                    }
            })
            self.audioData = NSMutableData()
        }
    }
}
