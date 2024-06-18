import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel(networkManager: NetworkManager())
    
    var body: some View {
        NavigationStack {
            List(viewModel.certificates, id: \.id) { certificate in
                CertificateView(certificate: certificate)
                    .listRowSeparator(.hidden)
            }
            .onAppear {
                fetchInitialData()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                PrimaryToolbar()
                TrailingToolbar()
            }
            .toolbarBackground(Color.toolbarBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.alertMessage),
                    primaryButton: .default(Text("Retry")) {
                        fetchInitialData()
                    },
                    secondaryButton: .default(Text("OK"))
                )
                
            }
            .scrollContentBackground(.hidden)
        }
    }
    
    private func fetchInitialData() {
        viewModel.fetchCertificates(limit: 5, page: 1)
    }
}

#Preview {
    ContentView()
}
