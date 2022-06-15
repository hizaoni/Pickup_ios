//
//  SwiftUIView.swift
//  Pickup
//
//  Created by 高本直矢 on 2022/06/10.
//

import SwiftUI

struct SwiftUIView: View {
<<<<<<< HEAD
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
=======
    @ObservedObject var viewModel = ScannerViewModel()

        var body: some View {

            VStack {
                Text("QR Code Reader")
                    .padding()

                // 読み取ったQRコード表示位置
                Text("URL = [ " + viewModel.lastQrCode + " ]")

                Button(action: {
                    viewModel.isShowing = true
                }){
                    Text("カメラ起動")
                    Image(systemName: "camera")
                }
                .fullScreenCover(isPresented: $viewModel.isShowing) {
                    SecondView(viewModel: viewModel)
                }
            }
        }
>>>>>>> 4a29b0098437c83aad1b0def04639b9df40d55db
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
