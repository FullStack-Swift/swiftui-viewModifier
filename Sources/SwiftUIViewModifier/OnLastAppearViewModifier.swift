import SwiftUI

fileprivate final class OnLastAppearViewModel: ObservableObject {

  fileprivate let action: (() -> Void)?

  fileprivate init(action: (() -> Void)? = nil) {
    self.action = action
  }

  deinit {
    action?()
  }

}

public struct OnLastAppearViewModifier: ViewModifier {

  @StateObject
  private var viewModel: OnLastAppearViewModel

  public init(action: (() -> Void)? = nil) {
    _viewModel = StateObject(wrappedValue: OnLastAppearViewModel(action: action))
  }

  public func body(content: Content) -> some View {
    content
      .onAppear {}
      .onDisappear {}
  }
}

extension View {
  public func onLastAppear(perform action: (() -> Void)? = nil) -> some View {
    modifier(OnLastAppearViewModifier(action: action))
  }
}
