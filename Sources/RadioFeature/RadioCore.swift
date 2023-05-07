//
//  RadioCore.swift
//  ViewFeatures/SettingsFeature/Radio
//
//  Created by Douglas Adams on 12/31/22.
//

import Foundation
import ComposableArchitecture

import FlexApi

public struct RadioFeature: ReducerProtocol {
  public init() {}
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action: Equatable {
    case radioProperty(Radio, Radio.Property, String)
    case singleClickButton
    case sliceMinimizedButton
  }
  
  public var body: some ReducerProtocol<RadioFeature.State, RadioFeature.Action> {
    Reduce {state, action in
      switch action {

      case let .radioProperty(radio, property, stringValue):
        return .run { _ in await radio.setProperty(property, stringValue) }
        
      case .singleClickButton:
        // FIXME:
        return .none
        
      case .sliceMinimizedButton:
        // FIXME:
        return .none
      }
    }
  }
}
