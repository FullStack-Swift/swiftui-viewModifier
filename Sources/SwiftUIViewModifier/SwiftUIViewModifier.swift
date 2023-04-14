import SwiftUI

public struct CenterView<Content: View>: View {
  private let content: () -> Content
  public init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }
  
  public var body: some View {
    content()
      .withModifier(ifTrue: true, modifier: CenterViewModifier())
  }
}
