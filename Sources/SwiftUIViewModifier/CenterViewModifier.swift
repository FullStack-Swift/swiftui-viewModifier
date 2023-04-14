import SwiftUI

public struct CenterViewModifier: ViewModifier {

  public init() { }

  public func body(content: Content) -> some View {
    content
      .modifier(HCenterViewModifier())
      .modifier(VCenterViewModifier())
  }
}

public extension View {
  func centerModifier() -> some View {
    modifier(CenterViewModifier())
  }
}
