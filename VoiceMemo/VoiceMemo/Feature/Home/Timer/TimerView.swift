import SwiftUI

struct TimerView: View {
  @StateObject private var vm = TimerVM()
  
  var body: some View {
    if vm.isDisplaySetTimeView {
      SetTimer(vm: vm)
    } else {
      TimerOperationView(vm: vm)
    }
  }
}

// MARK: - Timer 설정

private struct SetTimer: View {
  @ObservedObject private var vm: TimerVM
  
  fileprivate init(vm: TimerVM) {
    self.vm = vm
  }
  
  fileprivate var body: some View {
    VStack {
      Title()
      
      Spacer()
        .frame(height: 50)
      
      TimerPicker(vm: vm)
      
      Spacer()
        .frame(height: 30)
      
      TimerCreateButton(vm: vm)
      
      Spacer()
    }
  }
}

// MARK: - Title

private struct Title: View {
  fileprivate var body: some View {
    HStack {
      Text("타이머")
        .font(.system(size: 30, weight: .bold))
        .foregroundColor(.customBlack)
      
      Spacer()
    }
    .padding(.horizontal, 30)
    .padding(.top, 30)
  }
}

// MARK: - Timer Picker

private struct TimerPicker: View {
  @ObservedObject private var vm: TimerVM
  
  fileprivate init(vm: TimerVM) {
    self.vm = vm
  }
  
  fileprivate var body: some View {
    VStack {
      Rectangle()
        .fill(.customGray2)
        .frame(height: 1)
      
      HStack {
        Picker("Hour", selection: $vm.time.hours) {
          ForEach(0 ..< 24) {
            Text("\($0)시")
          }
        }
        
        Picker("Minute", selection: $vm.time.minutes) {
          ForEach(0 ..< 60) {
            Text("\($0)분")
          }
        }
        
        Picker("Second", selection: $vm.time.seconds) {
          ForEach(0 ..< 60) {
            Text("\($0)초")
          }
        }
      }
      .labelsHidden()
      .pickerStyle(.wheel)
      
      Rectangle()
        .fill(.customGray2)
        .frame(height: 1)
    }
  }
}

// MARK: - Create Timer Button

private struct TimerCreateButton: View {
  @ObservedObject private var vm: TimerVM
  
  fileprivate init(vm: TimerVM) {
    self.vm = vm
  }
  
  fileprivate var body: some View {
    Button {
      vm.didTapSettingButton()
    } label: {
      Text("설정하기")
        .font(.system(size: 18, weight: .bold))
        .foregroundColor(.customGreen)
    }
  }
}

// MARK: - Timer 작동 View

private struct TimerOperationView: View {
  @ObservedObject private var vm: TimerVM
  
  fileprivate init(vm: TimerVM) {
    self.vm = vm
  }
  
  fileprivate var body: some View {
    VStack {
      ZStack {
        VStack {
          Text("\(vm.timeRemaining.formattedTimeString)")
            .font(.system(size: 28))
            .foregroundColor(.customBlack)
            .monospaced()
          
          HStack(alignment: .bottom) {
            Image(systemName: "bell.fill")
          
            Text("\(vm.time.convertedSeconds.formattedSettingTime)")
              .font(.system(size: 16))
              .foregroundColor(.customBlack)
              .padding(.top, 10)
          }
        }
        
        Circle()
          .stroke(.customOrange, lineWidth: 6)
          .frame(width: 350)
      }
      
      Spacer()
        .frame(height: 10)
      
      HStack {
        Button {
          vm.didTapCancelButton()
        } label: {
          Text("취소")
            .font(.system(size: 16))
            .foregroundColor(.customBlack)
            .padding(.vertical, 25)
            .padding(.horizontal, 22)
            .background(
              Circle()
                .fill(.customGray2.opacity(0.3))
            )
        }
        
        Spacer()
        
        Button {
          vm.didTapPauseOrRestartButton()
        } label: {
          Text(vm.isPaused ? "계속진행" : "일시정지")
            .font(.system(size: 14))
            .foregroundColor(.customBlack)
            .padding(.vertical, 25)
            .padding(.horizontal, 7)
            .background(
              Circle()
                .fill(Color(red: 1, green: 0.75, blue: 0.52).opacity(0.3))
            )
        }
      }
      .padding(.horizontal, 20)
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView()
  }
}
