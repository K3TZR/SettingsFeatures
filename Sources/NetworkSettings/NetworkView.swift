//
//  NetworkView.swift
//  ViewFeatures/SettingsFeature/Network
//
//  Created by Douglas Adams on 5/13/21.
//

import ComposableArchitecture
import SwiftUI

import ApiStringView
import FlexApi
import Shared

public struct NetworkView: View {
  let store: StoreOf<NetworkFeature>
  @ObservedObject var radio: Radio
  
  public init(store: StoreOf<NetworkFeature>, radio: Radio) {
    self.store = store
    self.radio = radio
  }
  @Dependency(\.apiModel) var apiModel
  
  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      if apiModel.clientInitialized {
        VStack {
          Spacer()
          Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 20) {
            CurrentAddressView(viewStore: viewStore, radio: radio, apiModel: apiModel)
            Spacer()
            Divider().background(Color(.blue))
            Spacer()
            StaticAddressView(viewStore: viewStore, radio: radio)
            Spacer()
          }
        }
      } else {
        VStack {
          Text("Radio must be connected").font(.title).foregroundColor(.red)
          Text("to use Network Settings").font(.title).foregroundColor(.red)
        }
      }
    }
  }
}

private struct CurrentAddressView: View {
  let viewStore: ViewStore<NetworkFeature.State, NetworkFeature.Action>
  @ObservedObject var radio: Radio
  @ObservedObject var apiModel: ApiModel

  init(viewStore: ViewStore<NetworkFeature.State, NetworkFeature.Action>, radio: Radio, apiModel: ApiModel) {
    self.viewStore = viewStore
    self.radio = radio
    self.apiModel = apiModel
  }
  
  private var addressTypes = ["Static", "DHCP"]
//  private let width: CGFloat = 140
  
  var body: some View {
    GridRow {
      Text("Serial number")
      Text(radio.packet.serial).foregroundColor(.secondary)
      Text("MAC Address")
      Text(apiModel.macAddress).foregroundColor(.secondary)
    }
    
    GridRow {
      Text("IP Address")
      Text(radio.packet.publicIp).foregroundColor(.secondary)
      Text("Mask")
      Text(apiModel.netmask).foregroundColor(.secondary)
    }
    
    GridRow {
      Text("Address Type")
      Picker("", selection: viewStore.binding(
        get: {_ in radio.addressType },
        send: { .addressType(radio, $0) } )) {
          ForEach(addressTypes, id: \.self) {
            Text($0)
          }
        }
        .labelsHidden()
        .pickerStyle(.segmented)
        .frame(width: 100)
      
      Toggle("Enforce Private IP", isOn: viewStore.binding(
        get: {_ in radio.enforcePrivateIpEnabled },
        send: { .enforcePrivateIpButton(radio, $0) } ))
      .gridCellColumns(2)
    }
  }
}

private struct StaticAddressView: View {
  let viewStore: ViewStore<NetworkFeature.State, NetworkFeature.Action>
  @ObservedObject var radio: Radio

  private let width: CGFloat = 140
  
  var body: some View {
    
    Text("Static Address (----- NOT implemented -----)").font(.title3).foregroundColor(.blue)
    GridRow() {
      Button("Apply") { viewStore.send(.applyStaticButton(radio))}
        .disabled(radio.staticIp.isEmpty || radio.staticMask.isEmpty || radio.staticGateway.isEmpty)
    }
    GridRow {
      Text("IP Address")
      ApiStringView(hint: "Static ip", value: radio.staticIp, action: { viewStore.send(.staticIp(radio, $0)) } , width: width)
      
      Text("Mask")
      ApiStringView(hint: "Static mask", value: radio.staticMask, action: { viewStore.send(.staticMask(radio, $0)) } , width: width)
    }
    GridRow {
      Text("Gateway")
      ApiStringView(hint: "Static gateway", value: radio.staticGateway, action: { viewStore.send(.staticGateway(radio, $0)) } , width: width)
    }
  }
}

struct NetworkView_Previews: PreviewProvider {
  static var previews: some View {
    NetworkView(store: Store(initialState: NetworkFeature.State(), reducer: NetworkFeature()), radio: Radio(Packet()))
      .frame(width: 600, height: 350)
      .padding()
  }
}
