//
//  UIImageTests.swift
//  SwiftExtensionsTests
//
//  Created by Tatsuya Tanaka on 2019/04/06.
//  Copyright © 2019 tattn. All rights reserved.
//

import XCTest
import SwiftExtensions

#if canImport(UIKit)
class UIImageTests: XCTestCase {
    private lazy var scaleTransform = CGAffineTransform(scaleX: UIScreen.main.scale, y: UIScreen.main.scale)

    func testTestImage() {
        XCTAssertEqual(TestImage.image.scale, 1)
        XCTAssertEqual(TestImage.image.size, TestImage.image3x.size.applying(.init(scaleX: 3, y: 3)))
    }

    func testPixelColor() {
        let image = TestImage.image

        func assert(pixelColor: (CGPoint) -> UIColor?, message: String) {
            XCTAssertNil(pixelColor(.init(x: -1, y: 0)), message)
            XCTAssertNil(pixelColor(.init(x: 0, y: -1)), message)
            XCTAssertNil(pixelColor(.init(x: image.size.width, y: 0)), message)
            XCTAssertNil(pixelColor(.init(x: 0, y: image.size.height)), message)
            XCTAssertEqual(pixelColor(.zero), UIColor(red: 236, green: 216, blue: 182), message)
            XCTAssertEqual(pixelColor(.init(x: image.size.width - 1, y: image.size.height - 1)), UIColor(red: 62, green: 56, blue: 71), message)
        }

        assert(pixelColor: image.pixelColor(at:), message: "pixelColor")

        let image3x = TestImage.image3x
        let pixelColor3x = image3x.pixelColor(at:)
        assert(pixelColor: pixelColor3x, message: "pixelColor3x")
        XCTAssertNotNil(pixelColor3x(.init(x: image3x.size.width, y: 0)))
        XCTAssertNotNil(pixelColor3x(.init(x: 0, y: image3x.size.height)))

        let pixelColor3xLeft = TestImage.image3xLeft.pixelColor(at:)
        assert(pixelColor: pixelColor3xLeft, message: "pixelColor3xLeft")
    }

    func testInitColor() {
        let color = UIColor.red
        let size = CGSize(width: 100, height: 80)
        let colorImage = UIImage(color: color, size: size)

        XCTAssertEqual(colorImage.canonicalized.pixelColor(at: .zero), UIColor.red)
        XCTAssertEqual(colorImage.canonicalized.pixelColor(at: .init(x: size.width - 1, y: size.height - 1)), UIColor.red)
        XCTAssertEqual(colorImage.size, size.applying(scaleTransform))
    }

    func testTintColor() {
        let tintedImage = TestImage.image.image(withTint: .red)
//        XCTAssertEqual(tintedImage.canonicalized.pixelColor(at: .zero), UIColor(red: 216, green: 0, blue: 0, alpha: 216 / 255.0))
//        XCTAssertEqual(tintedImage.canonicalized.pixelColor(at: .init(x: tintedImage.cgImage!.width - 1, y: tintedImage.cgImage!.height - 1)), UIColor(red: 59, green: 0, blue: 0, alpha: 59 / 255.0))
        XCTAssertEqual(tintedImage.size, TestImage.image.size)
    }

    func testCropped() {
        XCTAssertEqual(TestImage.image.cropped(to: .zero).size, .zero)
        XCTAssertEqual(TestImage.image.cropped(to: .init(x: 50, y: 50, width: TestImage.size.width + 100, height: TestImage.size.height + 100)).size, CGSize(width: 410, height: 409))
        XCTAssertEqual(TestImage.image.cropped(to: .init(x: -1, y: -5, width: 10, height: 10)).size, CGSize(width: 9, height: 5))
        let croppedRect = CGRect(x: 50, y: 50, width: 100, height: 100)
        let croppedImage = TestImage.image3x.cropped(to: croppedRect)

        XCTAssertEqual(croppedImage.canonicalized.pixelColor(at: .zero), UIColor(red: 208, green: 184, blue: 159, alpha: 1))
        XCTAssertEqual(croppedImage.canonicalized.pixelColor(at: .init(x: croppedRect.width - 1, y: croppedRect.height - 1)), UIColor(red: 107, green: 86, blue: 72, alpha: 1))
        XCTAssertEqual(croppedImage.size.applying(scaleTransform), croppedRect.size)
    }

    func testResized() {
        XCTAssertEqual(TestImage.image.resized(to: .zero).size, .zero)
        XCTAssertEqual(TestImage.image.resized(to: .init(width: -1, height: -1)).size, .zero)
        let resizedSize = CGSize(width: 24, height: 24)
        let resizedImage = TestImage.image3x.resized(to: resizedSize)
        XCTAssertEqualColor(resizedImage.canonicalized.pixelColor(at: .zero), UIColor(red: 237, green: 215, blue: 184, alpha: 1))
        XCTAssertEqualColor(resizedImage.canonicalized.pixelColor(at: .init(x: resizedSize.width - 1, y: resizedSize.height - 1)), UIColor(red: 57, green: 48, blue: 60, alpha: 1))
        XCTAssertEqual(resizedImage.size.applying(scaleTransform), resizedSize)
    }

    func testResizedByAspectFill() {
        XCTAssertEqual(TestImage.image.resized(to: .zero, scalingMode: .aspectFill).size, .zero)
        XCTAssertEqual(TestImage.image.resized(to: .init(width: -1, height: -1), scalingMode: .aspectFill).size, .zero)
        let resizedSize = CGSize(width: 128, height: 24)
        let resizedFillImage = TestImage.image3x.resized(to: resizedSize, scalingMode: .aspectFill)
        XCTAssertEqualColor(resizedFillImage.canonicalized.pixelColor(at: .zero), UIColor(red: 205, green: 184, blue: 170, alpha: 1))
        XCTAssertEqualColor(resizedFillImage.canonicalized.pixelColor(at: .init(x: resizedSize.width - 1, y: resizedSize.height - 1)), UIColor(red: 143, green: 116, blue: 114, alpha: 1))
        XCTAssertEqual(resizedFillImage.size.applying(scaleTransform), resizedSize)
    }

    func testResizedByAspectFit() {
        XCTAssertEqual(TestImage.image.resized(to: .zero, scalingMode: .aspectFit).size, .zero)
        XCTAssertEqual(TestImage.image.resized(to: .init(width: -1, height: -1), scalingMode: .aspectFit).size, .zero)
        let resizedSize = CGSize(width: 128, height: 24)
        let resizedFitImage = TestImage.image3x.resized(to: resizedSize, scalingMode: .aspectFit)
        XCTAssertEqualColor(resizedFitImage.canonicalized.pixelColor(at: .zero), UIColor(red: 0, green: 0, blue: 0, alpha: 0))
        XCTAssertEqualColor(resizedFitImage.canonicalized.pixelColor(at: .init(x: resizedSize.width - 1, y: resizedSize.height - 1)), UIColor(red: 0, green: 0, blue: 0, alpha: 0))
        XCTAssertEqual(resizedFitImage.canonicalized.pixelColor(at: .init(x: 59, y: 10)), UIColor(red: 75, green: 56, blue: 46, alpha: 1))
        XCTAssertEqual(resizedFitImage.size.applying(scaleTransform), resizedSize)
    }

    func testRounded() {
        let roundedImage = TestImage.image3x.rounded()
        XCTAssertEqual(roundedImage.canonicalized.pixelColor(at: .init(x: 30, y: 30)), UIColor(red: 0, green: 0, blue: 0, alpha: 0))
        XCTAssertEqual(roundedImage.canonicalized.pixelColor(at: .init(x: 100, y: 100)), UIColor(red: 162, green: 140, blue: 135, alpha: 1))
        XCTAssertEqual(roundedImage.size.height, TestImage.image3x.size.height)
        XCTAssertEqual(roundedImage.size.width, roundedImage.size.height)

        let roundedImage2 = TestImage.image3x.rounded(cornerRadius: 40)
        XCTAssertEqual(roundedImage2.canonicalized.pixelColor(at: .init(x: 30, y: 30)), UIColor(red: 0, green: 0, blue: 0, alpha: 0))
        XCTAssertEqual(roundedImage2.size.height, TestImage.image3x.size.height)
        XCTAssertEqual(roundedImage2.size.width, roundedImage2.size.height)

        let roundedImage3 = TestImage.image3x.rounded(cornerRadius: 30)
        XCTAssertEqual(roundedImage3.canonicalized.pixelColor(at: .init(x: 30, y: 30)), UIColor(red: 235, green: 211, blue: 186, alpha: 1))

        let roundedImage4 = TestImage.image3x.rounded(cornerRadius: 30, borderWidth: 10, borderColor: .red)
        XCTAssertEqual(roundedImage4.canonicalized.pixelColor(at: .init(x: 30, y: 30)), .red)
    }
}

private enum TestImage {
    private static let data = try! Data(contentsOf:
                                            Bundle.module.url(forResource: "TestImage", withExtension: "png")!)
    static let image = UIImage(data: data)!
    static let image3x = UIImage(data: data, scale: 3)!
    static let image3xLeft = UIImage(cgImage: image.cgImage!, scale: 3.0, orientation: .left)
    static let size = CGSize(width: 460, height: 459)
}

public func XCTAssertColorEqual(_ expression1: @autoclosure () throws -> UIColor, _ expression2: @autoclosure () throws -> UIColor, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
    var expr1: (CGFloat, CGFloat, CGFloat, CGFloat) = (-1, -1, -1, -1)
    var expr2: (CGFloat, CGFloat, CGFloat, CGFloat) = (-1, -1, -1, -1)
    try! expression1().getRed(&expr1.0, green: &expr1.1, blue: &expr1.2, alpha: &expr1.3)
    try! expression2().getRed(&expr2.0, green: &expr2.1, blue: &expr2.2, alpha: &expr2.3)
    XCTAssertEqual(expr1.0, expr2.0, accuracy: 0.003, message(), file: file, line: line)
    XCTAssertEqual(expr1.1, expr2.1, accuracy: 0.003, message(), file: file, line: line)
    XCTAssertEqual(expr1.2, expr2.2, accuracy: 0.003, message(), file: file, line: line)
    XCTAssertEqual(expr1.3, expr2.3, accuracy: 0.003, message(), file: file, line: line)
}

private func XCTAssertEqualColor(_ color1: UIColor!, _ color2: UIColor!, line: UInt = #line) {
    let (r1, g1, b1, a1) = color1.components.rgba
    let (r2, g2, b2, a2) = color2.components.rgba
    XCTAssertEqual(r1, r2, accuracy: 0.02, "Red", line: line)
    XCTAssertEqual(g1, g2, accuracy: 0.02, "Green", line: line)
    XCTAssertEqual(b1, b2, accuracy: 0.02, "Blue", line: line)
    XCTAssertEqual(a1, a2, accuracy: 0.02, "Alpha", line: line)
}

#endif // canImport(UIKit)
