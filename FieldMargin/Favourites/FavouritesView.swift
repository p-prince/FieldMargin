import SwiftUI

struct FavouritesView: View {
    
    @StateObject private var viewModel = FavouritesViewModel()

    var body: some View {
        content
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                PrimaryToolbar()
            }
            .toolbarBackground(Color.toolbarBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private var content: some View {
        if viewModel.certificates.isEmpty {
            return AnyView(emptyStateView)
        } else {
            return AnyView(listView)
        }
    }

    private var emptyStateView: some View {
        return Text("No certificates available")
            .foregroundColor(.gray)
            .padding()
    }
    
    private var listView: some View {
        List(viewModel.certificates, id: \.id) { certificate in
            CertificateView(certificate: certificate)
                .listRowSeparator(.hidden)
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    FavouritesView()
}
