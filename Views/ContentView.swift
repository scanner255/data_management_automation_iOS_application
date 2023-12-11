import SwiftUI

struct ContentView: View {
    @State private var dataCollectionFlag = true

    var body: some View {
        ZStack {
            if dataCollectionFlag {
                StartView(dataCollectionFlag: $dataCollectionFlag)
            } else {
                DataCollectionView(dataCollectionFlag: $dataCollectionFlag)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
