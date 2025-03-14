//
//  RelationshipSummaryWithDataView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-07.
//
import SwiftUI

struct RelationshipSummaryWithDataView: View {
    @State var chapter: Chapter
    @State var moments: [Moment]
    
    @State private var cookiesNum: Int
    @State private var oopsiesNum: Int
    
    init(chapter: Chapter, moments: [Moment]) {
        self.chapter = chapter
        self.moments = moments
        
        var (cn, on) = (0, 0)
        for moment in moments {
            if moment.tag == MomentTag.cookie.rawValue {
                cn += 1
            } else {
                on += 1
            }
        }
        
        self._cookiesNum = State(initialValue: cn)
        self._oopsiesNum = State(initialValue: on)
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Relationship Summary")
                .font(.headline)
            
            Divider()
            
            HStack {
                Text("🍃 \(chapter.title)")
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.7))
            }
            .padding(.top, 5)
            
            HStack(spacing: 30) {
                VStack {
                    Text("🍪")
                        .font(.system(size: 20))
                    
                    Text("\(cookiesNum)")
                        .font(.title2)
                        .fontWeight(.bold)
                }

                VStack {
                    Text("🫢")
                        .font(.system(size: 20))
                    
                    Text("\(oopsiesNum)")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .padding(.vertical, 5)
        }
    }
}
