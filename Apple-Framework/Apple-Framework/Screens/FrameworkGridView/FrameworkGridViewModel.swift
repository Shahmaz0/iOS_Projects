//
//  FrameworkGridViewModel.swift
//  Apple-Framework
//
//  Created by Shahma on 19/10/25.
//

import Foundation
import SwiftUI


class FrameworkGridViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())
    ]
    
}
