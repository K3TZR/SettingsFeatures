//
//  SettingsView.swift
//  ViewFeatures/SettingsFeature
//
//
//  Created by Douglas Adams on 12/21/22.
//

import ComposableArchitecture
import SwiftUI

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
}

public struct SettingsView: View {
  let store: StoreOf<SettingsFeature>
  @ObservedObject var objectModel: ObjectModel
  
  public init(store: StoreOf<SettingsFeature>, objectModel: ObjectModel) {
    self.store = store
    self.objectModel = objectModel
  }
  
  @AppStorage("selectedSettingType") var selectedSettingType: SettingType = .radio
  @AppStorage("selectedProfileType") var selectedProfileType: ProfileType = .mic


  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      TabView(selection: $selectedSettingType) {
        Group {
          RadioSettingsView(store: Store(
            initialState: RadioSettingsFeature.State(),
            reducer: RadioSettingsFeature()), radio: objectModel.radio ?? Radio(Packet()))
          .tabItem {
            Text(SettingType.radio.rawValue)
            Image(systemName: "antenna.radiowaves.left.and.right")
          }.tag(SettingType.radio)
          
          NetworkSettingsView(store: Store(initialState: NetworkSettingsFeature.State(),
                                           reducer: NetworkSettingsFeature()),
                              radio: objectModel.radio ?? Radio(Packet()) )
          .tabItem {
            Text(SettingType.network.rawValue)
            Image(systemName: "wifi")
          }.tag(SettingType.network)
          
          GpsSettingsView()
            .tabItem {
              Text("Gps")
              Image(systemName: "globe")
            }.tag(SettingType.gps)
          
          TxSettingsView(store: Store(initialState: TxSettingsFeature.State(),
                                      reducer: TxSettingsFeature()) )
          .tabItem {
            Text(SettingType.tx.rawValue)
            Image(systemName: "bolt.horizontal")
          }.tag(SettingType.tx)
          
          PhoneCwSettingsView(store: Store(initialState: PhoneCwSettingsFeature.State(),
                                           reducer: PhoneCwSettingsFeature()))
          .tabItem {
            Text(SettingType.phoneCw.rawValue)
            Image(systemName: "mic")
          }.tag(SettingType.phoneCw)
          
        }
        Group {
          //          RxSettingsView()
          //            .tabItem {
          //              Text("Rx")
          //              Image(systemName: "headphones")
          //            }
          XvtrSettingsView()
            .tabItem {
              Text(SettingType.xvtrs.rawValue)
              Image(systemName: "arrow.up.arrow.down.circle")
            }.tag(SettingType.xvtrs)
          
          ProfilesSettingsView(
            store:
              Store(initialState: ProfilesSettingsFeature.State(),
                    reducer: ProfilesSettingsFeature()) )
          .tabItem {
            Text(SettingType.profiles.rawValue)
            Image(systemName: "brain.head.profile")
          }.tag(SettingType.profiles)

          ColorsSettingsView(store: Store(initialState: ColorsSettingsFeature.State(),
                                          reducer: ColorsSettingsFeature()))
          .tabItem {
            Text(SettingType.colors.rawValue)
            Image(systemName: "eyedropper")
          }.tag(SettingType.colors)

          OtherSettingsView(store: Store(initialState: OtherSettingsFeature.State(),
                                          reducer: OtherSettingsFeature()))
          .tabItem {
            Text(SettingType.other.rawValue)
            Image(systemName: "gear")
          }.tag(SettingType.other)
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
                 objectModel: ObjectModel())
    .frame(width: 600, height: 350)
    .padding()
  }
}
