// The MIT License
//
// Copyright (c) 2024 Serhii Chornonoh
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import SwiftUI

extension View {
    
    /**
     Divides the view's layer into triangles and animates their movement into a specified direction with fading away.

     - Parameter snap: Disintegration trigger.
     - Parameter direction: The direction of the triangles' movement.
     - Parameter estimatedTrianglesCount: Estimated number of triangles after dividing the layer. The final number will also depend on the view bounds' size.
     - Parameter completion: Block that will be executed when the animation finishes.
     */
    @MainActor
    @ViewBuilder
    public func disintegrate(
        snap: Bool,
        direction: DisintegrationDirection = DisintegrationDirection.random(),
        estimatedTrianglesCount: Int = 66,
        completion: (() -> ())? = nil
    ) -> some View {
        if snap {
            let renderer = renderer()
            if let uiImage = renderer.uiImage {
                DisintegrateView(
                    image: uiImage,
                    direction: direction,
                    estimatedTrianglesCount: estimatedTrianglesCount,
                    completion: completion
                )
                .fixedSize()
            }
        } else {
            self
        }
    }
    
    @MainActor
    func renderer() -> ImageRenderer<Self> {
        let renderer = ImageRenderer(content: self)
        renderer.scale = UIScreen.main.scale
        return renderer
    }
}

public struct DisintegrateView: UIViewRepresentable {
    let image: UIImage?
    var direction: DisintegrationDirection
    var estimatedTrianglesCount: Int
    var completion: (() -> ())?

    public func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            imageView.disintegrate(
                direction: direction,
                estimatedTrianglesCount: estimatedTrianglesCount,
                completion: completion
            )
        }
        return imageView
    }

    public func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = image
    }
}
