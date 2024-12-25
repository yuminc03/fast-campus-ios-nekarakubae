import SwiftUI

struct VoiceRecorderView: View {
  @StateObject private var vm = VoiceRecorderVM()
  @EnvironmentObject private var homeVM: HomeVM
  
  var body: some View {
    ZStack {
      VStack {
        Title()
        
        if vm.recordedFiles.isEmpty {
          AnnouncementView()
        } else {
          VoiceRecorderList(vm: vm)
        }
        
        Spacer()
      }
      
      RecordButton(vm: vm)
        .padding(.trailing, 20)
        .padding(.bottom, 20)
    }
    .alert("산텍된 음성메모를 삭제하시겠습니까?", isPresented: $vm.isDisplayRemoveVoiceRecorderAlert) {
      Button("삭제", role: .destructive) {
        vm.removeSelectedVoiceRecord()
      }
      
      Button("취소", role: .cancel) { }
    }
    .alert(vm.alertMessage, isPresented: $vm.isDisplayAlert) {
      Button("확인", role: .cancel) { }
    }
    .onChange(of: vm.recordedFiles) {
      homeVM.setVoiceRecorderCount($0.count)
    }
  }
}

// MARK: - Title

private struct Title: View {
  fileprivate var body: some View {
    HStack {
      Text("음성메모")
        .font(.system(size: 30, weight: .bold))
        .foregroundColor(.customBlack)
      
      Spacer()
    }
    .padding(.horizontal, 30)
    .padding(.top, 30)
  }
}

// MARK: - 음성메모 안내

private struct AnnouncementView: View {
  fileprivate var body: some View {
    VStack(spacing: 15) {
      Rectangle()
        .fill(Color.customCoolGray)
        .frame(height: 1)
      
      Spacer()
        .frame(height: 100)
      
      Image(.pencil)
        .renderingMode(.template)
      Text("현재 등록된 음성메모가 없습니다.")
      Text("하단의 녹음 버튼을 눌러 음성메모를 시작해주세요.")
      
      Spacer()
    }
    .font(.system(size: 16))
    .foregroundColor(.customGray2)
  }
}

// MARK: - 음성메모 List

private struct VoiceRecorderList: View {
  @ObservedObject private var vm: VoiceRecorderVM
  
  fileprivate init(vm: VoiceRecorderVM) {
    self.vm = vm
  }
  
  fileprivate var body: some View {
    ScrollView(.vertical) {
      VStack {
        Rectangle()
          .fill(.customGray2)
          .frame(height: 1)
        
        ForEach(vm.recordedFiles ?? [], id: \.self) { file in
          VoiceRecorderCell(vm: vm, recordedFile: file)
        }
      }
    }
  }
}

// MARK: - 음성메모 Cell

private struct VoiceRecorderCell: View {
  @ObservedObject private var vm: VoiceRecorderVM
  private var recordedFile: URL
  private var creationDate: Date?
  private var duration: TimeInterval?
  private var progressBarValue: Float {
    if vm.selectedRecordFile == recordedFile && (vm.isPlaying || vm.isPaused) {
      return Float(vm.playedTime) / Float(duration ?? 1)
    } else {
      return 0
    }
  }
  
  fileprivate init(vm: VoiceRecorderVM, recordedFile: URL) {
    self.vm = vm
    self.recordedFile = recordedFile
    (creationDate, duration) = vm.getFileInfo(for: recordedFile)
  }
  
  fileprivate var body: some View {
    VStack {
      Button {
        vm.didTapVoiceRecordCell(recordedFile)
      } label: {
        VStack {
          HStack {
            Text(recordedFile.lastPathComponent)
              .font(.system(size: 15, weight: .bold))
              .foregroundColor(.customBlack)
            
            Spacer()
          }
          
          Spacer()
            .frame(height: 5)
          
          HStack {
            if let creationDate {
              Text(creationDate.formattedVoiceRecorderTime)
                .font(.system(size: 14))
                .foregroundColor(.customIconGray)
            }
            
            Spacer()
            
            if vm.selectedRecordFile != recordedFile, let duration {
              Text(duration.formattedTimeInterval)
                .font(.system(size: 14))
                .foregroundColor(.customIconGray)
            }
          }
        }
      }
      .padding(.horizontal, 20)
      
      if vm.selectedRecordFile == recordedFile {
        VStack {
          ProgressBar(progress: progressBarValue)
            .frame(height: 2)
          
          Spacer()
            .frame(height: 5)
          
          HStack {
            Text(vm.playedTime.formattedTimeInterval)
              .font(.system(size: 10, weight: .medium))
              .foregroundColor(.customIconGray)
            
            Spacer()
            
            if let duration {
              Text(duration.formattedTimeInterval)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.customIconGray)
            }
          }
          
          Spacer()
            .frame(height: 10)
          
          HStack {
            Spacer()
            
            Button {
              if vm.isPaused {
                vm.resumePlaying()
              } else {
                vm.startPlaying(recordingURL: recordedFile)
              }
            } label: {
              Image(.play)
                .renderingMode(.template)
                .foregroundColor(.customBlack)
            }
            
            Spacer()
              .frame(width: 10)
            
            Button {
              if vm.isPlaying {
                vm.pausePlaying()
              }
            } label: {
              Image(.pause)
                .renderingMode(.template)
                .foregroundColor(.customBlack)
            }
            
            Spacer()
            
            Button {
              vm.didTapRemoveButton()
            } label: {
              Image(.trash)
                .renderingMode(.template)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.customBlack)
            }
          }
        }
        .padding(.horizontal, 20)
      }
      
      Rectangle()
        .fill(.customGray2)
        .frame(height: 1)
    }
  }
}

// MARK: - Progress Bar

private struct ProgressBar: View {
  private var progress: Float
  
  init(progress: Float) {
    self.progress = progress
  }
  
  fileprivate var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(.customGray2)
        
        Rectangle()
          .fill(.customGreen)
          .frame(width: CGFloat(progress) * geometry.size.width)
      }
    }
  }
}

// MARK: - 녹음 버튼

private struct RecordButton: View {
  @ObservedObject private var vm: VoiceRecorderVM
  @State private var isAnimation: Bool
  
  fileprivate init(
    vm: VoiceRecorderVM,
    isAnimation: Bool = false
  ) {
    self.vm = vm
    self.isAnimation = isAnimation
  }
  
  fileprivate var body: some View {
    VStack {
      Spacer()
      
      HStack {
        Spacer()
        
        Button {
          vm.didTapRecordButton()
        } label: {
          if vm.isRecording {
            Image(.micRecording)
              .scaleEffect(isAnimation ? 1.5 : 1)
              .onAppear {
                withAnimation(.spring().repeatForever()) {
                  isAnimation.toggle()
                }
              }
              .onDisappear {
                isAnimation = false
              }
          } else {
            Image(.mic)
          }
        }
      }
    }
  }
}

struct VoiceRecorderView_Previews: PreviewProvider {
  static var previews: some View {
    VoiceRecorderView()
  }
}
