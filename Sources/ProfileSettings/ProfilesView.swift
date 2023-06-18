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
    
    if objectModel.profiles.count > 0 {
      ForEach(objectModel.profiles) { profile in
        if selectedProfileType.rawValue == profile.id {
          ProfileView(store: store, profile: profile)
        }
      }
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
  @ObservedObject var profile: Profile
  
  @State private var selection: String?
  @State private var newProfileName = ""
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack(alignment: .leading) {
        HStack(spacing: 40) {
          ControlGroup {
            Toggle("MIC", isOn: viewStore.binding(
              get: {_ in profile.id == ProfileType.mic.rawValue},
              send: .profileType(.mic) ))
            Toggle("TX", isOn: viewStore.binding(
              get: {_ in profile.id == ProfileType.tx.rawValue},
              send: .profileType(.tx) ))
            Toggle("GLOBAL", isOn: viewStore.binding(
              get: {_ in profile.id == ProfileType.global.rawValue},
              send: .profileType(.global) ))
          }
        }
        .font(.title)
        .foregroundColor(.blue)
        
        List($profile.list, id: \.self, selection: $selection) { $name in
          TextField("Name", text: $name).tag(name)
            .foregroundColor(profile.current == name ? .red : nil)
        }
        Divider().foregroundColor(.blue)
        
        HStack {
          Spacer()
          Button("New") { viewStore.send(.profileProperty(profile, "create", "A New Profile")) }
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
