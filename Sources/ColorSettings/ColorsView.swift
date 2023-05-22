//
//  ColorsView.swift
//  ViewFeatures/SettingsFeature/Colors
//
//  Created by Douglas Adams on 5/13/21.
//

import ComposableArchitecture
import SwiftUI

public struct ColorsView: View {
  let store: StoreOf<ColorsFeature>
  
  public init(store: StoreOf<ColorsFeature>) {
    self.store = store
  }
  
  static let defaultColors: Dictionary<String,Color> =
  [
    "dbLegend": .green,
    "dbLines": .white.opacity(0.3),
    "frequencyLegend": .green,
    "gridLines": .white.opacity(0.3),
    "markerEdge": .red.opacity(0.2),
    "markerSegment": .white.opacity(0.2),
    "spectrum": .white,
    "spectrumFill": .white.opacity(0.2),
    
    "background": .black,
    "marker": .yellow,
    "sliceActive": .red.opacity(0.6),
    "sliceFilter": .white.opacity(0.3),
    "sliceInactive": .yellow.opacity(0.6),
    "tnfActive": .green.opacity(0.2),
    "tnfInactive": .yellow.opacity(0.2),
  ]
  
  @AppStorage("dbLegend") var dbLegend: Color = defaultColors["dbLegend"]!
  @AppStorage("dbLines") var dbLines: Color = defaultColors["dbLines"]!
  @AppStorage("frequencyLegend") var frequencyLegend: Color = defaultColors["frequencyLegend"]!
  @AppStorage("gridLines") var gridLines: Color = defaultColors["gridLines"]!
  @AppStorage("markerEdge") var markerEdge: Color = defaultColors["markerEdge"]!
  @AppStorage("markerSegment") var markerSegment: Color = defaultColors["markerSegment"]!
  @AppStorage("spectrum") var spectrum: Color = defaultColors["spectrum"]!
  @AppStorage("spectrumFill") var spectrumFill: Color = defaultColors["spectrumFill"]!
  
  @AppStorage("background") var background: Color = defaultColors["background"]!
  @AppStorage("marker") var marker: Color = defaultColors["marker"]!
  @AppStorage("sliceActive") var sliceActive: Color = defaultColors["sliceActive"]!
  @AppStorage("sliceFilter") var sliceFilter: Color = defaultColors["sliceFilter"]!
  @AppStorage("sliceInactive") var sliceInactive: Color = defaultColors["sliceInactive"]!
  @AppStorage("tnfActive") var tnfActive: Color = defaultColors["tnfActive"]!
  @AppStorage("tnfInactive") var tnfInactive: Color = defaultColors["tnfInactive"]!
  
  
  func resetAll() {
    dbLegend = ColorsView.defaultColors["dbLegend"]!
    dbLines = ColorsView.defaultColors["dbLines"]!
    frequencyLegend = ColorsView.defaultColors["frequencyLegend"]!
    gridLines = ColorsView.defaultColors["gridLines"]!
    markerEdge = ColorsView.defaultColors["markerEdge"]!
    markerSegment = ColorsView.defaultColors["markerSegment"]!
    spectrum = ColorsView.defaultColors["spectrum"]!
    spectrumFill = ColorsView.defaultColors["spectrumFill"]!
    background = ColorsView.defaultColors["background"]!
    marker = ColorsView.defaultColors["marker"]!
    sliceActive = ColorsView.defaultColors["sliceActive"]!
    sliceInactive = ColorsView.defaultColors["sliceInactive"]!
    tnfActive = ColorsView.defaultColors["tnfActive"]!
    tnfInactive = ColorsView.defaultColors["tnfInactive"]!
  }
  
  public var body: some View {
    
    VStack {
      Grid(alignment: .leading, horizontalSpacing: 35, verticalSpacing: 15) {
        GridRow() {
          Text("Spectrum")
          ColorPicker("", selection: $spectrum).labelsHidden()
          Button("Reset") { spectrum = ColorsView.defaultColors["spectrum"]! }
          
          Text("Spectrum Fill")
          ColorPicker("", selection: $spectrumFill).labelsHidden()
          Button("Reset") { spectrumFill = ColorsView.defaultColors["spectrumFill"]! }
        }
        GridRow() {
          Text("Freq Legend")
          ColorPicker("", selection: $frequencyLegend).labelsHidden()
          Button("Reset") { frequencyLegend = ColorsView.defaultColors["frequencyLegend"]! }
          
          Text("Db Legend")
          ColorPicker("", selection: $dbLegend).labelsHidden()
          Button("Reset") { dbLegend = ColorsView.defaultColors["dbLegend"]! }
        }
        GridRow() {
          Text("Grid lines")
          ColorPicker("", selection: $gridLines).labelsHidden()
          Button("Reset") { gridLines = ColorsView.defaultColors["gridLines"]! }
          
          Text("Db lines")
          ColorPicker("", selection: $dbLines).labelsHidden()
          Button("Reset") { dbLines = ColorsView.defaultColors["dbLines"]! }
        }
        GridRow() {
          Text("Marker edge")
          ColorPicker("", selection: $markerEdge).labelsHidden()
          Button("Reset") { markerEdge = ColorsView.defaultColors["markerEdge"]! }
          
          Text("Marker segment")
          ColorPicker("", selection: $markerSegment).labelsHidden()
          Button("Reset") { markerSegment = ColorsView.defaultColors["markerSegment"]! }
        }
        GridRow() {
          Text("Slice filter")
          ColorPicker("", selection: $sliceFilter).labelsHidden()
          Button("Reset") { sliceFilter = ColorsView.defaultColors["sliceFilter"]! }
          
          Text("Marker")
          ColorPicker("", selection: $marker).labelsHidden()
          Button("Reset") { marker = ColorsView.defaultColors["marker"]! }
        }
        GridRow() {
          Text("Tnf (active)")
          ColorPicker("", selection: $tnfActive).labelsHidden()
          Button("Reset") { tnfActive = ColorsView.defaultColors["tnfActive"]! }
          
          Text("Tnf (Inactive)")
          ColorPicker("", selection: $tnfInactive).labelsHidden()
          Button("Reset") { tnfInactive = ColorsView.defaultColors["tnfInactive"]! }
        }
        GridRow() {
          Text("Slice (active)")
          ColorPicker("", selection: $sliceActive).labelsHidden()
          Button("Reset") { sliceActive = ColorsView.defaultColors["sliceActive"]! }
          
          Text("Slice (Inactive)")
          ColorPicker("", selection: $sliceInactive).labelsHidden()
          Button("Reset") { sliceInactive = ColorsView.defaultColors["sliceInactive"]! }
        }
        GridRow() {
          Text("Background")
          ColorPicker("", selection: $background).labelsHidden()
          Button("Reset") { background = ColorsView.defaultColors["background"]! }
        }
      }
      HStack {
        Spacer()
        Button("Reset All") { resetAll() }
      }
    }
  }
}

struct ColorsView_Previews: PreviewProvider {
  static var previews: some View {
    ColorsView(store: Store(
      initialState: ColorsFeature.State(),
      reducer: ColorsFeature())
    )
    .frame(width: 600, height: 350)
    .padding()
  }
}
