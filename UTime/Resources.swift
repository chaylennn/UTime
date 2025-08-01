// //
// //  Resources.swift
// //  UTime
// //
// //  Created by anvi mishra on 7/29/25.
// //importing UI and the library for links
// import SwiftUI
// import SafariServices
// struct Resources: View {
//     var body: some View{
//         Text("Hello World please dont delete again")
//     }
// }
//     #Preview {
//         Resources()
//     }

//
//  Resources.swift
//  UTime
//
//  Created by anvi mishra on 7/30/25.

import SwiftUI
import SafariServices

struct ResourceItem: Identifiable {
    let id = UUID()
    let title: String
    let url: String
    let thumbAsset: String   // name of the image in Assets
    let aspect: CGFloat // used for sizing the thumbnail images
}


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red:   Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >>  8) & 0xFF) / 255,
            blue:  Double( hex        & 0xFF) / 255,
            opacity: alpha
        )
    }

    static let appBrown  = Color(hex: 0x9F7D55)
    static let appCream  = Color(hex: 0xFCF7EA)
    static let appGreen  = Color(hex: 0x7A8F5C)
}

struct Resources: View {
    private let motivationLinks: [ResourceItem] = [
        .init(title: "Unmotivated? The SECRET to study hard NO MATTER WHAT",
              url: "https://www.youtube.com/watch?v=2V4IsA9fWfU",
              thumbAsset: "motivationvid1",
             aspect: 16/9),

        .init(title: "One of the Greatest Speeches Ever | Steve Jobs",
              url: "https://www.youtube.com/watch?v=Tuw8hxrFBH8",
              thumbAsset: "motivationvid2",
             aspect: 16/9),
                
        
        .init(title: "If you're ambitious but lazy, please watch this...",
              url: "https://www.youtube.com/watch?v=shIMKfY72o0",
              thumbAsset: "motivationvid3",
             aspect: 16/9),
    ]

    private let musicLinks: [ResourceItem] = [
        .init(title: "Butterflies",
              url: "https://open.spotify.com/track/6mCljAhAwsKTCsdaA0tIYF?si=a4680dd4625c4fc1",
              thumbAsset: "musicvid1",
             aspect: 1),

        .init(title: "pink pony club (chill piano instrumental)",
              url: "https://open.spotify.com/track/4zN0hSKWFlBHYh0amWtvLh?si=6a994e83a12d4cd4",
              thumbAsset: "musicvid2",
             aspect: 1),

        .init(title: "Blue Cove",
              url: "https://open.spotify.com/track/2nXhnRmxRNtlNzvZogGJPz?si=7aec53f556c04eff",
              thumbAsset: "musicvid3",
             aspect: 1),
        
    ]

    private let backgroundMusicLinks: [ResourceItem] = [
        .init(title: "Lofty Library 📚｜Soothing and Relaxing Jazz + Rain Sounds｜Study & Work Music｜Animal Crossing Ambience",
              url: "https://www.youtube.com/watch?v=phRZKH1tQsQ&list=RDphRZKH1tQsQ&start_radio=1",
              thumbAsset: "backgroundNoiseVid1",
             aspect: 16/9),

        .init(title: "3 Hours of Gentle Night Rain, Rain Sounds for Sleeping - Dark Screen to Beat insomnia, Relax, Study",
              url: "https://www.youtube.com/watch?v=q76bMs-NwRk",
              thumbAsset: "backgroundNoiseVid2",
             aspect: 16/9),

        .init(title: "(No Ads) 10 Hours of Soft White Noise | Black Screen for Sleep",
              url: "https://www.youtube.com/watch?v=Og40mpl8VNc",
              thumbAsset: "backgroundNoiseVid3",
             aspect: 16/9),
    ]

    @State private var openMotivation      = false
    @State private var openMusic           = false
    @State private var openBackgroundMusic = false

    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    disclosurePanel(title: "Motivation",
                                    systemImage: "sparkles",
                                    items: motivationLinks,
                                    isExpanded: $openMotivation)

                    disclosurePanel(title: "Music",
                                    systemImage: "music.note",
                                    items: musicLinks,
                                    isExpanded: $openMusic)

                    disclosurePanel(title: "Background",
                                    systemImage: "music.quarternote.3",
                                    items: backgroundMusicLinks,
                                    isExpanded: $openBackgroundMusic)
                }
                .padding()
            }
            .navigationTitle("Resources")
}
    

    @ViewBuilder
    private func disclosurePanel(title: String,
                                 systemImage: String,
                                 items: [ResourceItem],
                                 isExpanded: Binding<Bool>) -> some View {

        DisclosureGroup(isExpanded: isExpanded) {
            // content: list of links
            VStack(alignment: .leading, spacing: 8) {
                ForEach(items) { item in
                    Link(destination: URL(string: item.url)!) {
                        resourceCard(item)
                    }
                }
            }
            .padding(.top, 4)
        } label: {
            Label(title, systemImage: systemImage)
                .font(.headline)
                .foregroundColor(.appGreen)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.appCream)
        )
        .animation(.easeInOut, value: isExpanded.wrappedValue)   // smooth open/close
    }

    // MARK: – Thumbnail + title
    @ViewBuilder
    private func resourceCard(_ item: ResourceItem) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack {
                Color.appCream  // subtle surround
                Image(item.thumbAsset)
                    .resizable()
                    .aspectRatio(item.aspect, contentMode: .fit)
            }
            .cornerRadius(8)

            Text(item.title)
                .font(.system(.headline, design: .rounded))   // friendlier font
                .fontWeight(.semibold)
                .foregroundColor(.black)// a touch bolder
                .lineLimit(2)
                .lineSpacing(2)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.ultraThinMaterial, in: Capsule())// frosted pill
                .shadow(color: .black.opacity(0.15), radius: 1, y: 1)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.appCream)
        )
    }
}

#Preview {
    NavigationStack {
        Resources()
    }
}
              
