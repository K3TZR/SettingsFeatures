//
//  ConnectionView.swift
//  
//
//  Created by Douglas Adams on 6/12/23.
//

import ComposableArchitecture
import SwiftUI

import FlexApi
import Shared

public struct ConnectionView: View {
  
  @Dependency(\.apiModel) var apiModel
  
  public init() {}
  
  public var body: some View {
    
    VStack(alignment: .leading) {
      HeadingView()
      Spacer()
      Divider()
      Spacer()
      ListHeadingView()
      Divider().background(Color.blue)
      ListView(apiModel: apiModel)
        .frame(height: 200)
    }
  }
}

private struct HeadingView: View {
  
  @AppStorage("discoveryType") var discoveryType = DiscoveryType.broadcast.rawValue
  @AppStorage("localEnabled") var localEnabled = true
  @AppStorage("smartlinkEnabled") var smartlinkEnabled = false
  @AppStorage("useDefault") var useDefault = false

  public var body: some View {

    Grid {
      GridRow {
        Text("Discovery Type").frame(width: 140, alignment: .leading)
        Picker("", selection: $discoveryType) {
          Text(DiscoveryType.broadcast.rawValue).tag(DiscoveryType.broadcast.rawValue)
          Text(DiscoveryType.direct.rawValue).tag(DiscoveryType.direct.rawValue)
        }
        .frame(width: 200, alignment: .leading)
        .labelsHidden()
        .pickerStyle(.radioGroup)
        .horizontalRadioGroupLayout()
        
        Toggle("Use Default", isOn: $useDefault)
      }
      GridRow {
        Text("Connection Type").frame(width: 140, alignment: .leading)
        ControlGroup {
          Toggle(isOn: $localEnabled) {
            Text("Local") }
          Toggle(isOn: $smartlinkEnabled) {
            Text("Smartlink") }
        }
        .disabled(discoveryType == DiscoveryType.direct.rawValue)
        .frame(width: 200)
      }
    }
  }
}

private struct ListHeadingView: View {

  public var body: some View {

    HStack {
      Spacer()
      Text("Direct Connect Radios").font(.title2).bold()
      Spacer()
    }
    HStack {
      Group {
        Text("Name")
        Text("Location")
        Text("IP Address")
      }
      .frame(width: 180, alignment: .leading)
    }
  }
}

private struct ListView: View {
  @ObservedObject var apiModel: ApiModel
  
  @AppStorage("knownRadios") var knownRadios = [KnownRadio]()
  
  @State var selection: UUID?

  public var body: some View {
    
    VStack(alignment: .leading) {
      List($knownRadios, selection: $selection) { $radio in
        HStack {
          Group {
            TextField("Name", text: $radio.name)
//            TextField("Location", text: $radio.location)
            TextField("IP Address", text: $radio.ipAddress)
          }
          .frame(width: 180, alignment: .leading)
        }
      }
      
      Divider().background(Color.blue)
      
      HStack (spacing: 40) {
        Spacer()
        Button("Add") { knownRadios.append(KnownRadio("New Radio", "", ""))}
        Button("Delete") {
          for radio in knownRadios where radio.id == selection {
            knownRadios.remove(at: knownRadios.firstIndex(of: radio)!)
          }
        }.disabled(selection == nil)
      }
      Spacer()
    }

  }
}

//private struct FooterView: View {
//  @Binding var radios: [KnownRadio]
//  let selection: KnownRadio?
//
//  @Dependency(\.apiModel) var apiModel
//
//  public var body: some View {
//
//    HStack (spacing: 40) {
//      Spacer()
//      Button("Add") { radios.append(KnownRadio("New Radio", "", ""))}
//      Button("Delete") { radios.remove(at: radios.firstIndex(of: selection!)!)}.disabled(selection == nil)
//    }
//    Spacer()
//  }
//}


struct ConnectionView_Previews: PreviewProvider {
  static var previews: some View {
    ConnectionView()
      .frame(width: 600, height: 350)
      .padding()
  }
}
