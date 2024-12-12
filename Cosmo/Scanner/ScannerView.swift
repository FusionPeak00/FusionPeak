//
//  ScannerView.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI
import AVKit
import AVFoundation

struct ScannerView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var qrDelegate = QRScannerDelegate()
    @StateObject private var vm = ScanerViewModel()
    @Environment(\.openURL) private var openURL
    
    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var scannedCode: String = ""
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var isImageShown = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 28, weight: .black))
                    }
                    
                    Spacer()
                    
                    Text("SCANNER")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .black))
                }
                .padding(.horizontal)
                
                if cameraPermission == .idle {
                    Text("Please provide access to the camera. This will allow you to scan the QR code.")
                        .foregroundColor(.gray)
                        .font(.system(size: 22))
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: openSettings) {
                        Label("Open settings?", systemImage: "gear")
                            .foregroundColor(.white)
                    }
                    
                } else {
                    GeometryReader {
                        let size = $0.size
                        let sqareWidth = min(size.width, 300)
                        
                        ZStack {
                            CameraView(frameSize: CGSize(width: sqareWidth, height: sqareWidth), session: $session, orientation: $orientation)
                                .cornerRadius(4)
                                .scaleEffect(0.97)
                            
                            ForEach(0...4, id: \.self) { index in
                                let rotation = Double(index) * 90
                                
                                RoundedRectangle(cornerRadius: 2, style: .circular)
                                    .trim(from: 0.61, to: 0.64)
                                    .stroke(Color.lightPurple, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                    .rotationEffect(.init(degrees: rotation))
                            }
                        }
                        .frame(width: sqareWidth, height: sqareWidth)
                        .overlay(alignment: .top, content: {
                            Rectangle()
                                .fill(Color.lightPurple)
                                .frame(height: 2.5)
                                .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                                .offset(y: isScanning ? sqareWidth : 0)
                        })
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .padding(.horizontal, 45)
                    .onAppear(perform: checkCameraPermission)
                    .onDisappear {
                        session.stopRunning()
                    }
                    .onChange(of: qrDelegate.scannedCode) { newValue in
                        if let code = newValue {
                            scannedCode = code
                            session.stopRunning()
                            deActivateScannerAnimation()
                            qrDelegate.scannedCode = nil
                            isImageShown.toggle()
                        }
                    }
                    .onChange(of: session.isRunning) { newValue in
                        if newValue {
                            orientation = UIDevice.current.orientation
                        }
                    }
                    
                    
                      
                      Button {
                          if scannedCode.isEmpty {
                              vm.toggleFlashlight()
                          } else {
                              if !session.isRunning && cameraPermission == .approved {
                                  reactivateCamera()
                                  activateScannerAnimation()
                                  scannedCode = ""
                              }
                          }
                      } label: {
                          Circle()
                              .frame(width: 50, height: 50)
                              .foregroundColor(.semiPurple)
                              .overlay {
                                  Image(systemName: "sun.min.fill")
                                      .foregroundColor(.gray)
                                      .font(.system(size: 26))
                              }
                              .padding(.top)
                      }
                      .padding(.bottom)
                }
             
                
                Spacer()
                
                Rectangle()
                    .frame(height: 130)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 20,
                            bottomLeadingRadius: 00,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 20
                        )
                    )
                    .foregroundColor(.semiPurple)
                    .overlay {
                        Text("Point the scanner at the QR code to access the club's special offers. (Discounts, menu, news)")
                            .padding(.horizontal)
                            .foregroundColor(.white)
                    }
                
            }
        }
        .fullScreenCover(isPresented: $isImageShown) {
            QRImageView(imageString: scannedCode)
        }
    }
    
    
    
    private func openSettings() {
        openURL(URL(string: UIApplication.openSettingsURLString)!)
    }
    
    
    func reactivateCamera() {
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    func activateScannerAnimation() {
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)) {
            isScanning = true
        }
    }
    
    func deActivateScannerAnimation() {
        withAnimation(.easeInOut(duration: 0.85)) {
            isScanning = false
        }
    }
    
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty {
                    setupCamera()
                } else {
                    reactivateCamera()
                }
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    setupCamera()
                } else {
                    cameraPermission = .denied
                    presentError("Please Provide Access to Camera for scanning codes")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Please Provide Access to Camera for scanning codes")
            default: break
            }
        }
    }
    
    func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                presentError("UNKNOWN DEVICE ERROR")
                return
            }
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("UNKNOWN INPUT/OUTPUT ERROR")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            qrOutput.metadataObjectTypes = [.qr]
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            activateScannerAnimation()
        } catch {
            presentError(error.localizedDescription)
        }
    }
    
    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
}

#Preview {
    ScannerView()
}


class QRScannerDelegate: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var scannedCode: String?
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let Code = readableObject.stringValue else { return }
            print(Code)
            scannedCode = Code
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}


struct QRImageView: View {
    
    @Environment(\.dismiss) var dismiss
    var imageString: String
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    if let url = URL(string: imageString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: size().width, height: size().height)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            
        }
        .overlay {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 9)
            .padding(.leading)
        }
        
    }
}


enum Permission: String {
    case idle = "Not Determined"
    case approved = "Access Granted"
    case denied = "Access Denied"
}

class ScanerViewModel: ObservableObject {
    
    @Published var isOn = false
    
    func toggleFlashlight() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if isOn {
                    device.torchMode = .off
                } else {
                    device.torchMode = .on
                }
                
                device.unlockForConfiguration()
                isOn.toggle()
            } catch {
                print("\(error.localizedDescription)")
            }
        } else {
            print("error")
        }
    }
    
}

struct CameraView: UIViewRepresentable {
    var frameSize: CGSize
    @Binding var session: AVCaptureSession
    @Binding var orientation: UIDeviceOrientation
    func makeUIView(context: Context) -> UIView {
        let view = UIViewType(frame: CGRect(origin: .zero, size: frameSize))
        view.backgroundColor = .clear
        
        let cameraLayer = AVCaptureVideoPreviewLayer(session: session)
        cameraLayer.frame = .init(origin: .zero, size: frameSize)
        cameraLayer.videoGravity = .resizeAspectFill
        cameraLayer.masksToBounds = true
        view.layer.addSublayer(cameraLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let layer = uiView.layer.sublayers?.first(where: { layer in
            layer is AVCaptureVideoPreviewLayer
        }) as? AVCaptureVideoPreviewLayer {
            switch orientation {
            case .portrait: layer.setAffineTransform(.init(rotationAngle: 0))
            case .landscapeLeft: layer.setAffineTransform(.init(rotationAngle: -.pi / 2))
            case .landscapeRight: layer.setAffineTransform(.init(rotationAngle: .pi / 2))
            case .portraitUpsideDown: layer.setAffineTransform(.init(rotationAngle: .pi))
            default: break
            }
        }
    }
}
