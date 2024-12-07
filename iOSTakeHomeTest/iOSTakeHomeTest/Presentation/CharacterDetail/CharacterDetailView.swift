//
//  CharacterDetailView.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import SwiftUI

struct CharacterDetailView: View {
    
    let character: CharacterVM
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ZStack(alignment: .topLeading) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 350)
                .cornerRadius(20)
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                }
                .tint(Color.black)
                .frame(width: 40, height: 40)
                .background(Color.white)
                .cornerRadius(20)
                .padding([.top, .leading], 16)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(character.name)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text(character.status)
                        .padding(4)
                        .background(Color.cyan)
                        .cornerRadius(8)
                }
                HStack(spacing: 0) {
                    Text("Gender: ")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                    Text(character.gender)
                        .font(.system(size: 14))
                }
                HStack(spacing: 0) {
                    Text("Species: ")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                    Text(character.species)
                        .font(.system(size: 14))
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

