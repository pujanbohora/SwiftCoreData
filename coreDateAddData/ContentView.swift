//
//  ContentView.swift
//  coreDateAddData
//
//  Created by Pawan Bohora on 7/8/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProgrammingLanguage.creater, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ProgrammingLanguage>
    
    @State private var showAlert = false
    @State private var creator = ""
    @State private var name = ""

    var body: some View {
        
        
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
        
                NavigationView {
                    List {
                        ForEach(items) { item in
                            NavigationLink {
                                Text("Item at \(item.creater!)")
                            } label: {
                                Text(item.name!)
                            }
                        }
//                        .onDelete(perform: deleteItems)
                    }

                    .toolbar {
                      ToolbarItem {
                        Button {
                          showAlert = true
                        } label: {
                          Label("Add Item", systemImage: "plus")
                        }
                      }
                    }
                    .alert("Login", isPresented: $showAlert) {
                        VStack {
                                TextField("Creator", text: $creator)
                                .padding(.bottom, 10)
                                
                            TextField("Name", text: $name)
                            Button("Save") {
                                addItem()
                                        }
                            }
                        .padding()
                            
                    }
                    Text("Select an item")
                }
    }

    private func addItem() {
        withAnimation {
            let newItem = ProgrammingLanguage(context: viewContext)
            newItem.creater = creator
            newItem.name = name

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
