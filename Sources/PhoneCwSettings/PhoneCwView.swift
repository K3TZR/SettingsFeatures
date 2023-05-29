//
//  PhoneCwView.swift
//  ViewFeatures/SettingsFeature/PhoneCw
//
//  Created by Douglas Adams on 5/13/21.
//

import ComposableArchitecture
import SwiftUI

import ApiIntView
import FlexApi
import Shared

public struct PhoneCwView: View {
  let store: StoreOf<PhoneCwFeature>
  
  public init(store: StoreOf<PhoneCwFeature>) {
    self.store = store
  }
  @Dependency(\.apiModel) var apiModel
  @Dependency(\.objectModel) var objectModel
  
  public var body: some View {
    
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      if apiModel.radio == nil {
        VStack {
          Text("Radio must be connected").font(.title).foregroundColor(.red)
          Text("to use PhoneCw Settings").font(.title).foregroundColor(.red)
        }

      } else {
        VStack(spacing: 10) {
          Group {
            MicGridView(viewStore: viewStore, transmit: objectModel.transmit)
            Spacer()
            Divider().foregroundColor(.blue)
          }
          Group {
            Spacer()
            CwGridView(viewStore: viewStore, transmit: objectModel.transmit)
            Spacer()
            Divider().foregroundColor(.blue)
          }
          Group {
            Spacer()
            RttyGridView(viewStore: viewStore, radio: apiModel.radio ?? Radio(Packet()))
            Spacer()
            Divider().foregroundColor(.blue)
          }
          Group {
            Spacer()
            FiltersGridView(viewStore: viewStore, radio: apiModel.radio ?? Radio(Packet()))
            Spacer()
          }
        }
      }
    }
  }
}

private struct MicGridView: View {
  let viewStore: ViewStore<PhoneCwFeature.State, PhoneCwFeature.Action>
  @ObservedObject var transmit: Transmit

  var body: some View {
    Grid(alignment: .leading, horizontalSpacing: 80, verticalSpacing: 20) {
      GridRow() {
        Toggle("Microphone bias", isOn: viewStore.binding(
          get: {_ in transmit.micBiasEnabled },
          send: { .transmitProperty(transmit, .micBiasEnabled, $0.as1or0) } ))
        Toggle("Mic level during receive", isOn: viewStore.binding(
          get: {_ in transmit.meterInRxEnabled },
          send: { .transmitProperty(transmit, .meterInRxEnabled, $0.as1or0) } ))
        Toggle("+20 db Mic gain", isOn: viewStore.binding(
          get: {_ in transmit.micBoostEnabled },
          send: {.transmitProperty(transmit, .micBoostEnabled, $0.as1or0) } ))
      }
    }
  }
}

private struct CwGridView: View {
  let viewStore: ViewStore<PhoneCwFeature.State, PhoneCwFeature.Action>
  @ObservedObject var transmit: Transmit

  private let iambicModes = ["A", "B"]
  private let cwSidebands = ["Upper", "Lower"]

  var body: some View {
    Grid(alignment: .leading, horizontalSpacing: 60, verticalSpacing: 20) {
      GridRow() {
        Toggle("Iambic", isOn: viewStore.binding(
          get: {_ in transmit.cwIambicEnabled },
          send: {.transmitProperty(transmit, .cwIambicEnabled, $0.as1or0) } ))

        Picker("", selection: viewStore.binding(
          get: {_ in transmit.cwIambicMode ? "B" : "A"},
          send: { .transmitProperty(transmit, .cwIambicMode, ($0 == "B").as1or0) } )) {
            ForEach(iambicModes, id: \.self) {
              Text($0).tag($0)
            }
          }
          .labelsHidden()
          .pickerStyle(.segmented)
          .frame(width: 110)

        Toggle("Swap dot / dash", isOn: viewStore.binding(
          get: {_ in transmit.cwSwapPaddles },
          send: {.transmitProperty(transmit, .cwSwapPaddles, $0.as1or0) } ))

        Toggle("CWX sync", isOn: viewStore.binding(
          get: {_ in transmit.cwSyncCwxEnabled },
          send: {.transmitProperty(transmit, .cwSyncCwxEnabled, $0.as1or0) } ))
      }

      GridRow {
        Text("CW Sideband")
        Picker("", selection: viewStore.binding(
          get: {_ in transmit.cwlEnabled ? "Lower" : "Upper" },
          send: { .transmitProperty(transmit, .cwlEnabled, ($0 == "Lower").as1or0) } )) {
            ForEach(cwSidebands, id: \.self) {
              Text($0).tag($0)
            }
          }
          .labelsHidden()
          .pickerStyle(.segmented)
          .frame(width: 110)
      }
    }
  }
}

private struct FiltersGridView: View {
  let viewStore: ViewStore<PhoneCwFeature.State, PhoneCwFeature.Action>
  @ObservedObject var radio: Radio

  var body: some View {
    Grid(horizontalSpacing: 20, verticalSpacing: 5) {
      GridRow() {
        Text("Voice")
        Text(radio.filterVoiceLevel, format: .number).frame(width: 20).multilineTextAlignment(.trailing)
        Slider(value: viewStore.binding(
          get: {_ in  Double(radio.filterVoiceLevel) },
          send: { .filterProperty(radio, .voice, .level, String(Int($0))) }), in: 0...3, step: 1).frame(width: 250)
        Toggle("Auto", isOn: viewStore.binding(
          get: {_ in  radio.filterVoiceAutoEnabled },
          send: { .filterProperty(radio, .voice, .autoLevel, $0.as1or0) }))
      }
      GridRow() {
        Text("CW")
        Text(radio.filterCwLevel, format: .number).frame(width: 20).multilineTextAlignment(.trailing)
        Slider(value: viewStore.binding(
          get: {_ in  Double(radio.filterCwLevel) },
          send: { .filterProperty(radio, .cw, .level, String(Int($0))) }), in: 0...3, step: 1).frame(width: 250)
        Toggle("Auto", isOn: viewStore.binding(
          get: {_ in  radio.filterCwAutoEnabled },
          send: { .filterProperty(radio, .cw, .autoLevel, $0.as1or0) }))
      }
      GridRow() {
        Text("Digital")
        Text(radio.filterDigitalLevel, format: .number).frame(width: 20).multilineTextAlignment(.trailing)
        Slider(value: viewStore.binding(
          get: {_ in  Double(radio.filterDigitalLevel) },
          send: { .filterProperty(radio, .digital, .level, String(Int($0))) }), in: 0...3, step: 1).frame(width: 250)
        Toggle("Auto", isOn: viewStore.binding(
          get: {_ in  radio.filterDigitalAutoEnabled },
          send: { .filterProperty(radio, .digital, .autoLevel, $0.as1or0) }))
      }
    }
  }
}

private struct RttyGridView: View {
  let viewStore: ViewStore<PhoneCwFeature.State, PhoneCwFeature.Action>
  @ObservedObject var radio: Radio

  var body: some View {
    Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 20) {
      GridRow() {
        Text("RTTY Mark default").frame(width: 115, alignment: .leading)
        ApiIntView(value: radio.rttyMark, action: { _ in viewStore.send(.radioProperty(radio, .rttyMark, String(radio.rttyMark))) } )
      }
    }
  }
}

//struct PhoneCwView_Previews: PreviewProvider {
//  static var previews: some View {
//    PhoneCwView(store: Store(
//      initialState: PhoneCwFeature.State(),
//      reducer: PhoneCwFeature())
//    )
//    .frame(width: 600, height: 350)
//    .padding()
//  }
//}
