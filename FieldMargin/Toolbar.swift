import SwiftUI

struct PrimaryToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            VStack {
                Text("Agreena Certificates")
                    .font(.title3)
                    .foregroundColor(.white)
            }
        }
    }
}

struct TrailingToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            NavigationLink(destination: FavouritesView()) {
                Image(systemName: "bookmark")
                    .tint(.white)
            }
        }
    }
}
