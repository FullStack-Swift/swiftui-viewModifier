import SwiftUI

public struct HCenterViewModifier: ViewModifier {

  public init() { }

  public func body(content: Content) -> some View {
    HStack {
      Spacer()
      content
      Spacer()
    }
  }
}

public struct VCenterViewModifier: ViewModifier {

  public init() { }

  public func body(content: Content) -> some View {
    VStack {
      Spacer()
      content
      Spacer()
    }
  }
}
