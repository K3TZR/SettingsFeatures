//
//  ProfilesView.swift
//  ViewFeatures/SettingsFeature/Profiles
//
//  Created by Douglas Adams on 12/30/22.
//

import ComposableArchitecture
import SwiftUI

import FlexApi

public enum ProfileType: String {
  case mic
  case tx
  case global
}

public struct ProfilesView: View {
  let store: StoreOf<ProfilesFeature>
  
  public init(store: StoreOf<ProfilesFeature>) {
    self.store = store
  }
  @AppStorage("selectedProfileType") var selectedProfileType: ProfileType = .mic
  
  @Dependency(\.apiModel) var apiModel
  @Dependency(\.objectModel) var objectModel
  
  public var body: some View {
    
    if apiModel.clientInitialized {
      ProfileView(store: store, profile: objectModel.profiles[id: selectedProfileType.rawValue]!, profileType: selectedProfileType)
    } else {
      VStack {
        Text("Radio must be connected").font(.title).foregroundColor(.red)
        Text("to use Profile Settings").font(.title).foregroundColor(.red)
      }      
    }
  }
}

private struct ProfileView: View {
  let store: StoreOf<ProfilesFeature>
  let profile: Profile
  let profileType: ProfileType
  
  @State private var selection: String?
  @State private var newProfileName = ""
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack(alignment: .leading) {
        HStack(spacing: 40) {
          ControlGroup {
            Toggle("MIC", isOn: viewStore.binding(
              get: {_ in profileType == .mic},
              send: .profileType(.mic) ))
            Toggle("TX", isOn: viewStore.binding(
              get: {_ in profileType == .tx},
              send: .profileType(.tx) ))
            Toggle("GLOBAL", isOn: viewStore.binding(
              get: {_ in profileType == .global},
              send: .profileType(.global) ))
          }
        }
        .font(.title)
        .foregroundColor(.blue)
        
        Spacer()
        TextField("New Profile Name", text: $newProfileName)
        Spacer()
        
        
        List(profile.list, id: \.self, selection: $selection) { name in
          Text(name).tag(name)
            .foregroundColor(profile.current == name ? .red : nil)
            .onTapGesture {
              selection = selection == nil ? name : nil
            }
        }
        Divider().foregroundColor(.blue)
        
        HStack {
          Spacer()
          Button("New") { viewStore.send(.profileProperty(profile, "create", newProfileName)) }
            .disabled(newProfileName.isEmpty)
          Group {
            Button("Delete") { viewStore.send(.profileProperty(profile, "delete", selection!)) }
            Button("Reset") { viewStore.send(.profileProperty(profile, "reset", selection!)) }
            Button("Load") { viewStore.send(.profileProperty(profile, "load", selection!)) }
          }.disabled(selection == nil)
          Spacer()
        }
      }
    }
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct ProfilesView_Previews: PreviewProvider {
  static var previews: some View {
    ProfilesView(store: Store(
      initialState: ProfilesFeature.State(),
      reducer: ProfilesFeature())
    )
    .frame(width: 600, height: 350)
    .padding()
    
  }
}
