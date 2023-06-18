//
//  OtherView.swift
//  
//
//  Created by Douglas Adams on 3/1/23.
//

import ComposableArchitecture
import SwiftUI

//import ApiStringView
import FlexApi

public struct OtherView: View {
  let store: StoreOf<OtherFeature>
  
  public init(store: StoreOf<OtherFeature>) {
    self.store = store
  }
  
  @AppStorage("meterId") public var meterId: Int = 4
  @AppStorage("logBroadcasts") var logBroadcasts = false
  @AppStorage("ignoreTimeStamps") var ignoreTimeStamps = false
  @AppStorage("alertOnError") var alertOnError = false

  @Dependency(\.apiModel) var apiModel

  @State var altName = ""
  
  struct Meter {
    var id: Int
    var name: String
    
    init(_ id: Int, _ name: String) {
      self.id = id
      self.name = name
    }
  }
  
  // FIXME: Only valid for Flex-6500 ???
  let meters = [
    Meter(1, "micpeak"),Meter(2, "mic"),Meter(3, "hwalc"),Meter(4, "+13.8a"),Meter(5, "+13.8b"),
    Meter(6, "fwdpwr"),Meter(7, "refpwr"),Meter(8, "swr"),Meter(9, "patemp"),Meter(10, "24khz"),
    Meter(11, "osc"),Meter(12, "level"),Meter(13, "nr/anf"),Meter(14, "agc+"),Meter(15, "codec"),
    Meter(16, "sc_mic"),Meter(17, "comppeak"),Meter(18, "sc_filt_1"),Meter(19, "alc"),Meter(20, "pre_wave_agc"),
    Meter(21, "pre_wave"),Meter(22, "sc_filt_2"),Meter(23, "b4ramp"),Meter(24, "aframp"),Meter(25, "post_p"),
    Meter(26, "gain")
  ]
  
  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      
      VStack {
        Picker("Monitor meter", selection: $meterId) {
          ForEach(meters, id: \.id) { meter in
            Text(meter.name).tag(meter.id)
          }
        }
        .labelsHidden()
        .pickerStyle(.menu)
        .frame(width: 100, alignment: .leading)
        
        Spacer()
        Toggle("Log Broadcasts", isOn: $logBroadcasts )
        Toggle("Ignore TimeStamps", isOn: $ignoreTimeStamps )
        Toggle("Alert on Error / Warning", isOn: $alertOnError )

        Spacer()
        
        VStack {
          Text("Custom Antenna Names")
          Divider()
          Grid (verticalSpacing: 10) {
            ForEach(viewStore.antList, id: \.self) { antenna in
              GridRow {
                Text(antenna)
                TextField("alt name", text: viewStore.binding(
                  get: {_ in apiModel.altAntennaName(for: antenna) },
                  send: { .addAltName(antenna, $0) }))
              }.frame(width: 120)
            }
          }
        }.frame(width: 200)
        Spacer()
      }
    }
  }
}

struct OtherView_Previews: PreviewProvider {
  static var previews: some View {
    OtherView(store: Store(
      initialState: OtherFeature.State(antList: []),
      reducer: OtherFeature())
    ).frame(width: 500, height: 400)
  }
}
