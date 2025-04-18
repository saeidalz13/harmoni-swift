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
    @State private var showCookiePopover = false
    @State private var showOopsiePopover = false
    
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
            RomanticHeaderInContainerView(header: "🍃 \(chapter.title)")
            
            HStack(spacing: 40) {
                SummaryMomentView(num: cookiesNum, momentTag: .cookie)
                    .onTapGesture {
                        showCookiePopover = true
                    }
                    // TODO: increase the length of the entire

                SummaryMomentView(num: oopsiesNum, momentTag: .oopsie)
                    .onTapGesture {
                        showOopsiePopover = true
                    }
                
            }
            .padding(.vertical, 10)
        }
    }
}
