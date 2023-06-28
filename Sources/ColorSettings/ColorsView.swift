//
//  ColorsView.swift
//  ViewFeatures/SettingsFeature/Colors
//
//  Created by Douglas Adams on 5/13/21.
//

import ComposableArchitecture
import SwiftUI

import Shared

public struct ColorsView: View {
  let store: StoreOf<ColorsFeature>
  
  public init(store: StoreOf<ColorsFeature>) {
    self.store = store
  }
  
  @AppStorage("backgroundColor") var backgroundColor = DefaultColors.backgroundColor
  @AppStorage("dbLegendColor") var dbLegendColor = DefaultColors.dbLegendColor
  @AppStorage("dbLinesColor") var dbLinesColor = DefaultColors.dbLinesColor
  @AppStorage("frequencyLegendColor") var frequencyLegendColor = DefaultColors.frequencyLegendColor
  @AppStorage("gridLinesColor") var gridLinesColor = DefaultColors.gridLinesColor
  @AppStorage("markerColor") var markerColor = DefaultColors.markerColor
  @AppStorage("markerEdgeColor") var markerEdgeColor = DefaultColors.markerEdgeColor
  @AppStorage("markerSegmentColor") var markerSegmentColor = DefaultColors.markerSegmentColor
  @AppStorage("sliceActiveColor") var sliceActiveColor = DefaultColors.sliceActiveColor
  @AppStorage("sliceFilterColor") var sliceFilterColor = DefaultColors.sliceFilterColor
  @AppStorage("sliceInactiveColor") var sliceInactiveColor = DefaultColors.sliceInactiveColor
  @AppStorage("spectrumColor") var spectrumColor = DefaultColors.spectrumColor
  @AppStorage("spectrumFillColor") var spectrumFillColor = DefaultColors.spectrumFillColor
  @AppStorage("tnfDeepColor") var tnfDeepColor = DefaultColors.tnfDeepColor
  @AppStorage("tnfInactiveColor") var tnfInactiveColor = DefaultColors.tnfInactiveColor
  @AppStorage("tnfNormalColor") var tnfNormalColor = DefaultColors.tnfNormalColor
  @AppStorage("tnfPermanentColor") var tnfPermanentColor = DefaultColors.tnfPermanentColor
  @AppStorage("tnfVeryDeepColor") var tnfVeryDeepColor = DefaultColors.tnfVeryDeepColor

  public var body: some View {
    
    VStack {
      Grid(alignment: .leading, horizontalSpacing: 35, verticalSpacing: 15) {
        GridRow() {
          Text("Spectrum")
          ColorPicker("", selection: $spectrumColor).labelsHidden()
          Button("Reset") { spectrumColor = DefaultColors.spectrumColor }
          
          Text("Spectrum Fill")
          ColorPicker("", selection: $spectrumFillColor).labelsHidden()
            Button("Reset") { spectrumFillColor = DefaultColors.spectrumFillColor }
        }
        GridRow() {
          Text("Freq Legend")
          ColorPicker("", selection: $frequencyLegendColor).labelsHidden()
          Button("Reset") { frequencyLegendColor = DefaultColors.frequencyLegendColor }
          
          Text("Db Legend")
          ColorPicker("", selection: $dbLegendColor).labelsHidden()
            Button("Reset") { dbLegendColor = DefaultColors.dbLegendColor }
        }
        GridRow() {
          Text("Grid lines")
          ColorPicker("", selection: $gridLinesColor).labelsHidden()
          Button("Reset") { gridLinesColor = DefaultColors.gridLinesColor }
          
          Text("Db lines")
          ColorPicker("", selection: $dbLinesColor).labelsHidden()
            Button("Reset") { dbLinesColor = DefaultColors.dbLinesColor }
        }
        GridRow() {
          Text("Marker edge")
          ColorPicker("", selection: $markerEdgeColor).labelsHidden()
          Button("Reset") { markerEdgeColor = DefaultColors.markerEdgeColor }
          
          Text("Marker segment")
          ColorPicker("", selection: $markerSegmentColor).labelsHidden()
            Button("Reset") { markerSegmentColor = DefaultColors.markerSegmentColor }
        }
        GridRow() {
          Text("Slice filter")
          ColorPicker("", selection: $sliceFilterColor).labelsHidden()
          Button("Reset") { sliceFilterColor = DefaultColors.sliceFilterColor }
          
          Text("Marker")
          ColorPicker("", selection: $markerColor).labelsHidden()
            Button("Reset") { markerColor = DefaultColors.markerColor }
        }
        GridRow() {
          Text("Tnf (Inactive)")
          ColorPicker("", selection: $tnfInactiveColor).labelsHidden()
            Button("Reset") { tnfInactiveColor = DefaultColors.tnfInactiveColor }

          Text("Tnf (normal)")
          ColorPicker("", selection: $tnfNormalColor).labelsHidden()
          Button("Reset") { tnfNormalColor = DefaultColors.tnfNormalColor }
        }
        GridRow() {
          Text("Tnf (deep)")
          ColorPicker("", selection: $tnfDeepColor).labelsHidden()
            Button("Reset") { tnfDeepColor = DefaultColors.tnfDeepColor }

          Text("Tnf (very deep)")
          ColorPicker("", selection: $tnfVeryDeepColor).labelsHidden()
          Button("Reset") { tnfVeryDeepColor = DefaultColors.tnfVeryDeepColor }
        }
        GridRow() {
          Text("Tnf (permanent)")
          ColorPicker("", selection: $tnfPermanentColor).labelsHidden()
            Button("Reset") { tnfPermanentColor = DefaultColors.tnfPermanentColor }

          Text("Background")
          ColorPicker("", selection: $backgroundColor).labelsHidden()
          Button("Reset") { backgroundColor = DefaultColors.backgroundColor }
        }
        GridRow() {
          Text("Slice (active)")
          ColorPicker("", selection: $sliceActiveColor).labelsHidden()
          Button("Reset") { sliceActiveColor = DefaultColors.sliceActiveColor }
          
          Text("Slice (Inactive)")
          ColorPicker("", selection: $sliceInactiveColor).labelsHidden()
            Button("Reset") { sliceInactiveColor = DefaultColors.sliceInactiveColor }
        }
      }
      Divider().background(Color.blue)
      HStack {
        Spacer()
        Button("Reset All") { resetAll() }
        Spacer()
      }
    }
  }
  
  func resetAll() {
    backgroundColor = DefaultColors.backgroundColor
    dbLegendColor = DefaultColors.dbLegendColor
    dbLinesColor = DefaultColors.dbLinesColor
    frequencyLegendColor = DefaultColors.frequencyLegendColor
    gridLinesColor = DefaultColors.gridLinesColor
    markerColor = DefaultColors.markerColor
    markerEdgeColor = DefaultColors.markerEdgeColor
    markerSegmentColor = DefaultColors.markerSegmentColor
    sliceActiveColor = DefaultColors.sliceActiveColor
    sliceFilterColor = DefaultColors.sliceFilterColor
    sliceInactiveColor = DefaultColors.sliceInactiveColor
    spectrumColor = DefaultColors.spectrumColor
    spectrumFillColor = DefaultColors.spectrumFillColor
    tnfDeepColor = DefaultColors.tnfDeepColor
    tnfInactiveColor = DefaultColors.tnfInactiveColor
    tnfNormalColor = DefaultColors.tnfNormalColor
    tnfPermanentColor = DefaultColors.tnfPermanentColor
    tnfVeryDeepColor = DefaultColors.tnfVeryDeepColor
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
