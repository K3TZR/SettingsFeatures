//
//  SettingsView.swift
//  SettingsFeature/SettingsFeature
//
//
//  Created by Douglas Adams on 12/21/22.
//

import ComposableArchitecture
import SwiftUI

import ColorSettings
import ConnectionSettings
import GpsSettings
import NetworkSettings
import OtherSettings
import PhoneCwSettings
import ProfileSettings
import RadioSettings
import TxSettings
import XvtrSettings

import FlexApi
import Shared

public enum SettingType: String {
  case radio = "Radio"
  case network = "Network"
  case gps = "GPS"
  case tx = "Transmit"
  case phoneCw = "Phone CW"
  case xvtrs = "Xvtrs"
  case profiles = "Profiles"
  case colors = "Colors"
  case other = "Other"
  case connection = "Connection"
}

public struct SettingsView: View {
  let store: StoreOf<SettingsFeature>
  @ObservedObject var objectModel: ObjectModel
  @ObservedObject var apiModel: ApiModel
  
  public init(store: StoreOf<SettingsFeature>, objectModel: ObjectModel, apiModel: ApiModel) {
    self.store = store
    self.objectModel = objectModel
    self.apiModel = apiModel
  }
  
  @AppStorage("selectedSettingType") var selectedSettingType: SettingType = .radio
  @AppStorage("selectedProfileType") var selectedProfileType: ProfileType = .mic
  
  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      TabView(selection: $selectedSettingType) {
        Group {
          RadioView(store: Store(initialState: RadioFeature.State(), reducer: RadioFeature()),
                    radio: apiModel.radio ?? Radio(Packet()))
          .tabItem {
            Text(SettingType.radio.rawValue)
            Image(systemName: "antenna.radiowaves.left.and.right")
          }.tag(SettingType.radio)
          
          NetworkView(store: Store(initialState: NetworkFeature.State(), reducer: NetworkFeature()),
                      radio: apiModel.radio ?? Radio(Packet()) )
          .tabItem {
            Text(SettingType.network.rawValue)
            Image(systemName: "wifi")
          }.tag(SettingType.network)
          
          GpsView()
          .tabItem {
            Text("Gps")
            Image(systemName: "globe")
          }.tag(SettingType.gps)
          
          TxView(store: Store(initialState: TxFeature.State(), reducer: TxFeature()) )
          .tabItem {
            Text(SettingType.tx.rawValue)
            Image(systemName: "bolt.horizontal")
          }.tag(SettingType.tx)
          
          PhoneCwView(store: Store(initialState: PhoneCwFeature.State(), reducer: PhoneCwFeature()) )
          .tabItem {
            Text(SettingType.phoneCw.rawValue)
            Image(systemName: "mic")
          }.tag(SettingType.phoneCw)
        }
        
        Group {
          XvtrView()
          .tabItem {
            Text(SettingType.xvtrs.rawValue)
            Image(systemName: "arrow.up.arrow.down.circle")
          }.tag(SettingType.xvtrs)
          
          ProfilesView(store: Store(initialState: ProfilesFeature.State(), reducer: ProfilesFeature()) )
          .tabItem {
            Text(SettingType.profiles.rawValue)
            Image(systemName: "brain.head.profile")
          }.tag(SettingType.profiles)
          
          ColorsView(store: Store(initialState: ColorsFeature.State(), reducer: ColorsFeature()) )
          .tabItem {
            Text(SettingType.colors.rawValue)
            Image(systemName: "eyedropper")
          }.tag(SettingType.colors)
          
          OtherView(store: Store(initialState: OtherFeature.State(antList: apiModel.antList), reducer: OtherFeature()))
          .tabItem {
            Text(SettingType.other.rawValue)
            Image(systemName: "gear")
          }.tag(SettingType.other)

          ConnectionView()
          .tabItem {
            Text(SettingType.connection.rawValue)
            Image(systemName: "list.bullet")
          }.tag(SettingType.connection)
        }
      }
      .onDisappear {
        // close the ColorPicker (if open)
        if NSColorPanel.shared.isVisible {
          NSColorPanel.shared.performClose(nil)
        }
      }
      
    }
    .frame(width: 600, height: 350)
    .padding()
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(store: Store(initialState: SettingsFeature.State(),
                              reducer: SettingsFeature()),
                 objectModel: ObjectModel(),
                 apiModel: ApiModel())
    .frame(width: 600, height: 350)
    .padding()
  }
}
