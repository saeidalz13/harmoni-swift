//
//  BrandNewUserHomeView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//

import SwiftUI

struct PageContent: Identifiable {
    let id = UUID()
    let view: AnyView
    
    init<V: View>(_ view: V) {
        self.view = AnyView(view)
    }
}

struct FirstTimeUserHomeView: View {
    private var pages: [PageContent]
    @State private var currentPageIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    @State private var animating: Bool = false
    @State private var animationCompleted: Bool = false
    
    // State variables for your pages
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var birthday: Date = Date()
    @State private var newBondTitle: String = ""
    @State private var bondIdToJoin: String = ""
    
    // Screen width for calculations
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    init() {
        self.pages = []
    }
    
    // Pages are computed to ensure they always use the latest state values
    private var pageContents: [PageContent] {
        [
            PageContent(PageOneView()),
            PageContent(
                PageTwoView(
                    firstName: $firstName,
                    lastName: $lastName,
                    birthday: $birthday
                )
            ),
            PageContent(
                PageThreeView(
                    newBondTitle: $newBondTitle,
                    bondIdToJoin: $bondIdToJoin
                )
            )
        ]
    }
    
    var body: some View {
        let pages = pageContents
        
        ZStack {
            RomanticContainer(backgroundColor: .white.opacity(0.4)) {
                ZStack {
                    // Current page
                    pages[currentPageIndex].view
                        .offset(x: dragOffset)
                        .zIndex(1)
                    
                    // Next page (if available)
                    if currentPageIndex < pages.count - 1 {
                        pages[currentPageIndex + 1].view
                            .offset(x: screenWidth + dragOffset)
                            .rotation3DEffect(
                                .degrees(-min(90, -dragOffset / (screenWidth * 90) )),
                                axis: (x: 0, y: 1, z: 0),
                                anchor: .trailing
                            )
                            .zIndex(0)
                    }
                    
                    // Previous page (if available)
                    if currentPageIndex > 0 {
                        pages[currentPageIndex - 1].view
                            .offset(x: -screenWidth + dragOffset)
                            .rotation3DEffect(
                                .degrees(min(90, dragOffset / (screenWidth * 90) )),
                                axis: (x: 0, y: 1, z: 0),
                                anchor: .leading
                            )
                            .zIndex(0)
                    }
                }
            }
            .background(BackgroundView(selection: .auth))
            .ignoresSafeArea()
            .opacity(animationCompleted ? 1 : 0)
            
        }
        .onAppear {
            withAnimation(.linear(duration: 0.5)) {
                animationCompleted = true
            }
        }
        .onDisappear {
            animationCompleted = false
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if !animating {
                        // Limit dragging based on available pages
                        if currentPageIndex == 0 && gesture.translation.width > 0 {
                            // First page - limit right swipe
                            dragOffset = gesture.translation.width / 3
                        } else if currentPageIndex == pages.count - 1 && gesture.translation.width < 0 {
                            // Last page - limit left swipe
                            dragOffset = gesture.translation.width / 3
                        } else {
                            dragOffset = gesture.translation.width
                        }
                    }
                }
                .onEnded { gesture in
                    let threshold: CGFloat = screenWidth * 0.3
                    animating = true
                    
                    if gesture.translation.width > threshold && currentPageIndex > 0 {
                        // Swipe right - go to previous page
                        withAnimation(.easeInOut(duration: 0.3)) {
                            dragOffset = screenWidth
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            currentPageIndex -= 1
                            dragOffset = 0
                            animating = false
                        }
                    } else if gesture.translation.width < -threshold && currentPageIndex < pages.count - 1 {
                        // Swipe left - go to next page
                        withAnimation(.easeInOut(duration: 0.3)) {
                            dragOffset = -screenWidth
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            currentPageIndex += 1
                            dragOffset = 0
                            animating = false
                        }
                    } else {
                        // Return to current page
                        withAnimation(.easeInOut(duration: 0.3)) {
                            dragOffset = 0
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            animating = false
                        }
                    }
                }
        )
    }
    
    // Helper method to get the view at a specific index
    private func pageView(at index: Int) -> some View {
        pages[index].view
    }
    
    // Public method to programmatically navigate to a specific page
    func goToPage(_ index: Int) {
        guard index >= 0 && index < pages.count && !animating else { return }
        
        let direction: CGFloat = index > currentPageIndex ? -1 : 1
        animating = true
        
        withAnimation(.easeInOut(duration: 0.3)) {
            dragOffset = screenWidth * direction
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            currentPageIndex = index
            dragOffset = 0
            animating = false
        }
    }
    
    // Public method to navigate to the next page if available
    func nextPage() {
        if currentPageIndex < pages.count - 1 {
            goToPage(currentPageIndex + 1)
        }
    }
    
    // Public method to navigate to the previous page if available
    func previousPage() {
        if currentPageIndex > 0 {
            goToPage(currentPageIndex - 1)
        }
    }
}

struct PageOneView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome 🍃")
                .font(.custom("Zapfino", size: 28))
                .foregroundStyle(.black.opacity(0.75))
                .multilineTextAlignment(.center)
                .padding(.top, 45)
            
            ZStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundStyle(Color.pink.opacity(0.7))
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color.softPink)
                    .offset(x: 30, y: 10)
            }
            .padding(.vertical, 30)
            
            Text("Sync your hearts, build memories, and strengthen your connection")
                .font(.avenirBold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            
            Text("Swipe to begin →")
                .font(.avenirCaption)
                .italic()
                .padding(.top, 100)
        }
        .padding()
    }
}

struct PageTwoView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var birthday: Date
    
    var body: some View {
        VStack {
            IntroPageTwoView()
            
            RomanticTextField(
                fieldText: "First Name",
                varToEdit: $firstName
            )
            .padding(.bottom, 15)
            
            RomanticTextField(
                fieldText: "Last Name",
                varToEdit: $lastName
            )
            .padding(.bottom, 25)
            
            RomanticCalendarView(fieldText: "Select Birthday", selectedDate: $birthday)
            
            if birthday != Date.distantPast {
                Text("Selected birthday: \(birthday, formatter: birthdayFormatter)")
                    .padding()
                    .font(.avenirCaption)
            }
            
            Text("← Swipe to Continue Or Go Back →")
                .font(.avenirCaption)
                .italic()
                .padding(.top, 50)
        }
    }
    
    private var birthdayFormatter: DateFormatter {
         let formatter = DateFormatter()
         formatter.dateStyle = .long
         return formatter
     }
}

struct PageThreeView: View {
    @Binding var newBondTitle: String
    @Binding var bondIdToJoin: String
    
    var body: some View {
        VStack {
            IntroPageThreeView()
                .padding(.vertical)
                .padding(.bottom, 15)
            
            RomanticTextFieldWithButtonView(
                fieldText: "Title of Your Bond",
                buttonText: "Create Bond",
                varToEdit: $newBondTitle,
                systemImage: "plus.circle.fill"
            ) {
                //                    Task {
                //                        try await localUserViewModel.createBond(bondTitle: newBondTitle)
                //                    }
            }
            
            Text("OR")
                .font(.avenirBold)
                .padding(.vertical, 20)

            
            RomanticTextFieldWithButtonView(
                fieldText: "Bond ID (from partner)",
                buttonText: "Join",
                varToEdit: $bondIdToJoin,
                systemImage: "heart.fill"
            ) {
                //                    Task {
                //                        try await localUserViewModel.joinBond(bondId: bondIdToJoin)
                //                    }
            }

            
            Text("← Swipe to Go Back")
                .font(.avenirCaption)
                .italic()
                .padding(.top, 80)
        }

    }
}

struct IntroPageTwoView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "books.vertical.fill")
                .font(.system(size: 50))
                .foregroundColor(.softPink)
            
            Text("Personal Info")
                .font(.system(size: 24, weight: .bold))
            
            Text("For book keeping purposes, we need to grab some info real quick!")
                .font(.avenirBody)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

struct IntroPageThreeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.softPink)
            
            Text("Begin Your Journey Together")
                .font(.avenirTitle)
            
            Text("Every great love story starts with a single step. Create a new bond with someone special or join an existing one to start capturing moments, deepening your connection, and growing together.")
                .font(.avenirBody)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        
    }
}



//            Button {
//                authViewModel.logOutBackend()
//
//            } label: {
//                RomanticLabelView(isLoading: $isLoading, text: "Log Out")
//            }





//struct NotebookBackgroundView: View {
//    var body: some View {
//        ZStack {
//            // Paper texture background
//            Color.white.opacity(0.9)
//            
//            // Notebook line pattern
//            VStack(spacing: 18) {
//                ForEach(0..<30, id: \.self) { _ in
//                    Rectangle()
//                        .fill(Color.blue.opacity(0.2))
//                        .frame(height: 1)
//                }
//            }
//            
//            // Left side binding
//            HStack {
//                ZStack {
//                    Rectangle()
//                        .fill(Color.brown.opacity(0.6))
//                        .frame(width: 30)
//                    
//                    VStack(spacing: 20) {
//                        ForEach(0..<10, id: \.self) { _ in
//                            Circle()
//                                .fill(Color.white.opacity(0.7))
//                                .frame(width: 12, height: 12)
//                        }
//                    }
//                }
//                Spacer()
//            }
//        }
//        .ignoresSafeArea()
//    }
//}
//
//struct NotebookPageHeaderView: View {
//    let title: String
//    
//    var body: some View {
//        VStack(spacing: 8) {
//            Text(title)
//                .font(.custom("Noteworthy-Bold", size: 28))
//                .foregroundColor(.primary.opacity(0.8))
//            
//            // Decorative underline
//            Rectangle()
//                .fill(
//                    LinearGradient(
//                        colors: [.clear, .brown.opacity(0.6), .brown.opacity(0.6), .clear],
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    )
//                )
//                .frame(height: 2)
//                .padding(.horizontal, 30)
//        }
//        .padding(.top, 30)
//    }
//}
//
//struct NotebookSectionView<Content: View>: View {
//    let title: String
//    let content: Content
//    
//    init(title: String, @ViewBuilder content: () -> Content) {
//        self.title = title
//        self.content = content()
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text(title)
//                .font(.custom("Noteworthy-Bold", size: 20))
//                .foregroundColor(.primary.opacity(0.8))
//                .padding(.leading, 40)
//            
//            content
//                .padding(.vertical, 10)
//                .background(
//                    RoundedRectangle(cornerRadius: 12)
//                        .fill(Color.white.opacity(0.7))
//                        .shadow(color: .black.opacity(0.1), radius: 3, x: 2, y: 2)
//                )
//        }
//    }
//}
//
//struct NotebookButtonView: View {
//    @Binding var isLoading: Bool
//    let text: String
//    let systemImage: String
//    
//    var body: some View {
//        HStack {
//            if isLoading {
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle())
//            } else {
//                Image(systemName: systemImage)
//                    .font(.headline)
//            }
//            
//            Text(text)
//                .font(.custom("Noteworthy", size: 16))
//                .fontWeight(.medium)
//        }
//        .foregroundColor(.white)
//        .padding(.horizontal, 20)
//        .padding(.vertical, 12)
//        .background(
//            LinearGradient(
//                colors: [Color.brown.opacity(0.7), Color.brown.opacity(0.9)],
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//        )
//        .cornerRadius(18)
//        .overlay(
//            RoundedRectangle(cornerRadius: 18)
//                .stroke(Color.brown.opacity(0.5), lineWidth: 1)
//        )
//        .shadow(color: .black.opacity(0.2), radius: 3, x: 1, y: 2)
//    }
//}
//
//struct PaperTearDividerView: View {
//    var body: some View {
//        ZigZagLine()
//            .stroke(Color.gray.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
//            .frame(height: 10)
//            .padding(.horizontal)
//    }
//    
//    struct ZigZagLine: Shape {
//        func path(in rect: CGRect) -> Path {
//            var path = Path()
//            let width = rect.width
//            let height = rect.height
//            let segmentWidth: CGFloat = 10
//            
//            path.move(to: CGPoint(x: 0, y: height / 2))
//            
//            var currentX: CGFloat = 0
//            var goingUp = true
//            
//            while currentX < width {
//                let nextX = min(currentX + segmentWidth, width)
//                let nextY = goingUp ? 0 : height
//                
//                path.addLine(to: CGPoint(x: nextX, y: nextY))
//                
//                currentX = nextX
//                goingUp.toggle()
//            }
//            
//            return path
//        }
//    }
//}
