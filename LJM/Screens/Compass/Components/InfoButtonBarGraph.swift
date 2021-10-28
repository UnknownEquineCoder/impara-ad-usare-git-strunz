//
//  InfoButton.swift
//  LJM
//
//  Created by Laura Benetti on 27/10/21.
//

import SwiftUI

struct InfoButtonBarGraph: View {
    @State private var showPopover = false
    var title: String = "Titolo"
    var textBody: String = "Body"
    var heightCell: CGFloat
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
            self.showPopover =  true
        }) {
            Image(systemName: "info.circle").resizable().frame(width: 17.toScreenSize(), height: 17.toScreenSize())
                .foregroundColor(Color(red: 165/255, green: 165/255, blue: 165/255))
        }.buttonStyle(PlainButtonStyle())
            .popover(isPresented: $showPopover, arrowEdge: .trailing, content: {
            VStack{
//                HStack {
//                    Text(title).font(.title).font(.system(size: 24.toFontSize())).fontWeight(.semibold).multilineTextAlignment(.leading)
//                        .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 70/255, green: 70/255, blue: 70/255))
//                    Spacer()
//                }
                Text(textBody)
                    .fontWeight(.light)
//                    .frame(width: 1024.toScreenSize(), height: heightCell.toScreenSize())
                    .font(.system(size: 20.toFontSize()))
                    .foregroundColor(colorScheme == .dark ? Color(red: 221/255, green: 221/255, blue: 221/255) : Color(red: 165/255, green: 165/255, blue: 165/255))
            }
            .frame(width: 200, height: 150)
            .padding()
        })
    }
}

struct InfoButtonBarGraph_Previews: PreviewProvider {
    static var previews: some View {
        InfoButtonBarGraph(heightCell: 300)
    }
}

//extension String {
//
//    var spliString: [Self] {
//        return self.map { Self($0) }
//    }
//
//    var splitWords: [Self] {
//        return self.split(separator: " ").map { Self($0) }
//    }
//
//    func customHighlighted(indices: Int...) -> NSMutableAttributedString {
//
//        @Environment(\.colorScheme) var colorScheme
//
//        var baseColor: NSColor {
//            if colorScheme == .dark {
//                return NSColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1)
//            } else {
//                return NSColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
//            }
//        }
//
//        typealias CustomMode = [NSAttributedString.Key: Any]
//
//        let base = NSMutableAttributedString()
//
//        let baseStyle: CustomMode =
//            [.foregroundColor : baseColor]
//
//
//        let particularStyle: CustomMode =
//            [.foregroundColor: NSColor(red: 62/255, green: 161/255, blue: 155/255, alpha: 1)]
//
//
//        for (index, word) in self.splitWords.enumerated() {
//
//            if indices.contains(index) {
//                base.append(NSAttributedString(string: word + " ", attributes: particularStyle))
//            } else {
//                base.append(NSAttributedString(string: word + " ", attributes: baseStyle))
//
//            }
//        }
//
//        return base
//    }
//}
//
//struct AttributedText: View  {
//    @State var size: CGSize = .zero
//    let attributedString: NSAttributedString
//
//    init(_ attributedString: NSAttributedString) {
//        self.attributedString = attributedString
//    }
//
//    var body: some View {
//        AttributedTextRepresentable(attributedString: attributedString, size: $size)
//            .frame(width: size.width, height: size.height)
//    }
//
//    struct AttributedTextRepresentable: NSViewRepresentable {
//
//        let attributedString: NSAttributedString
//        @Binding var size: CGSize
//
//        func makeNSView(context: Context) -> NSTextView {
//            let textView = NSTextView()
//
//            textView.textContainer!.widthTracksTextView = false
//            textView.textContainer!.containerSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
//            textView.drawsBackground = false
//
//            return textView
//        }
//
//        func updateNSView(_ nsView: NSTextView, context: Context) {
//            nsView.textStorage?.setAttributedString(attributedString)
//
//            DispatchQueue.main.async {
//                size = nsView.textStorage!.size()
//            }
//        }
//    }
//}




