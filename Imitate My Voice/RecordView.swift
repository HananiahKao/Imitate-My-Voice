//
//  SwiftUIView.swift
//  Imitate My Voice
//
//  Created by Hananiah on 2025/2/28.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        VStack {
            Image(systemName: "mic")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.red)
                .frame(width: 100, height: 100)
                .bold()
            Text("Say something, I am listening...")
                .font(.largeTitle)
        }
    }
}

#Preview {
    RecordView()
}
