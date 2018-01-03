//
//  ListeningQuestionController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/08.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import AlamofireImage

class ListeningQuestionController: UIViewController, AVAudioPlayerDelegate {
    var questions: [HintQuestionModel] = []
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
    @IBOutlet var arrayRadioButton: [TDRadioButton]!
    private var curentUserAnswer: Int = 5
    private var userAnswer: [Int] = []
    private var isSelectedAnswer: Bool = false {
        didSet {
            checkAnswerButton.isEnabled = isSelectedAnswer
        }
    }
    @IBAction func radioButtonClicked(_ sender: TDRadioButton) {
        isSelectedAnswer = true
        curentUserAnswer = sender.tag
        for button in arrayRadioButton {
            button.isClicked = (button == sender)
        }
    }
    @IBOutlet weak var questionLb: UILabel!
    @IBOutlet weak var answerALb: UILabel!
    @IBOutlet weak var answerBLb: UILabel!
    @IBOutlet weak var answerCLb: UILabel!
    @IBOutlet weak var answerDLb: UILabel!
    @IBOutlet weak var checkAnswerButton: UIButton!
    @IBOutlet weak var timeCountdownLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Luyện tập"
        setUpUI()
        playAudioButton.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        checkAnswerButton.addTarget(self, action: #selector(moveNextQuestion), for: .touchUpInside)
        updateQuestion(questionIndex: 0)
    }

    private func setUpUI() {
        playAudioButton.setImage(UIImage.fontAwesomeIcon(name: .play, textColor: .black, size: CGSize(width: 30, height: 30)), for: .normal)
        checkAnswerButton.isEnabled = false
    }

    @objc private func moveNextQuestion() {
        userAnswer.append(curentUserAnswer)
        questionNumber = questionNumber < questions.count - 1 ? questionNumber + 1 : questionNumber
        updateQuestion(questionIndex: questionNumber)
        if questionNumber == questions.count - 1 {
            checkAnswerButton.setTitle("Kiểm tra đáp án", for: .normal)
            // Todo : Show đáp án here
            checkAnswer()
        }
    }

    private func updateQuestion(questionIndex: Int) {
        let question = questions[questionNumber]
        questionLb.text = "Câu \(questionIndex + 1): \(question.question)"
        guard let imageUrl = question.imageUrl else { return }
        Alamofire.request(imageUrl).responseImage { response in
            if let image = response.result.value {
                self.questionImage.image = image
            }
        }
        answerALb.text = question.answerA
        answerBLb.text = question.answerB
        answerCLb.text = question.answerC
        answerDLb.text = question.answerD
    }

    @objc private func playAudio() {
        let question = questions[questionNumber]
        guard let linkAudio = question.audioUrl else { return }
        playAudioFromUrl(url: linkAudio)
        isPlaying = !isPlaying
        if isPlaying {
            audioPlayer.play()
            startCountdown()
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
            audioPlayer.delegate = self
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch let error {
            print(error)
        }
    }

    private var timer: Timer!
    private func startCountdown() {
        // Time is total time of audio file
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeCoundownUI), userInfo: nil, repeats: true)
    }

    @objc private func updateTimeCoundownUI() {
        let curentTime = audioPlayer.currentTime
        let originMiniute = Int(audioPlayer.duration / 60)
        let originSecond = Int(Int(audioPlayer.duration) - originMiniute * 60)
        let miniute = Int(curentTime / 60)
        let second = Int(curentTime.truncatingRemainder(dividingBy: 60))
        timeCountdownLabel.text = "\(miniute):\(second)/\(originMiniute):\(originSecond)"
        // Update progress bar
        audioProgressBar.progress = Float(curentTime / audioPlayer.duration)
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        timer.invalidate()
        timer = nil
        audioProgressBar.progress = 1.0
        playAudioButton.setImage(UIImage.fontAwesomeIcon(name: .play, textColor: .black, size: CGSize(width: 30, height: 30)), for: .normal)
    }
    
    private func checkAnswer() {
        var result = 0
//        for (index, _) in questions {
//            result += userAnswer[index] == Int(questions[index].solution) ? 1 : 0
//        }
        print(result)
        let tdAlertView = TDModalStatusView(frame: view.bounds)
        view.addSubview(tdAlertView)
    }
}
