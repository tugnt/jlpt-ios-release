//
//  ListeningQuestionViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/08.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import AlamofireImage

class ListeningQuestionViewController: UIViewController, AVAudioPlayerDelegate {
    var questions: [ListeningQuestionModel] = []
    /// For request API
    var unit: Int!
    var type: TypeJLPT!
    var level: LevelJLPT!
    var isNormalQuestion: Bool = false
    
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
    @IBOutlet weak var checkAnswerButton: UIButton! {
        didSet {
            checkAnswerButton.clipsToBounds = true
            checkAnswerButton.layer.cornerRadius = 3
        }
    }
    @IBOutlet weak var timeCountdownLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var answerDContainerView: UIView!
    @IBOutlet weak var answerCContainerView: UIView!
    private var isInitialized = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Luyện tập"
        setUpUI()
        self.playAudioButton.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        self.checkAnswerButton.addTarget(self, action: #selector(moveNextQuestion), for: .touchUpInside)
        if !questions.isEmpty {
            self.updateQuestion(questionIndex: 0)
        }
        self.setFontSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNormalQuestion {
            self.fetchNormalListeningQuestion()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isInitialized && audioPlayer.isPlaying {
            audioPlayer.stop()
        }
    }
    
    private func fetchNormalListeningQuestion() {
        startAnimationLoading()
        let request = QuestionRequest(type: type, level: level, unit: unit)
        ApiClient.instance.request(request: request, completion: { (response) in
            self.stopAnimationLoading()
            switch response {
            case .success(let value):
                value.jlptQuestion.forEach { self.questions.append(ListeningQuestionModel(normalResponse: $0)) }
                self.updateQuestion(questionIndex: self.questionNumber)
            case .failure:
                break
            }
        })
    }
    
    
    private func setUpUI() {
        playAudioButton.setImage(UIImage.fontAwesomeIcon(name: .play, textColor: .black, size: CGSize(width: 30, height: 30)), for: .normal)
        checkAnswerButton.isEnabled = false
    }
    
    @objc private func moveNextQuestion() {
        userAnswer.append(curentUserAnswer)
        if questionNumber == questions.count - 1 {
            checkAnswer()
        } else {
            questionNumber = questionNumber < questions.count ? questionNumber + 1 : questionNumber
            updateQuestion(questionIndex: questionNumber)
            resetAllRadioButton()
        }
    }
    
    private func updateQuestion(questionIndex: Int) {
        let question = questions[questionNumber]
        questionNumber == questions.count - 1 ? checkAnswerButton.setTitle("Kiểm tra đáp án", for: .normal) : ()
        questionLb.text = "Câu \(questionIndex + 1): \(question.question)"
        let imageUrl = question.imageUrl ?? ""
        imageHeightConstraint.constant = imageUrl.isEmpty ? 0 : 250
        questionImage.isHidden = imageUrl.isEmpty
        Alamofire.request(imageUrl).responseImage { response in
            if let image = response.result.value {
                self.questionImage.image = image
            }
        }
        answerALb.text = question.answerA
        answerBLb.text = question.answerB
        answerCLb.text = question.answerC
        answerDLb.text = question.answerD
        checkAnswerButton.isEnabled = false
        answerCContainerView.isHidden = question.answerC.isEmpty
        answerDContainerView.isHidden = question.answerD.isEmpty
    }
    
    private func setFontSize() {
        let fontSize = CGFloat(Setting.fontSize)
        if fontSize != 0 {
            let font = UIFont.systemFont(ofSize: fontSize, weight: .thin)
            questionLb.font = font
            answerALb.font = font
            answerBLb.font = font
            answerCLb.font = font
            answerDLb.font = font
        }
    }
    
    private func resetAllRadioButton() {
        arrayRadioButton.forEach {
            $0.isClicked = false
        }
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
            isInitialized = true
        } catch _ {
            // TODO: Handle error here
        }
    }
    
    private var timer: Timer!
    private func startCountdown() {
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
        print(questions.count)
        print(userAnswer.count)
        for index in questions.indices {
            result += userAnswer[index] == Int(questions[index].solution) ? 1 : 0
        }
        let tdConfirmDialog = TDConfirmDialog(frame: view.bounds)
        tdConfirmDialog.set(title: "Kết quả")
        tdConfirmDialog.set(message: "Bạn đã trả lời đúng \(result) / \(questions.count) câu.")
        tdConfirmDialog.cancelButtonTitle = "Trở về"
        tdConfirmDialog.confirmButtonTitle = "Xem đáp án"
        tdConfirmDialog.cancelDidSelected = {
            self.navigationController?.popViewController(animated: true)
        }
        tdConfirmDialog.confirmDidSelected = {
            self.moveShowSolutionScreen()
        }
        view.addSubview(tdConfirmDialog)
    }
    
    private func moveShowSolutionScreen() {
        let vc = StoryboardScene.NomalQuestionViewController.normalQuestionViewController.instantiate()
        vc.questions = convertHintQuestionToNormalQuestion()
        vc.isShowSolution = true
        vc.isHasDoneButton = false
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func convertHintQuestionToNormalQuestion() -> [NormalQuestionViewModel] {
        var normalQuestions: [NormalQuestionViewModel] = []
        normalQuestions = questions.map { NormalQuestionViewModel(question: $0.question, answerA: $0.answerA, answerB: $0.answerB,
                                                                  answerC: $0.answerC, answerD: $0.answerD, solution: $0.solution,
                                                                  linkAudio: $0.audioUrl) }
        return normalQuestions
    }
}
