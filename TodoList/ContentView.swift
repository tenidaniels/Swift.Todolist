import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted = false
}

struct ContentView: View {
    @State private var tasks: [Task] = []
    @State private var newTask: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("New Task", text: $newTask)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Add Task") {
                    tasks.append(Task(title: newTask))
                    newTask = ""
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)

                List {
                    ForEach(tasks) { task in
                        TaskRow(task: task, toggleCompletion: {
                            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                                tasks[index].isCompleted.toggle()
                            }
                        })
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("To-Do List")
            .foregroundColor(Color.black)//color of the text when typing
     
            .navigationBarItems(trailing: EditButton())
            .foregroundColor(Color.blue)
        }
    }

    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

struct TaskRow: View {
    var task: Task
    var toggleCompletion: () -> Void

    var body: some View {
        HStack {
            Button(action: toggleCompletion) {
                Image(systemName: task.isCompleted ? "checkmark.square" : "square")
            }
            .foregroundColor(.blue)

            Text(task.title)
                .strikethrough(task.isCompleted)
                .foregroundColor(task.isCompleted ? .gray : .primary)

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

