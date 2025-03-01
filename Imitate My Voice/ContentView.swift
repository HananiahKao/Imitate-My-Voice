//
//  ContentView.swift
//  Imitate My Voice
//
//  Created by Hananiah on 2025/2/28.
//

import SwiftUI
import SwiftData
import AVFoundation

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var isRecording = true
    @State var audioFileURL: URL?
    var body: some View {
        if isRecording {
            RecordView()
                .padding(.all, 50)
                .onAppear() {
                    let manager = AudioManager()
                    manager.startRecording()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        manager.stopRecording()
                        //isRecording = false
                        audioFileURL = manager.audioFileURL!
                        manager.playRecordedAudio()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
