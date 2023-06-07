import SwiftUI

fileprivate final class OnLastDisappearViewModel: ObservableObject {

  fileprivate var action: (() -> Void)?

  fileprivate init(action: (() -> Void)? = nil) {
    self.action = action
  }

  deinit {
    let clone = action
    action = nil
    clone?()
  }
}

public struct OnLastDisappearViewModifier: ViewModifier {

  @StateObject
  private var viewModel: OnLastDisappearViewModel

  public init(action: (() -> Void)? = nil) {
    _viewModel = StateObject(wrappedValue: OnLastDisappearViewModel(action: action))
  }

  public func body(content: Content) -> some View {
    content
      .onAppear {}
      .onDisappear {}
  }
}

extension View {
  public func onLastDisappear(perform action: (() -> Void)? = nil) -> some View {
    modifier(OnLastDisappearViewModifier(action: action))
  }
}
