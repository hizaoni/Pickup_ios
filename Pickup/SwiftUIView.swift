//
//  SwiftUIView.swift
//  Pickup
//
//  Created by 高本直矢 on 2022/06/10.
//

import SwiftUI

struct SwiftUIView: View {
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
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
