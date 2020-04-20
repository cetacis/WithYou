//
//  Portrait.swift
//  loginSwiftUI
//
//  Created by una on 2020/4/13.
//  Copyright © 2020 cetacis. All rights reserved.
//

import SwiftUI

//Mark:take potoes
struct CaptureImageView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}

struct Portrait: View {
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    var body: some View {
        
        ZStack {
            VStack {
                Button(action: {
                    self.showCaptureImageView.toggle()
                }) {
                    Text("Choose photos as your portrait")
                }.sheet(isPresented: self.$showCaptureImageView) {
                    CaptureImageView(isShown: self.$showCaptureImageView, image: self.$image)
                }
                image?.resizable()
                    .frame(width: 250, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .onAppear() {
                        Choose = self.image ?? Image("player1")
                }
            }
        }
        
    }
}

struct Portrait_change: View {
    @Binding var image: Image?
    @State var showCaptureImageView: Bool = false
    @State var showAlert = false
    var body: some View {
        
        ZStack {
            VStack {
                image?.resizable()
                    .frame(width: 250, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding(.top,5)
                HStack{
                    Button(action: {
                        self.showCaptureImageView.toggle()
                    }) {
                        Text("Change ").foregroundColor(Color(red: 162/255, green: 215/255, blue: 33/255))
                    }.sheet(isPresented: self.$showCaptureImageView) {
                        CaptureImageView(isShown: self.$showCaptureImageView, image: self.$image)
                    }
                    Button(" Save"){
                        Choose = self.image ?? Choose
                        self.showAlert = true
                    } .alert(isPresented: $showAlert) {
                                       Alert(title: Text("successfully modified"), dismissButton: .default(Text("OK")))
                                   }
                    
                }
            }
        }
        
    }
}

struct Portrait_Previews: PreviewProvider {
    static var previews: some View {
        Portrait()
    }
}
