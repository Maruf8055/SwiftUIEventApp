import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    VStack {
                        Image("Welcome")
                            .resizable()
                            .frame(width:600 ,height: 600)
                            .rotationEffect(.degrees(-20))
                            .aspectRatio(contentMode: .fit)
                            .position(x: 100, y: 630)
                            .opacity(0.9)
                    }
                    
                    VStack {
                       
                     
                        Image("Ball")
                            .resizable()
                            .rotationEffect(.degrees(-20))
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 270)
                            .position(x: 350, y: 100)
                            .opacity(0.85)
                    }
                        
                    VStack {
                        Text("WELCOME!")
                            .font(.system(size: 30))

                            .fontWeight(.bold)
                            .offset(CGSize(width: -50, height: -110))
                            .foregroundColor(.orange)

                        Text("Discover & \(Text("Create").foregroundColor(.green)) Matches")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .offset(CGSize(width: 0, height: -100.0))
                        
                        VStack {
                            NavigationLink(destination: SecondPage()) {
                                Text("Get Started")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(40)
                            }
                        }
                        .offset(y: -70) // Adjust this offset value to lower the VStack as needed
                        
                        
                    }
                }
            }
        
        }
    }
}
//-------------------------------------------------------------
// TextFields for email and password
import SwiftUI

struct SecondPage: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loggedIn = false
    @State private var showFifthPage = false
    
    var body: some View {
        VStack {
            // Add the logo image at the top
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .position(x: 200, y: 100)

                    .padding(.top, 50) // Adjust the padding as needed
            }
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                loggedIn.toggle()
                if loggedIn {
                    showFifthPage = true
                }
            }) {
                Text("Log In")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            NavigationLink(destination: FifthPage(), isActive: $showFifthPage) {
                EmptyView()
            }
            
            Text("Don't have an account?")
                .font(.headline)
                .padding(.top, 20)
            
            NavigationLink(destination: SignUpPage()) {
                Text("Sign Up")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .padding()
            
            Button(action: {
                // Action to login with Gmail
            }) {
                Text("Login with Gmail")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .padding()
            
            Spacer() // Add a spacer to push the content upwards
        }
        
    }
}

//----------------------------------------------------------

struct SignUpPage: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var agreedToPrivacy = false
    
// TextFields for user details
    
    var body: some View {
        VStack {
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Toggle("Accept Privacy Agreement", isOn: $agreedToPrivacy)
                .padding()
            
            Button(action: {
// Action button
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        
    }
}
//----------------------------------------------------------
struct FifthPage: View {
    @State private var quantity = Array(repeating: 0, count: eventData.count)
    @State private var snappedDayOffset = 0
    @State private var draggedDayOffset = Double.zero

    var body: some View {
        NavigationView {
            
            VStack {
                
                CalendarView(snappedDayOffset: $snappedDayOffset, draggedDayOffset: $draggedDayOffset)
                    .padding()
                    .frame(height: 200)

                ScrollView(.vertical, showsIndicators: true) {
                    ForEach(0..<eventData.count, id: \.self) { index in
                        EventCard(event: eventData[index], quantity: self.$quantity[index])
                            .padding(.horizontal)
                    }
                }
                .navigationBarHidden(true)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                
                
// Action for back button
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                    .imageScale(.large)
                    .padding(.vertical)
                
            })
        }
    }
}

//-----------------------------------------------
struct EventCard: View {
    let event: Event
    
    @Binding var quantity: Int
    
    var body: some View {
     
        
        ZStack {
            
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(radius: 5)
                .frame(width: 300, height: 200)

            HStack {
                Image(systemName: event.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    Text(event.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    
                    Text("Location: \(event.location)")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("Time: \(event.time)")
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    Button(action: {
                        quantity += 1
                    }) {
                        Text("Join")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
}
                .padding()
            }}}}
// Event name , Location, time
struct Event {
    let name: String
    let imageName: String
    let location: String
    let time: String
}



let eventData = [
    Event(name: "Event 1", imageName: "", location: "Detroit ", time: "1:00 pm"),
    Event(name: "Event 2", imageName: "", location: "Warren", time: "2:00pm"),
    Event(name: "Event 3", imageName: "", location: "Higlandpark", time: "3:00pm ")
]
//----------------------------------------------------------------------
struct CalendarView: View {
    @Binding var snappedDayOffset: Int
    @Binding var draggedDayOffset: Double

    let nPanels = 7
    let panelSize: CGFloat = 100
    let gapSize: CGFloat = 10

    private var positionWidth: CGFloat {
        panelSize + gapSize
    }

    private func xOffsetForIndex(index: Int) -> Double {
        let midIndex = Double(nPanels / 2)
        var dIndex = (Double(index) - draggedDayOffset - midIndex).truncatingRemainder(dividingBy: Double(nPanels))
        if dIndex < -midIndex {
            dIndex += Double(nPanels)
        } else if dIndex > midIndex {
            dIndex -= Double(nPanels)
        }
        return dIndex * Double(positionWidth)
    }

    private func dateView(index: Int) -> some View {
        ZStack {
            Color.green
                .cornerRadius(10)
        }
        .frame(width: panelSize, height: panelSize)
        .offset(x: xOffsetForIndex(index: index))
    }

    private var dragged: some Gesture {
        DragGesture()
            .onChanged { val in
                draggedDayOffset = Double(snappedDayOffset) - (val.translation.width / Double(positionWidth))
            }
            .onEnded { val in
                snappedDayOffset = Int(Double(snappedDayOffset) - (val.predictedEndTranslation.width / Double(positionWidth)).rounded())
                withAnimation(.easeInOut(duration: 0.15)) {
                    draggedDayOffset = Double(snappedDayOffset)
                }
            }
    }
    
    

    var body: some View {
        GeometryReader { _ in
            ZStack {
                ForEach(0..<nPanels, id: \.self) { index in
                    dateView(index: index)
                }
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
                    .opacity(0.7)
                    .frame(width: positionWidth, height: positionWidth)
            }
            .gesture(dragged)
        }
    }
}


#Preview {
    ContentView()
}
