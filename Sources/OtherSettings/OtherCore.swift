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

  @Dependency(\.apiModel) var apiModel
  
  public struct State: Equatable {
    public var antList: [String]
    
    public init(antList: [String]) {
      self.antList = antList
    }
  }
  
  public enum Action: Equatable {
    case addAltName(String, String)
    case noAction
  }
  
  public func reduce(into state: inout State, action: Action) ->  EffectTask<Action> {
    
    switch action {
    
    case let .addAltName(stdName, altName):
      print("std = \(stdName), alt = \(altName)")
      apiModel.altAntennaName(for: stdName, altName)
      return .none
      
    case .noAction:
      return .none
    }
  }
}
