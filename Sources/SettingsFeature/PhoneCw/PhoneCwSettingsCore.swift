//
//  PhoneCwSettingsCore.swift
//  ViewFeatures/SettingsFeature/PhoneCw
//
//  Created by Douglas Adams on 12/31/22.
//

import Foundation
import ComposableArchitecture

import FlexApi

public struct PhoneCwSettingsFeature: ReducerProtocol {
  public init() {}
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action: Equatable {
    case filterProperty(Radio, Radio.Property, Radio.Property, String)
    case radioProperty(Radio, Radio.Property, String)
    case transmitProperty(Transmit, Transmit.Property, String)
  }
  
  public func reduce(into state: inout State, action: Action) ->  EffectTask<Action> {
    switch action {
    
    case let .filterProperty(radio, type, property, stringValue):
      return .run { _ in
        await radio.setFilterProperty(type, property, stringValue)
      }

    case let .radioProperty(radio, property, value):
      return .run { _ in
        await radio.setProperty(property, value)
      }
      
    case let .transmitProperty(transmit, property, stringValue):
      return .run { _ in
        await transmit.setProperty(property, stringValue)
      }
    }
  }
}
