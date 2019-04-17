import Core

let tool = ColoredShapes()

do {
    try tool.run()
} catch {
    print("Whoops! An error occurred: \(error.localizedDescription)")
}
