//
//  SettingsCore.swift
//  SettingsFeature/SettingsFeature
//
//  Created by Douglas Adams on 12/21/22.
//

import Foundation
import ComposableArchitecture

public struct SettingsFeature: ReducerProtocol {
  
  public init() {}
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action: Equatable {
  }
  
  public func reduce(into state: inout State, action: Action) ->  EffectTask<Action> {
    
//    switch action {
//    
//    }
  }
}
