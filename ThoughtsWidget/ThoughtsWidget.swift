//
//  ThoughtsWidget.swift
//  ThoughtsWidget
//
//  Created by Hilmy Veradin on 26/04/22.
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

struct ThoughtsWidgetEntryView : View {
  var entry: Provider.Entry
  private static let deeplinkURL: URL = URL(string: "widget-deeplink://")!
  
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
    .widgetURL(ThoughtsWidgetEntryView.deeplinkURL)
  }
}

@main
struct ThoughtsWidget: Widget {
  let kind: String = "ThoughtsWidget"
  
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      ThoughtsWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Thoughts")
    .description("Add your thoughts immediately")
  }
}

struct ThoughtsWidget_Previews: PreviewProvider {
  static var previews: some View {
    ThoughtsWidgetEntryView(entry: SimpleEntry(date: Date()))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
