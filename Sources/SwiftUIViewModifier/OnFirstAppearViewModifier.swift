import SwiftUI

public struct OnFirstAppearViewModifier: ViewModifier {

  private let action: (() -> Void)?

  @State private var hasAppeared = false

  public init(action: (() -> Void)? = nil) {
    self.action = action
  }

  public func body(content: Content) -> some View {
    content
      .onAppear {
      if !hasAppeared {
        hasAppeared = true
        action?()
      }
    }
  }
}

public extension View {
  func onFirstAppear(perform action: (() -> Void)? = nil) -> some View {
    modifier(OnFirstAppearViewModifier(action: action))
  }
}
