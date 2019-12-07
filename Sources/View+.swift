//
//  View+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 2019/07/03.
//  Copyright © 2019 tattn. All rights reserved.
//

#if canImport(SwiftUI)
import SwiftUI

#if canImport(UIKit)
@available(iOS 13.0, tvOS 13.0, *)
@available(OSX, unavailable)
@available(watchOS, unavailable)
public extension View {
    func wrappedInUIViewController() -> UIHostingController<Self> {
        UIHostingController(rootView: self)
    }

    func wrappedInUIView(parent: UIViewController) -> UIView {
        let hostingController = wrappedInUIViewController()
        parent.addChild(hostingController)
        hostingController.didMove(toParent: parent)
        return hostingController.view
    }
}
#endif // canImport(UIKit)

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    @inlinable var erased: AnyView { AnyView(self) }

    @inlinable func hidden(isHidden: Bool) -> Self? {
        isHidden ? nil : self
    }

    func onChangeSize(perform: @escaping (CGSize) -> Void) -> some View {
        self.background(SizePreferenceReader())
            .onPreferenceChange(SizePreferenceKey.self, perform: perform)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
private struct SizePreferenceReader: View {
    var body: some View {
        GeometryReader { geometry in
            return Rectangle()
                .foregroundColor(.clear)
                .preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }
}

#endif // canImport(SwiftUI)
