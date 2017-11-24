//
//  ListeningQuestionController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/08.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import AVFoundation

class ListeningQuestionController: UIViewController {
    var questions: [NormalQuestionViewModel] = []
    private var questionNumber = 0
    private var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    private let playButtonSize = CGSize(width: 30, height: 30)
    private var isPlaying: Bool = false {
        didSet {
            let image = isPlaying ? UIImage.fontAwesomeIcon(name: .pause, textColor: .black, size: playButtonSize) : UIImage.fontAwesomeIcon(name: .play, textColor: .black, size: playButtonSize)
            isPlaying ? playAudioButton.setImage(image, for: .normal) : playAudioButton.setImage(image, for: .normal)
        }
    }
    @IBOutlet weak var playAudioButton: UIButton!
    @IBOutlet weak var audioProgressBar: UIProgressView!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var radioButtonA: TDRadioButton!
    @IBOutlet weak var radioButtonB: TDRadioButton!
    @IBOutlet weak var radioButtonC: TDRadioButton!
    @IBOutlet weak var radioButtonD: TDRadioButton!
    @IBOutlet weak var questionLb: UILabel!
    @IBOutlet weak var answerALb: UILabel!
    @IBOutlet weak var answerBLb: UILabel!
    @IBOutlet weak var answerCLb: UILabel!
    @IBOutlet weak var answerDLb: UILabel!
    @IBOutlet weak var checkAnswerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        playAudioButton.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        checkAnswerButton.addTarget(self, action: #selector(moveNextQuestion), for: .touchUpInside)
    }

    private func setUpUI() {
        playAudioButton.setImage(UIImage.fontAwesomeIcon(name: .play, textColor: .black, size: CGSize(width: 30, height: 30)), for: .normal)
    }

    @objc private func moveNextQuestion() {
        questionNumber = questionNumber < questions.count - 1 ? questionNumber + 1 : questionNumber
        updateQuestion(numberQuestion: questionNumber)
        if questionNumber == questions.count - 1 {
            checkAnswerButton.setTitle("Kiểm tra đáp án", for: .normal)
        }
    }

    private func updateQuestion(numberQuestion: Int) {
        let question = questions[questionNumber]
        questionLb.text = "Câu \(numberQuestion + 1): \(question.question)"
        answerALb.text = question.answerA
        answerBLb.text = question.answerB
        answerCLb.text = question.answerC
        answerDLb.text = question.answerD
    }

    @objc private func playAudio() {
        let question = questions[questionNumber]
        guard let linkAudio = question.linkAudio else { return }
        playAudioFromUrl(url: linkAudio)
        isPlaying = !isPlaying
        //isPlaying ? audioPlayer.play() : audioPlayer.pause()
        if isPlaying {
            audioPlayer.play()
        } else {
            audioPlayer.pause()
        }
    }
    
    private func playAudioFromUrl(url: String) {
        do {
            guard let url = URL(string: url) else { return }
            let soundData = try Data(contentsOf: url)
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch let errorSession { print( errorSession) }
        } catch let error {
            print(error)
        }
    }
}
