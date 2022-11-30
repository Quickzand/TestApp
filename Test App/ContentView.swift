//
//  ContentView.swift
//  Test App
//
//  Created by Matthew Sand on 11/8/22.
//

import SwiftUI


var inventoryListData: [inventoryListRowData] = [
    inventoryListRowData(name: "Scromblies", count: 8),
    inventoryListRowData(name: "Scomboids", count: 8),
    inventoryListRowData(name: "Scrodes", count: 8),
    inventoryListRowData(name: "Pencils", count: 8)
]



struct inventoryListRowData : Identifiable {
    var id = UUID()
    var name : String = "Ya know"
    var count : Int;
}



struct InventoryListRow: View {
    
    var text : String;
    @State var count : Int;
    var body : some View  {
        NavigationLink(destination:InventoryDetail(name:text, count: $count)) {
            HStack {Text(text)
                Spacer()
                Text(String(count))
            }
        }
    }
    
}



struct InventoryDetail : View {
    var name : String = "";
    @Binding var count : Int;
    @State var description: String =  "Scrimblies are a variety of scrimboid with propoteries of both scrimbles and scrombles"
    @State var editMode : Bool = false;
    
    func increaseCount(amt:Int) {
        count += amt;
    }
    
    func decreaseCount(amt: Int) {
        count -= amt
    }
    
    
    
    func handleEditButtonPress() {
        if(editMode) {
            editMode = false;
        }
        else {
            editMode = true;
        }
        
    }
    
    
    var body : some View {
        VStack (){
            Image(decorative: "scrimblies")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack {
                HStack {
                    Text(name).font(.largeTitle).fontWeight(.bold)
                    Spacer()
                    TextField("", value:$count, format:.number)
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth:30)
                    HStack {
                        Button(action:{decreaseCount(amt: 1)}) {
                            Image(systemName: "minus")
                        }
                        .padding(5)
                        Button(action: {increaseCount(amt: 1)}) {
                            Image(systemName: "plus")
                        }
                        .padding(5)
                    }
                    
                    .background(.ultraThinMaterial)
                    
                    
                }
                TextField("Description", text: $description, axis: .vertical).font(.body).padding(5).background(editMode ? Color.secondary : nil).cornerRadius(5)
            }
            .padding([.leading,.trailing],10)
            
            Spacer()
        }.edgesIgnoringSafeArea(.top)
        .frame(  minWidth: 0,
                 maxWidth: .infinity,
                 minHeight: 0,
                 maxHeight: .infinity,
                 alignment: .top)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {handleEditButtonPress()}) {
                    Text(editMode ? "Done" : "Edit" )
                        
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                
                
                
            }
        }
        
        
        
    }
}





enum navLocation {
    case inventory;
    case settings;
}





struct ContentView: View {
    @State var currentScreen : navLocation = .inventory
    
    
    var body: some View {
        VStack {
            switch currentScreen {
            case .settings:
                SettingsView()
            case .inventory:
                HomeView()
            default:
                HomeView()
            }
            Spacer()
            NavBar(currentScreen: $currentScreen)
        } .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
    }
}



struct HomeView : View {
    var body: some View {
        NavigationView {
            List(inventoryListData) { rowData in
                InventoryListRow(text: rowData.name, count: rowData.count)
            }.listStyle(.inset).navigationTitle("Inventory")
        }
            
    }
}


struct SettingsView: View {
    var body : some View {
        Text("TEST")
    }
}




struct NavBar : View {
    
    @Binding var currentScreen : navLocation;
    
    var body : some View {
        HStack(alignment: .center) {
            Spacer()
            NavButton(navText:"Inventory",currentScreen: $currentScreen, location: .inventory)
            Spacer()
            NavButton(navText:"Settings", iconName:"gearshape.fill", currentScreen: $currentScreen, location: .settings)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 10)
        .background()
    }
}





struct NavButton : View {
    var navText: String = "TEST";
    var iconName: String = "bag.fill";
    @Binding var currentScreen : navLocation;
    var location: navLocation = .inventory;
    
    
    func changeToScreen() {
        currentScreen = location;
        Print("Switching to location... ")
    }
    
    
    
    var body: some View {
            Button(action: {changeToScreen()}) {
                
                VStack {
                    Image(systemName: iconName).imageScale(.large)
                        .foregroundColor( currentScreen == location ? .accentColor : .secondary)
                    Text(navText)
                        .foregroundColor(currentScreen == location ? .accentColor : .secondary)
                        .font(.body)
                    
            }
        }
    }
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


