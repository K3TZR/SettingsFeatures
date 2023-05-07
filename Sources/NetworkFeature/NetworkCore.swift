//
//  NetworkCore.swift
//  ViewFeatures/SettingsFeature/Network
//
//  Created by Douglas Adams on 12/31/22.
//

import Foundation
import ComposableArchitecture

public struct NetworkFeature: ReducerProtocol {
  
  public init() {}
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action: Equatable {
    case enforcePrivateIpButton
    case addressType(String)
    case applyStaticButton
    case staticIp(String)
    case staticMask(String)
    case staticGateway(String)
  }
  
  public func reduce(into state: inout State, action: Action) ->  EffectTask<Action> {
    
    // FIXME:

    switch action {

    case let .addressType(type):
//      return .run { _ in
//        if type == "DHCP" {
//          await objectModel.radio?.radioDhcpCmd()
//        } else {
//          await objectModel.radio?.radioStaticCmd()
//        }
//      }
      return .none

    case .applyStaticButton:
//      return .run { _ in
//        await objectModel.radio?.radioStaticCmd()
//      }
      return .none

    case .enforcePrivateIpButton:
//      return .run { _ in
//        await objectModel.radio?.setAndSend(.enforcePrivateIpEnabled)
//      }
      return .none

    case let .staticIp(ip):
//      return .run { _ in
//        await objectModel.radio?.setAndSend(Radio.StaticNetProperty.ip, ip)
//      }
      return .none

    case let .staticMask(mask):
//      return .run { _ in
//        await objectModel.radio?.setAndSend(Radio.StaticNetProperty.mask, mask)
//      }
      return .none

    case let .staticGateway(gateway):
//      return .run { _ in
//        await objectModel.radio?.setAndSend(Radio.StaticNetProperty.gateway, gateway)
//      }
      return .none
    }
  }
}
