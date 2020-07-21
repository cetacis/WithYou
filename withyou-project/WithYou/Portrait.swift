//
//  Portrait.swift
//  loginSwiftUI
//
//  Created by una on 2020/4/13.
//  Copyright © 2020 cetacis. All rights reserved.
//

import SwiftUI
import SSZipArchive
//Mark:take potoes
struct CaptureImageView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var imagePath: URL?
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image,imagePath:$imagePath)
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
func getSize(url: URL)->UInt64
{
    var fileSize : UInt64 = 0
     
    do {
        let attr = try FileManager.default.attributesOfItem(atPath: url.path)
        fileSize = attr[FileAttributeKey.size] as! UInt64
         
        let dict = attr as NSDictionary
        fileSize = dict.fileSize()
    } catch {
        print("Error: \(error)")
    }
     
    return fileSize
}

func compress(){
    let getImg = UIImage(contentsOfFile:PostImagePath!.path)
        //print(getSize(url: PostImagePath!))

    let zipImageData =  getImg!.jpegData(compressionQuality: 0.05) 
    let PostImagePathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/\(UUID().uuidString).jpeg"

    do {
        try zipImageData!.write(to: URL(fileURLWithPath: PostImagePathString))
    }catch {
    }
    //print(PostImagePathString)

    PostImagePath = NSURL.fileURL(withPath: PostImagePathString)

    //print(PostImagePath!)
    //print(getSize(url: PostImagePath!))
}

struct Portrait: View {
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    @State var imagePath: URL? = nil
    
   
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    self.showCaptureImageView.toggle()
                }) {
                    Text("Choose photos as your portrait")
                }.sheet(isPresented: self.$showCaptureImageView) {
                    CaptureImageView(isShown: self.$showCaptureImageView, image: self.$image,imagePath: self.$imagePath)
                }
                image?.resizable()
                    .frame(width: 250, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .onAppear() {
                        Choose = self.image ?? Image("player1")
                        PostImagePath = self.imagePath
                        //print(PostImagePath!)
                        compress()
                    }
                
            }
        }
        
    }
}

struct Portrait_change: View {
    @Binding var image: Image?
    @State var imagePath: URL?
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
                        CaptureImageView(isShown: self.$showCaptureImageView, image: self.$image, imagePath: self.$imagePath)
                    }
                    Button(" Save"){
                        Choose = self.image ?? Choose
                        UserPortrait = self.image ?? UserPortrait
                        PostImagePath = self.imagePath
                        //print(PostImagePath!)
                        compress()
                        PostChangeProt(completion:{(code,msg) in
                            print(code)
                            print(msg)
                            if code == 0{
                                self.showAlert = true
                            }
                        },email: User.email, password: User.password)
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
