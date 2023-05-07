//
//  TxSettingsCore.swift
//  ViewFeatures/SettingsFeature/Tx
//
//  Created by Douglas Adams on 12/31/22.
//

import Foundation
import ComposableArchitecture

import FlexApi

public struct TxFeature: ReducerProtocol {
  
  public enum InterlockType {
    case acc
    case rca
  }
                              
  public init() {}
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action: Equatable {
    case interlockProperty(Interlock, Interlock.Property, String)
    case interlockState(Interlock, Interlock.Property, String)
    case transmitProperty(Transmit, Transmit.Property, String)
    case profileProperty(Profile, String)
  }
  
  public func reduce(into state: inout State, action: Action) ->  EffectTask<Action> {
    
    switch action {
    
    case let .transmitProperty(transmit, property, stringValue):
      return .run { _ in
        await transmit.setProperty(property, stringValue)
      }

    case let .interlockProperty(interlock, property, value):
      return .run { _ in
        await interlock.setProperty(property, value)
      }

    case let .interlockState(interlock, property, state):
      var polarity: Bool = false
      var enabled: Bool = false
      
      switch state {
      case "Active High":   enabled = true ; polarity = true
      case "Active Low":    enabled = true ; polarity = false
      default:              break
      }
      if property == .accTxReqEnabled {
        return .run { [enabled, polarity] _ in
          await interlock.setProperty(.accTxReqEnabled, enabled.as1or0)
          await interlock.setProperty(.accTxReqPolarity, polarity.as1or0)
        }
      }
      else if property == .rcaTxReqEnabled {
        return .run { [enabled, polarity] _ in
          await interlock.setProperty(.rcaTxReqEnabled, enabled.as1or0)
          await interlock.setProperty(.rcaTxReqPolarity, polarity.as1or0)
        }
      }
      return .none

    case let .profileProperty(profile, name):
      return .run { _ in
        await profile.setProperty("load", name)
      }
    }
  }
}
