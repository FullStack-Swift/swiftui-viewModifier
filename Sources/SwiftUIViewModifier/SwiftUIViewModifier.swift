import SwiftUI

public struct CenterViewModifier: ViewModifier {
  
  public init() { }
  
  public func body(content: Content) -> some View {
    content
      .modifier(HCenterViewModifier())
      .modifier(VCenterViewModifier())
  }
}

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

public extension View {
  func centerModifier() -> some View {
    modifier(CenterViewModifier())
  }
}

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

public extension View {
  @ViewBuilder
  func withModifier<T: ViewModifier>(
    ifTrue valueTrue: Bool,
    modifier caseTrue: T
  ) -> some View {
    if valueTrue == true {
      modifier(caseTrue)
    }
  }
  
  @ViewBuilder
  func withModifier<T: ViewModifier>(
    ifFalse valueFalse: Bool,
    modifier caseFalse: T
  ) -> some View {
    if valueFalse == false {
      modifier(caseFalse)
    }
  }
  
  @ViewBuilder
  func withModifier<T1: ViewModifier, T2: ViewModifier>(
    ifTrue valueTrue: Bool,
    modifier caseTrue: T1,
    ifFalse valueFalse: Bool,
    modifier caseFalse: T2
  ) -> some View {
    if valueTrue == true {
      modifier(caseTrue)
    }
    if valueFalse == false {
      modifier(caseFalse)
    }
  }
  @ViewBuilder
  func withModifier<T1: ViewModifier, T2: ViewModifier>(
    bool value: Bool,
    modifierIfTrue caseTrue: T1,
    modifierIfFalse caseFalse: T2
  ) -> some View {
    if value == true {
      modifier(caseTrue)
    } else {
      modifier(caseFalse)
    }
  }
}
