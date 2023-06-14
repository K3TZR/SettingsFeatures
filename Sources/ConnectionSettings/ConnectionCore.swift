//
//  ConnectionCore.swift
//  
//
//  Created by Douglas Adams on 6/12/23.
//

import Foundation
import ComposableArchitecture

public struct ConnectionFeature: ReducerProtocol {
  
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
