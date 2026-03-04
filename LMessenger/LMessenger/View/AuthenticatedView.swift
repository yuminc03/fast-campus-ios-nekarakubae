import SwiftUI

struct AuthenticatedView: View {
  @StateObject var vm: AuthenticationVM
  
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .padding()
  }
}

#Preview {
  AuthenticatedView(vm: .init())
}
