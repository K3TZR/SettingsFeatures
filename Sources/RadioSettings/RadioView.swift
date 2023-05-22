//
//  RadioView.swift
//  SettingsFeature/RadioFeature
//
//  Created by Douglas Adams on 5/13/21.
//

import ComposableArchitecture
import SwiftUI

import ApiIntView
import ApiStringView
import FlexApi
import Shared

public struct RadioView: View {
  let store: StoreOf<RadioFeature>
  @ObservedObject var radio: Radio
  
  public init(store: StoreOf<RadioFeature>, radio: Radio) {
    self.store = store
    self.radio = radio
  }
  @Dependency(\.apiModel) var apiModel
  
  private let regions = ["USA", "Other"]
  private let screensavers = ["Model", "Callsign", "Nickname"]
  
  public var body: some View {
    
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      if apiModel.clientInitialized {
        VStack {
          Group {
            RadioGridView(viewStore: viewStore, radio: radio)
            Spacer()
            Divider().foregroundColor(.blue)
            Spacer()
            ButtonsGridView(viewStore: viewStore, radio: radio)
            Spacer()
            Divider().foregroundColor(.blue)
          }
          Group {
            Spacer()
            CalibrationGridView(viewStore: viewStore, radio: radio)
            Spacer()
          }
        }
      } else {
        VStack {
          Text("Radio must be connected").font(.title).foregroundColor(.red)
          Text("to use Radio Settings").font(.title).foregroundColor(.red)
        }
      }
    }
  }
}

private struct RadioGridView: View {
  let viewStore: ViewStore<RadioFeature.State, RadioFeature.Action>
  @ObservedObject var radio: Radio

  private let width: CGFloat = 150

  var body: some View {
    Grid(alignment: .leading, horizontalSpacing: 30, verticalSpacing: 10) {
      GridRow() {
        Text("Serial Number")
        Text(radio.packet?.serial ?? "")
      }
      GridRow() {
        Text("Hardware Version")
        Text("v" + (radio.hardwareVersion ?? ""))
        Text("Firmware Version")
        Text("v" + (radio.softwareVersion))
      }
      GridRow() {
        Text("Model")
        Text(radio.radioModel)
        Text("Options")
        Text(radio.radioOptions)
      }
      GridRow() {
        Text("Region")
        Picker("", selection: viewStore.binding(
          get: {_ in  radio.region },
          send: { .radioProperty(radio, .region, $0) })) {
            ForEach(radio.regionList, id: \.self) {
              Text($0).tag($0)
            }
          }
          .labelsHidden()
          .pickerStyle(.menu)
          .frame(width: width)
        
        Text("Screen saver")
        Picker("", selection: viewStore.binding(
          get: {_ in  radio.radioScreenSaver },
          send: { .radioProperty(radio, .screensaver, $0) })) {
            ForEach(["Model","Name","Callsign"] , id: \.self) {
              Text($0).tag($0.lowercased())
            }
          }
          .labelsHidden()
          .pickerStyle(.menu)
          .frame(width: width)
      }
      GridRow() {
        Text("Callsign")
        ApiStringView(value: radio.callsign, action: { _ in viewStore.send(.radioProperty(radio, .callsign, radio.callsign)) })

        Text("Radio Name")
        ApiStringView(value: radio.name, action: { _ in viewStore.send(.radioProperty(radio, .name, radio.name)) } )
      }
    }
  }
}

private struct ButtonsGridView: View {
  let viewStore: ViewStore<RadioFeature.State, RadioFeature.Action>
  @ObservedObject var radio: Radio
  
  var body: some View {
    Grid(alignment: .leading, horizontalSpacing: 5, verticalSpacing: 10) {
      GridRow() {
        Toggle("Remote On", isOn: viewStore.binding(
          get: {_ in radio.remoteOnEnabled },
          send: { .radioProperty(radio, .remoteOnEnabled, $0.as1or0) } ))
        Toggle("Flex Control", isOn: viewStore.binding(
          get: {_ in radio.flexControlEnabled },
          send: { .radioProperty(radio, .flexControlEnabled, $0.as1or0) } ))
        Toggle("Mute audio (remote)", isOn: viewStore.binding(
          get: {_ in  radio.muteLocalAudio },
          send: { .radioProperty(radio, .muteLocalAudio, $0.as1or0) } ))
        Toggle("Binaural audio", isOn: viewStore.binding(
          get: {_ in  radio.binauralRxEnabled },
          send: { .radioProperty(radio, .binauralRxEnabled, $0.as1or0) } ))
      }.frame(width: 150, alignment: .leading)
      GridRow() {
        Toggle("Snap to tune step", isOn: viewStore.binding(
          get: {_ in  radio.snapTuneEnabled},
          send: { .radioProperty(radio, .snapTuneEnabled, $0.as1or0) } ))
        Toggle("Single click to tune", isOn: viewStore.binding(
          get: {_ in  false },
          send: .singleClickButton ))
        .disabled(true)
        Toggle("Start slices minimized", isOn: viewStore.binding(
          get: {_ in  false },
          send: .sliceMinimizedButton ))
        .gridCellColumns(2)
        .disabled(true)
      }
    }
  }
}

private struct CalibrationGridView: View {
  let viewStore: ViewStore<RadioFeature.State, RadioFeature.Action>
  @ObservedObject var radio: Radio
  
  private let width: CGFloat = 100

  var body: some View {
    
    Grid(alignment: .center, horizontalSpacing: 40, verticalSpacing: 10) {
      GridRow() {
        Text("Frequency")
        ApiIntView(value: radio.calFreq, formatter: NumberFormatter.dotted, action: { stringFreq in viewStore.send(.radioProperty(radio, .calFreq, stringFreq.toMhz)) })

        Button("Calibrate") { viewStore.send(.radioProperty(radio, .calibrate, "")) }
        
        Text("Offset (ppb)")
        ApiIntView(value: radio.freqErrorPpb, action: { stringFreq in viewStore.send(.radioProperty(radio, .freqErrorPpb, stringFreq))  })
      }
    }
  }
}

struct RadioView_Previews: PreviewProvider {
  static var previews: some View {
    RadioView(store: Store(initialState: RadioFeature.State(),
                                   reducer: RadioFeature()), radio: Radio(Packet()))
      .frame(width: 600, height: 350)
      .padding()
  }
}
