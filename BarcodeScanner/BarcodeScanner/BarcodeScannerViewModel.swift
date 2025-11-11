//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by Shahma on 27/10/25.
//

import SwiftUI
import Combine

final class BarcodeScannerViewModel: ObservableObject {

    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
}
