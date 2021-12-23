
#if DEBUG

import SwiftUI


/*
  프로그래밍 방식으로 화면을 구현할 때 SwiftUI처럼 바로바로 확인을 할 수 있게끔 해주는 기능
  주석처리 된 부분을 Controller or View 클래스에서 넣어 사용한다.
*/


// ViewController PreView

@available(iOS 13, *)
extension UIViewController {
    
    private struct ViewControllerPreview: UIViewControllerRepresentable {
        typealias UIViewControllerType = UIViewController
        
        let controller: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return controller
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
    }

    func toPreview() -> some View {
        ViewControllerPreview(controller: self)
    }
}

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13, *)
//struct Preview: PreviewProvider {
//
//    static var previews: some View {
//        // view controller using programmatic UI
//        class().toPreview()
//    }
//}
//#endif



// View PreView

@available(iOS 13, *)
extension UIView {
    
    private struct Preview: UIViewRepresentable {
        let view: UIView

        func makeUIView(context: Context) -> UIView {
            return view
        }

        func updateUIView(_ uiViewController: UIView, context: Context) { }
    }

    func toPreview() -> some View {
        Preview(view: self)
    }
}

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13, *)
//struct Preview: PreviewProvider {
//
//    static var previews: some View {
//        class().toPreview()
//    }
//}
//#endif


// StackView PreView

@available(iOS 13, *)
extension UIStackView {

    private struct StackViewPreview: UIViewRepresentable {
        let view: UIStackView

        func makeUIView(context: Context) -> UIStackView {
            return view
        }

        func updateUIView(_ uiViewController: UIStackView, context: Context) { }
    }

    func toPreview() -> some View {
        StackViewPreview(view: self)
    }
}

#endif

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13, *)
//struct Preview: PreviewProvider {
//
//    static var previews: some View {
//        class().toPreview()
//    }
//}
//#endif
