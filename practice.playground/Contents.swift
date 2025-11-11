
import SwiftUI


struct HomeView: View {
    
    @State var text: String = ""
    @State var inputText: String = ""
    
    var body: some View {
        HStack {
            Text(text)
                .font(.headline)
                .foregroundColor(.black)
            
            TextField("Enter the Text", text: $inputText)
                .frame(height: 50)
                .frame(width: .infinity)
                .foregroundColor(.black)
            
            
            Button {
                
            }label: {
                Text("Submit")
                    .frame(width: 280, height: 50)
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal)
    }
}
