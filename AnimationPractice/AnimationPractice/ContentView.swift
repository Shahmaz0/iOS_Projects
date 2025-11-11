import SwiftUI
import CoreText

struct ContentView: View {
    @State private var currentPosition = 0
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
            
            // Core Text layer in the center
            CoreTextView()
                .frame(width: 250, height: 150)
                .background(Color.clear)
                .position(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            
            // Animated Circle
            Circle()
                .fill(Color.blue)
                .frame(width: 60, height: 60)
                .offset(circleOffset(for: currentPosition))
                .animation(.easeInOut(duration: 1.0), value: currentPosition)
                .onAppear {
                    animateCircle()
                }
        }
        .ignoresSafeArea()
    }
    
    func circleOffset(for index: Int) -> CGSize {
        let screen = UIScreen.main.bounds
        let size: CGFloat = 60
        
        let positions: [CGSize] = [
            CGSize(width: 0, height: 0),
            CGSize(width: screen.width - size, height: 0),
            CGSize(width: screen.width - size, height: screen.height - size * 2),
            CGSize(width: 0, height: screen.height - size * 2),
            CGSize(width: 0, height: 0)
        ]
        
        return positions[index]
    }
    
    func animateCircle() {
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { _ in
            currentPosition = (currentPosition + 1) % 5
        }
    }
}

// MARK: - Core Text Example View
struct CoreTextView: UIViewRepresentable {
    func makeUIView(context: Context) -> CoreTextUIView {
        return CoreTextUIView()
    }
    
    func updateUIView(_ uiView: CoreTextUIView, context: Context) {}
}

class CoreTextUIView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 1️⃣ Get Core Graphics context
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Flip coordinate system (Core Text’s origin is bottom-left)
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        // 2️⃣ Create an attributed string
        let text = """
        Welcome to Core Text!
        This text is drawn using Core Graphics + Core Text.
        """
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .medium), range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemPurple, range: NSRange(location: 0, length: 22))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemTeal, range: NSRange(location: 23, length: text.count - 23))
        
        // 3️⃣ Create framesetter and path
        let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
        let path = CGPath(rect: bounds.insetBy(dx: 10, dy: 10), transform: nil)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributedString.length), path, nil)
        
        // 4️⃣ Draw text
        CTFrameDraw(frame, context)
    }
}

#Preview {
    ContentView()
}
