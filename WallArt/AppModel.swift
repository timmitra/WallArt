//
//  AppModel.swift
//  WallArt
//
//  Created by Christopher J. Roura on 6/13/24.
//

import SwiftUI

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    let immersiveSpaceID = "ImmersiveSpace"
    
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    
    enum FlowState {
        case idle
        case intro
        case projectileFlying
        case updateWallArt
    }
    
    var immersiveSpaceState = ImmersiveSpaceState.closed
    var flowState = FlowState.idle
}
