//
//  OtherCore.swift
//  
//
//  Created by Douglas Adams on 3/1/23.
//

import Foundation
import ComposableArchitecture

public struct OtherFeature: ReducerProtocol {
  
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
