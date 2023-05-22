//
//  TxView.swift
//  SettingsFeature/TxFeature
//
//  Created by Douglas Adams on 5/13/21.
//

import ComposableArchitecture
import SwiftUI

import ApiIntView
import FlexApi

public struct TxView: View {
  let store: StoreOf<TxFeature>
  
  public init(store: StoreOf<TxFeature>) {
    self.store = store
  }
  @Dependency(\.apiModel) var apiModel
  @Dependency(\.objectModel) var objectModel
  
  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      if apiModel.clientInitialized {
        VStack {
          Group {
            InterlocksGridView(viewStore: viewStore,interlock: objectModel.interlock)
            Spacer()
            Divider().foregroundColor(.blue)
          }
          Group {
            Spacer()
            TxGridView(viewStore: viewStore,
                       interlock: objectModel.interlock,
                       txProfile: objectModel.profiles[id: "tx"] ?? Profile("tx"),
                       transmit: objectModel.transmit
            )
            Spacer()
          }
        }
      } else {
        VStack {
          Text("Radio must be connected").font(.title).foregroundColor(.red)
          Text("to use Tx Settings").font(.title).foregroundColor(.red)
        }
      }
    }
  }
}

private struct InterlocksGridView: View {
  let viewStore: ViewStore<TxFeature.State, TxFeature.Action>
  @ObservedObject var interlock: Interlock
  
  private let interlockLevels = ["Disabled", "Active High", "Active Low"]
  
  let width: CGFloat = 100
  
  var rcaSelection: Int {
    guard interlock.rcaTxReqEnabled else { return 0 }
    return interlock.rcaTxReqPolarity ? 1 : 2
  }
  var accSelection: Int {
    guard interlock.accTxReqEnabled else { return 0 }
    return interlock.accTxReqPolarity ? 1 : 2
  }
  
  var body: some View {
    Grid(alignment: .leading, horizontalSpacing: 200, verticalSpacing: 20) {
      
      GridRow() {
        Picker("RCA", selection: viewStore.binding(
          get: {_ in interlockLevels[rcaSelection] },
          send: { .interlockState(interlock, .rcaTxReqEnabled, $0) } )) {
            ForEach(interlockLevels, id: \.self) {
              Text($0).tag($0)
            }
          }
          .pickerStyle(.menu)
          .frame(width: 180)

        Picker("ACC", selection: viewStore.binding(
          get: {_ in interlockLevels[accSelection]  },
          send: { .interlockProperty(interlock, .accTxReqEnabled, $0) } )) {
            ForEach(interlockLevels, id: \.self) {
              Text($0).tag($0)
            }
          }
          .pickerStyle(.menu)
          .frame(width: 180)

      }
      GridRow() {
        HStack {
          Toggle("RCA TX1", isOn: viewStore.binding(
            get: {_ in  interlock.tx1Enabled },
            send: { .interlockProperty(interlock, .tx1Enabled, $0.as1or0) } ))
          ApiIntView(hint: "tx1 delay", value: interlock.tx1Delay, action: {viewStore.send(.interlockProperty(interlock, .tx1Delay, $0)) } )
        }
        
        HStack {
          Toggle("ACC TX", isOn: viewStore.binding(
            get: {_ in  interlock.accTxEnabled },
            send: { .interlockProperty(interlock, .accTxEnabled, $0.as1or0) } ))
          ApiIntView(hint: "acc delay", value: interlock.accTxDelay, action: { viewStore.send(.interlockProperty(interlock, .accTxDelay, $0)) } )
        }
      }.frame(width: 180)
      
      GridRow() {
        HStack {
          Toggle("RCA TX2", isOn: viewStore.binding(
            get: {_ in  interlock.tx2Enabled},
            send: {.interlockProperty(interlock, .tx2Enabled, $0.as1or0) } ))
          ApiIntView(hint: "tx2 delay", value: interlock.tx2Delay, action: {viewStore.send(.interlockProperty(interlock, .tx2Delay, $0)) } )
        }
        HStack {
          Text("TX Delay").frame(width: 65, alignment: .leading)
          ApiIntView(hint: "tx delay", value: interlock.txDelay, action: {viewStore.send(.interlockProperty(interlock, .txDelay, $0)) } )
        }
      }.frame(width: 180)
      
      GridRow() {
        HStack {
          Toggle("RCA TX3", isOn: viewStore.binding(
            get: {_ in  interlock.tx3Enabled},
            send: { .interlockProperty(interlock, .tx3Enabled, $0.as1or0) } ))
          ApiIntView(hint: "tx3 delay", value: interlock.tx3Delay, action: {viewStore.send(.interlockProperty(interlock, .tx3Delay, $0)) } )
        }
        HStack {
          Text("Timeout (min)")
          ApiIntView(value: interlock.timeout, action: {viewStore.send(.interlockProperty(interlock, .timeout, $0)) })
        }
      }.frame(width: 180)
    }
  }
}

private struct TxGridView: View {
  let viewStore: ViewStore<TxFeature.State, TxFeature.Action>
  @ObservedObject var interlock: Interlock
  @ObservedObject var txProfile: Profile
  @ObservedObject var transmit: Transmit
  
  var body: some View {
    Grid(alignment: .leading, horizontalSpacing: 40, verticalSpacing: 20) {
      
      GridRow() {
        Toggle("TX Inhibit", isOn: viewStore.binding(
          get: {_ in  transmit.inhibit },
          send: { .transmitProperty(transmit, .inhibit, $0.as1or0) } ))
        .toggleStyle(.checkbox)
        Toggle("TX in Waterfall", isOn: viewStore.binding(
          get: {_ in  transmit.txInWaterfallEnabled},
          send: { .transmitProperty(transmit, .txInWaterfallEnabled, $0.as1or0) } ))
        .toggleStyle(.checkbox)
        Text("Tx Profile")
        Picker("", selection: viewStore.binding(
          get: {_ in  txProfile.current},
          send: { .profileProperty(txProfile, $0) })) {
            ForEach(txProfile.list, id: \.self) {
              Text($0).tag($0)
            }
          }
          .labelsHidden()
          .pickerStyle(.menu)
          .frame(width: 180)
      }
      GridRow() {
        Text("Max Power")
        HStack {
          Text("\(String(format: "%3d", transmit.maxPowerLevel))")
          Slider(value: viewStore.binding(
            get: {_ in  Double(transmit.maxPowerLevel) },
            send: { .transmitProperty(transmit, .maxPowerLevel, String(Int($0))) } ), in: 0...100).frame(width: 150)
        }.gridCellColumns(2)
        Toggle("Hardware ALC", isOn: viewStore.binding(
          get: {_ in  transmit.hwAlcEnabled},
          send: { .transmitProperty(transmit, .hwAlcEnabled, $0.as1or0) } ))
      }
    }
  }
}

struct TxView_Previews: PreviewProvider {
  static var previews: some View {
    TxView(store: Store(initialState: TxFeature.State(), reducer: TxFeature()))
      .frame(width: 600, height: 350)
      .padding()
  }
}
