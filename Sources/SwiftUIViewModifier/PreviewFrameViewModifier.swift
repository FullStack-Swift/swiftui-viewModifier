import SwiftUI

public struct PreviewFrameViewModifier: ViewModifier {
  
  @State private var isPresentedBackground: Bool = false
  
  public func body(content: Content) -> some View {
#if !DEBUG
    return content
#endif
    content
      .overlay(
        GeometryReader { geometry in
          let globalOrigin: CGPoint = geometry.frame(in: .global).origin
          let origin: String = "(x: \(rounded(globalOrigin.x)), y: \(rounded(globalOrigin.y)))"
          let size: String = "(w: \(rounded(geometry.size.width)), h: \(rounded(geometry.size.height)))"
          ZStack(alignment: .bottom) {
            if isPresentedBackground {
#if iOS
              Color(.systemBackground)
#endif
            }
            Rectangle()
              .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
              .foregroundColor(Color.red)
            Text("\(origin) | \(size)")
              .fontWeight(.bold)
              .foregroundColor(Color.red)
#if iOS
              .font(.caption2)
#endif
              .zIndex(9999)
              .onTapGesture {
                isPresentedBackground.toggle()
              }
          }
        }
      )
  }
  
  private func rounded(_ value: CGFloat) -> Float {
    return Float(round(100 * value) / 100)
  }
}

public extension View {
  func debugFrame() -> some View {
    return modifier(PreviewFrameViewModifier())
  }
}
