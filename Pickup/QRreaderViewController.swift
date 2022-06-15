//
//  QRreaderViewController.swift
//  Pickup
//
//  Created by 高本直矢 on 2022/06/10.
//

import UIKit
import QRCodeReader
 
class QRreaderViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
             
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = true
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
            $0.cancelButtonTitle      = "キャンセル"
        }
        return QRCodeReaderViewController(builder: builder)
    }()
 
    @IBOutlet weak var qrcodeButton: UIButton!
     
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    // アラートを表示
    func showAlert(title: String, message: String, action: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
 
    // QR コードリーダ起動ボタンをタップ
    @IBAction func scanQRcode(_ sender: Any) {
        if QRCodeReader.isAvailable() {
            // QRCodeReader を起動
            readerVC.delegate = self
            readerVC.modalPresentationStyle = .formSheet
            present(readerVC, animated: true, completion: nil)
        } else {
            let close = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            showAlert(title: "エラー", message: "この端末ではQRコードリーダを利用できません", action: close)
        }
    }
     
    // QR コードの読み取りに成功
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
 
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        if !result.value.isEmpty {
            showAlert(title: "成功", message: result.value, action: ok)
        } else {
            showAlert(title: "エラー", message: "QRコードの読み取りに失敗しました", action: ok)
        }
    }
    // QR コードの読み取りをキャンセル
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
        let close = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        showAlert(title: "エラー", message: "QRコードの読み取りをキャンセルしました", action: close)
    }
}
