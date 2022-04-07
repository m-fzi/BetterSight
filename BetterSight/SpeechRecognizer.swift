//
//  SpeechRecognizer.swift
//  BetterSight
//
//  Created by f on 28.03.2022.
//

import AVFoundation
import Foundation
import Speech
import SwiftUI

/// A helper for transcribing speech to text using SFSpeechRecognizer and AVAudioEngine.
class SpeechRecognizer: ObservableObject {
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnavailable
        
        var message: String {
            switch self {
            case .nilRecognizer: return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
            case .notPermittedToRecord: return "Not permitted to record audio"
            case .recognizerIsUnavailable: return "Recognizer is unavailable"
            }
        }
    }
    
    @Published var transcript: String = ""
    
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    
    /**
     Initializes a new speech recognizer. If this is the first time you've used the class, it
     requests access to the speech recognizer and the microphone.
     */
    init() {
        recognizer = SFSpeechRecognizer()
        
        Task(priority: .background) {
            do {
                guard recognizer != nil else {
                    throw RecognizerError.nilRecognizer
                }
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                speakError(error)
            }
        }
    }
    
    deinit {
        reset()
    }
    
    /**
        Begin transcribing audio.
     
        Creates a `SFSpeechRecognitionTask` that transcribes speech to text until you call `stopTranscribing()`.
        The resulting transcription is continuously written to the published `transcript` property.
     */
    func transcribe() {
        DispatchQueue(label: "Speech Recognizer Queue", qos: .background).async { [weak self] in
            guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                self?.speakError(RecognizerError.recognizerIsUnavailable)
                return
            }
            
            do {
                let (audioEngine, request) = try Self.prepareEngine()
                self.audioEngine = audioEngine
                self.request = request
                self.task = recognizer.recognitionTask(with: request, resultHandler: self.recognitionHandler(result:error:))
            } catch {
                print("Error on transcribe function.")
                print("Error transcript: \(self.transcript)")
                self.reset()
                self.speakError(error)
            }
        }
    }
    
    /// Stop transcribing audio.
    func stopTranscribing() {
        reset()
    }
    
    /// Reset the speech recognizer.
    func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    /// Want to use this function when game is roundup, but it doesn't let reset indexOfLastSpeechKeyWord.
//    func resetResult() {
//        indexOfLastSpeechKeyWord = -1
//        reset()
//        sleep(1)
//        transcribe()
//    }
    
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .mixWithOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        
        return (audioEngine, request)
    }
    
    private func recognitionHandler(result: SFSpeechRecognitionResult?, error: Error?) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil
        
        if receivedFinalResult || receivedError {
            audioEngine?.stop()
            audioEngine?.inputNode.removeTap(onBus: 0)
        }
        
        if let result = result {
            speak(result.bestTranscription.formattedString)
        }
    }

    var lastWord = ""
    var listeningIsStopped = false
    var resetResultTrigger = false
    let speechKeyWords = ["RIGHT", "LEFT", "UP", "DOWN"]
    
    // Reversed way to reduce looping. You can find the other option in below(commented out).
    private func speak(_ message: String) {
        print(message)
        
        lastWord = String(message.split(separator: " ").reversed()[0]).uppercased()
        if speechKeyWords.contains(lastWord) {
            if !listeningIsStopped {
                transcript = lastWord
            }
        }
    }
    
    private func speakError(_ error: Error) {
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        transcript = "<< \(errorMessage) >>"
    }
}

extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}



//var wordIndex = 0
//var temporaryWordIndex = 0
//var indexOfLastSpeechKeyWord = -1
//var oldTranscriptCount = 0
//var transcriptCountDifference = 0

//private func speak(_ message: String) {
//    print(message)
//    print(wordIndex, indexOfLastSpeechKeyWord)
//    for word in message.uppercased().split(separator: " ") {
//        if speechKeyWords.contains(String(word)) {
//            if wordIndex > indexOfLastSpeechKeyWord {
//                transcript = String(word)
//                indexOfLastSpeechKeyWord = wordIndex
//            }
//        }
//        wordIndex += 1
//    }
//    wordIndex = 0
//}

/// Reversed way to reduce looping. You can find the other option in below(commented out).
//private func speak(_ message: String) {
//    print(message)
//    transcriptCountDifference = message.split(separator: " ").count - oldTranscriptCount
//    print(transcriptCountDifference)
//    for word in message.uppercased().split(separator: " ").reversed()[0..<transcriptCountDifference] {
//        print(word)
//        if speechKeyWords.contains(String(word)) {
//            transcript = String(word)
//            oldTranscriptCount = message.split(separator: " ").count
//            return
//        }
//    }
//    oldTranscriptCount = message.split(separator: " ").count
//}

