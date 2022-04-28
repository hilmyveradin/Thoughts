//
//  DigitalThoughts.swift
//  DigitalThoughts
//
//  Created by Hilmy Veradin on 28/04/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date())
  }
  
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date())
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    
    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = SimpleEntry(date: entryDate)
      entries.append(entry)
    }
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
}

struct DigitalThoughtsEntryView : View {
  var entry: Provider.Entry
  private static let deeplinkURL: URL = URL(string: "thoughts-deeplink://")!
  
  var body: some View {
    ZStack{
      Color(UIColor.systemGray5).edgesIgnoringSafeArea(.all)
      VStack(spacing:15) {
        Text("Add Thoughts")
          .font(Font.custom("Montserrat-Bold", size: 18))
        
        Image(systemName: "plus")
          .resizable()
          .frame(width: 30, height: 30, alignment: .center)
          .foregroundColor(.white)
          .padding()
          .accentColor(.white)
          .background(
            RoundedRectangle(
              cornerRadius: 30,
              style: .continuous
            )
            .fill(Color(UIColor.darkGray))
          )
      }
    }
    .widgetURL(DigitalThoughtsEntryView.deeplinkURL)
  }
}

@main
struct DigitalThoughts: Widget {
  let kind: String = "ABC"
  
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      DigitalThoughtsEntryView(entry: entry)
    }
    .configurationDisplayName("oooo")
    .description("This is an example widget.")
  }
}

struct DigitalThoughts_Previews: PreviewProvider {
  static var previews: some View {
    DigitalThoughtsEntryView(entry: SimpleEntry(date: Date()))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
