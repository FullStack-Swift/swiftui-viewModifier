import SwiftUI

public struct AnonymousViewModifier: ViewModifier {

  private let makeBody: ( inout Content) -> any View

  public init<T: ViewModifier>(_ modifier: T) {
    self.makeBody = { $0.modifier(modifier) }
  }

  public init(
    _ makeBody: @escaping (inout Content) -> any View
  ) {
    self.makeBody = { makeBody(&$0) }
  }

  public func body(content: Content) -> some View {
    var result = content
    return AnyView(makeBody(&result))
  }
}
