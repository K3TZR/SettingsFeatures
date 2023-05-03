//
//  ProfilesSettingsCore.swift
//  ViewFeatures/SettingsFeature/Profiles
//
//  Created by Douglas Adams on 12/31/22.
//

import Foundation
import ComposableArchitecture
import SwiftUI

import FlexApi

public struct ProfilesSettingsFeature: ReducerProtocol {
  
  public init() {}
  
  @AppStorage("selectedProfileType") var selectedProfileType: ProfileType = .mic
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action: Equatable {
    case profileProperty(Profile, String, String)
    case profileType(ProfileType)
  }
  
  public func reduce(into state: inout State, action: Action) ->  EffectTask<Action> {
    
    switch action {
    
    case let .profileProperty(profile, cmd, profileName):
      return .run { _ in
        await profile.setProperty(cmd, profileName)
      }
      
    case let .profileType(type):
      selectedProfileType = type
      return .none
    }
  }
}
