//
//  ChatView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-10.
//
import SwiftUI

struct ChatMenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var message: String = ""
    @FocusState private var isTextFieldFocused: Bool
    
    @State private var localUserMessages: [String]
    
    init() {
        self._localUserMessages = State(initialValue: [])
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Chat Menu")
                    .font(.title)
                    .padding()
                Spacer()
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundStyle(Color.maroon)
            }
            
            HStack {
//                ForEach(localUserMessages, id: \.self) { message in
//                    MessageView(text :message)
//                }
                Text("Check back in next updates!")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(.gray.opacity(0.1))
            .cornerRadius(20)
            
//            Spacer()
//            
//            HStack {
//                TextField("Start Message", text: $message)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .focused($isTextFieldFocused)
//                    .shadow(color: Color.maroon, radius: 2)
//                
//                Button(action: sendMessage) {
//                    Image(systemName: "paperplane.fill")
//                        .padding(8)
//                        .background(Color.maroon)
//                        .foregroundColor(.white)
//                        .clipShape(Circle())
//                }
//                .disabled(message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
//            }
//            .padding()
//            .frame(alignment: .bottom)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
    }
    
//    private func sendMessage() {
//        guard !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
//        localUserMessages.append(message)
//        message = ""
//    }
}

//struct MessageView: View {
//    let text: String
//    
//    var body: some View {
//        HStack {
//            Text(text)
//        }
//    }
//}
