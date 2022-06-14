//
//  ScannerViewModel.swift
//  Pickup
//
//  Created by 高本直矢 on 2022/06/10.
//

import Foundation

class ScannerViewModel: ObservableObject {

    /// QRコードを読み取る時間間隔
    let scanInterval: Double = 1.0
    @Published var lastQrCode: String = "QRコード"
    @Published var isShowing: Bool = false

    /// QRコード読み取り時に実行される。
    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
        isShowing = false
        //ここにリクエストを入力する
    }
}
