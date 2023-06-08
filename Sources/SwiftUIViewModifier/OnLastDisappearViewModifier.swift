import SwiftUI

fileprivate final class OnLastDisappearViewModel: ObservableObject {

  fileprivate var action: (() -> Void)?

  fileprivate init(action: (() -> Void)? = nil) {
    self.action = action
  }

  deinit {
    let clone = action
    action = nil
    Task.init { @MainActor in
      try await Task.sleep(seconds:0.03)
      clone?()
    }
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

extension Task where Success == Never, Failure == Never {
  static func sleep(seconds: Double) async throws {
    let duration = UInt64(seconds * 1_000_000_000)
    try await Task.sleep(nanoseconds: duration)
  }
}
