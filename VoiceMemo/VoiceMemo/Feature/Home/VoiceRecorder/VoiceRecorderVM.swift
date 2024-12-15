import AVFoundation

final class VoiceRecorderVM: NSObject, ObservableObject, AVAudioPlayerDelegate {
  @Published var isDisplayRemoveVoiceRecorderAlert: Bool
  @Published var isDisplayErrorAlert: Bool
  @Published var errorAlertMessage: String
  
  // 음성 녹음 관련 프로퍼티
  var audioRecorder: AVAudioRecorder?
  @Published var isRecording: Bool
  
  // 음성 재쟁 관련 프로퍼티
  var audioPlayer: AVAudioPlayer?
  @Published var isPlaying: Bool
  @Published var isPaused: Bool
  @Published var playedTime: TimeInterval
  private var progressTimer: Timer?
  
  /// 음성 메모된 파일
  var recordedFiles: [URL]?
  
  /// 현재 선택된 음성메모 파일
  @Published var selectedRecordFile: URL?
  
  init(
    isDisplayRemoveVoiceRecorderAlert: Bool = false,
    isDisplayErrorAlert: Bool = false,
    errorAlertMessage: String = "",
    isRecording: Bool = false,
    isPlaying: Bool = false,
    isPaused: Bool = false,
    playedTime: TimeInterval = 0,
    recordedFiles: [URL] = [],
    selectedRecordFile: URL? = nil
  ) {
    self.isDisplayRemoveVoiceRecorderAlert = isDisplayRemoveVoiceRecorderAlert
    self.isDisplayErrorAlert = isDisplayErrorAlert
    self.errorAlertMessage = errorAlertMessage
    self.isRecording = isRecording
    self.isPlaying = isPlaying
    self.isPaused = isPaused
    self.playedTime = playedTime
    self.recordedFiles = recordedFiles
    self.selectedRecordFile = selectedRecordFile
  }
}

extension VoiceRecorderVM {
  func didTapVoiceRecordCell(_ recordedFile: URL) {
    if selectedRecordFile != recordedFile {
      stopPlaying()
      selectedRecordFile = recordedFile
    }
  }
  
  func didTapRemoveButton() {
    setIsDisplayRemoveVoiceRecorderAlert(true)
  }
  
  func removeSelectedVoiceRecord() {
    guard let fileToRemove = selectedRecordFile,
          let indexToRemove = recordedFiles?.firstIndex(of: fileToRemove)
    else {
      displayAlert(message: "선택된 음성메모 파일을 찾을 수 없습니다.")
      return
    }
    
    do {
      try FileManager.default.removeItem(at: fileToRemove)
      recordedFiles?.remove(at: indexToRemove)
      selectedRecordFile = nil
      stopPlaying()
      displayAlert(message: "선택된 음성메모 파일을 성공적으로 삭제했습니다.")
    } catch {
      displayAlert(message: "선택된 음성메모 파일 삭제 중 오류가 발생했습니다.")
    }
  }
  
  private func setIsDisplayRemoveVoiceRecorderAlert(_ isDisplay: Bool) {
    isDisplayRemoveVoiceRecorderAlert = isDisplay
  }
  
  private func setErrorAlertMessage(_ message: String) {
    errorAlertMessage = message
  }
  
  private func setIsDisplayErrorAlert(_ isDisplay: Bool) {
    isDisplayErrorAlert = isDisplay
  }
  
  private func displayAlert(message: String) {
    setErrorAlertMessage(message)
    setIsDisplayErrorAlert(true)
  }
}

// MARK: - 음성 메모 녹음 관련

extension VoiceRecorderVM {
  func didTapRecordButton() {
    selectedRecordFile = nil
    
    if isPlaying {
      stopPlaying()
      startRecording()
    } else if isRecording {
      stopRecording()
    } else {
      startRecording()
    }
  }
  
  private func startRecording() {
    let fileURL = getDocumentsDirectory().appendingPathComponent("새로운 녹음 \((recordedFiles?.count ?? 0) + 1)")
    let settings = [
      AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
      AVSampleRateKey: 12000,
      AVNumberOfChannelsKey: 1,
      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    do {
      audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
      audioRecorder?.record()
      isRecording = true
    } catch {
      displayAlert(message: "음성 메모 녹음 중 오류가 발생했습니다.")
    }
  }
  
  private func stopRecording() {
    audioRecorder?.stop()
    recordedFiles?.append(audioRecorder?.url ?? .userDirectory)
    isRecording = false
  }
  
  private func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}

// MARK: - 음성메모 재생 관련

extension VoiceRecorderVM {
  func startPlaying(recordingURL: URL) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: recordingURL)
      audioPlayer?.delegate = self
      audioPlayer?.play()
      isPlaying = true
      isPaused = false
      progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
        self.updateCurrentTime()
      }
    } catch {
      displayAlert(message: "음성메모 재생 중 오류가 발생했습니다.")
    }
  }
  
  private func updateCurrentTime() {
    playedTime = audioPlayer?.currentTime ?? 0
  }
  
  private func stopPlaying() {
    audioPlayer?.stop()
    playedTime = 0
    progressTimer?.invalidate()
    isPlaying = false
    isPaused = false
  }
  
  func pausePlaying() {
    audioPlayer?.pause()
    isPaused = true
  }
  
  func resumePlaying() {
    audioPlayer?.play()
    isPaused = false
  }
  
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successFully flag: Bool) {
    isPlaying = false
    isPaused = false
  }
  
  func getFileInfo(for url: URL) -> (Date?, TimeInterval?) {
    let fileManager = FileManager.default
    var creationDate: Date?
    var duration: TimeInterval?
    
    do {
      let fileAttributes = try fileManager.attributesOfItem(atPath: url.path)
      creationDate = fileAttributes[.creationDate] as? Date
    } catch {
      displayAlert(message: "선택된 음성메모 파일 정보를 불러올 수 없습니다.")
    }
    
    do {
      let audioPlayer = try AVAudioPlayer(contentsOf: url)
      duration = audioPlayer.duration
    } catch {
      displayAlert(message: "선택된 음성메모 파일의 재생 시간을 불러올 수 없습니다.")
    }
    
    return (creationDate, duration)
  }
}
