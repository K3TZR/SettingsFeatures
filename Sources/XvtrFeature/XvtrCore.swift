//
//  XvtrCore.swift
//  SettingsFeature/Xvtr
//
//  Created by Douglas Adams on 12/31/22.
//

import Foundation
import ComposableArchitecture

public struct XvtrFeature: ReducerProtocol {
  
  public init() {}
  
  public struct State: Equatable {
    public init
    (
    )
    {
    }
  }
  
  public enum Action: Equatable {
  }
  
  public func reduce(into state: inout State, action: Action) ->  EffectTask<Action> {    
  }
}
