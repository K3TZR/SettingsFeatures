//
//  NetworkCore.swift
//  ViewFeatures/SettingsFeature/Network
//
//  Created by Douglas Adams on 12/31/22.
//

import Foundation
import ComposableArchitecture

import FlexApi

public struct NetworkFeature: ReducerProtocol {
  
  public init() {}
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action: Equatable {
    case enforcePrivateIpButton(Radio, Bool)
    case addressType(Radio, String)
    case applyStaticButton(Radio)
    case staticIp(Radio, String)
    case staticMask(Radio, String)
    case staticGateway(Radio,String)
  }
  
  public func reduce(into state: inout State, action: Action) ->  EffectTask<Action> {
    
    // FIXME:

    switch action {
      
      // FIXME: ????

    case .addressType(_, _):
//    case let .addressType(radio, type):
//      print("----->>>>> addressType = \(type)")
//      return .run { _ in
//        if type == "DHCP" {
//        } else {
//        }
//      }
      return .none

    case .applyStaticButton(_):
//    case let .applyStaticButton(radio):
//      print("----->>>>> applyStaticButton")
//      return .run { _ in
//      }
      return .none

    case let .enforcePrivateIpButton(radio, boolValue):
      return .run { _ in
        await radio.setProperty(.enforcePrivateIpEnabled, boolValue.as1or0)
      }

    case .staticIp(_, _):
//    case let .staticIp(radio, ip):
//      print("----->>>>> static ip = \(ip)")
//      return .run { _ in
//      }
      return .none

    case .staticMask(_, _):
//    case let .staticMask(radio, mask):
//      print("----->>>>> static mask = \(mask)")
//      return .run { _ in
//      }
      return .none

    case .staticGateway(_, _):
//    case let .staticGateway(radio, gateway):
//      print("----->>>>> static gateway = \(gateway)")
//      return .run { _ in
//      }
      return .none
    }
  }
}
