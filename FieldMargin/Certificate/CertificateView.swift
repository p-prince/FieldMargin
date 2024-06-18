import SwiftUI

struct CertificateView: View {
    @StateObject private var viewModel: CertificateViewModel

      init(certificate: Certificate) {
          _viewModel = StateObject(wrappedValue: CertificateViewModel(certificate: certificate, favouritesStore: FavouritesStore()))
      }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("UNIQUE ID:")
                        .font(.headline)
                    Text("\(viewModel.certificate.id)")
                        .font(.body)
                        .lineLimit(1)
                        .truncationMode(.middle)
                }
                Spacer()
                
                Button(action: {
                    viewModel.toggleFavourite()
                }) {
                    viewModel.buttonImage
                        .foregroundColor(.blue)
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("ORIGINATOR:")
                    .font(.headline)
                
                HStack {
                    Text("\(viewModel.certificate.originator)")
                        .font(.body)
                    Text("\(viewModel.certificate.originatorCountry)")
                        .font(.body)
                        .bold()
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("OWNER:")
                    .font(.headline)
                HStack {
                    Text("\(viewModel.certificate.owner)")
                        .font(.body)
                    Text("\(viewModel.certificate.ownerCountry)")
                        .font(.body)
                        .bold()
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("STATUS:")
                    .font(.headline)
                Text("\(viewModel.certificate.status)")
                    .font(.body)
            }
        }
        .padding()
        .background(Color(red: 240 / 255, green: 245 / 255, blue: 245 / 255))
        .cornerRadius(10)
        .shadow(radius: 3)
        .onAppear {
            viewModel.refresh()
        }
    }
}


struct CertificateView_Previews: PreviewProvider {

    static var previews: some View {
        let certificate = Certificate(id: "123", originator: "Prince", originatorCountry: "Italy", owner: "Debest", ownerCountry: "Nigeria", status: "alive")
        CertificateView(certificate: certificate)
    }

}
