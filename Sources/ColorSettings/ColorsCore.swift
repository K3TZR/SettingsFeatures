//
//  ColorsCore.swift
//  ViewFeatures/SettingsFeature/Colors
//
//  Created by Douglas Adams on 12/31/22.
//

import ComposableArchitecture
import Foundation
import SwiftUI

import FlexApi
import Shared

public struct ColorsFeature: ReducerProtocol {
  
  public init() {}
    
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action: Equatable {
  }
  
  public func reduce(into state: inout State, action: Action) ->  EffectTask<Action> {
  }
}

extension Color: RawRepresentable {
  public init?(rawValue: String) {
    guard let data = Data(base64Encoded: rawValue) else {
      self = .pink
      return
    }
    
    do {
      let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSColor ?? .systemPink

      // FIXME: can't get this to work ???
      //      let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSColor, from: data)
      
      self = Color(color)
    } catch {
      self = .pink
    }
  }
  
  public var rawValue: String {
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: NSColor(self), requiringSecureCoding: false) as Data
      return data.base64EncodedString()
    } catch {
      return ""
    }
  }
}
