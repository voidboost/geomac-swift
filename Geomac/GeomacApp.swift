import SwiftData
import SwiftUI
import UserNotifications

class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    func applicationDidFinishLaunching(_ notifcation: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}

@main
struct GeomacApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var delegate

    @Environment(\.openWindow) private var openWindow

    private let modelContainer: ModelContainer

    init() {
        do {
            let schema = Schema([Coordinates.self, GeomacResult.self])
            let modelContainer = try ModelContainer(for: schema)
            modelContainer.mainContext.autosaveEnabled = true
            self.modelContainer = modelContainer
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
        .windowResizability(.contentSize)
        .commands(content: removed)

        WindowGroup("Licenses", id: "licenses") {
            LicensesView()
        }
        .defaultPosition(.center)
        .windowResizability(.contentSize)
        .commands(content: customCommands)
        .commands(content: removed)
    }

    @CommandsBuilder
    func customCommands() -> some Commands {
        CommandGroup(replacing: .appSettings) {
            Button {
                openWindow(id: "licenses")
            } label: {
                Text("Licenses")
            }
        }
    }

    @CommandsBuilder
    func removed() -> some Commands {
        CommandGroup(replacing: .importExport) {}
        CommandGroup(replacing: .newItem) {}
        CommandGroup(replacing: .printItem) {}
        CommandGroup(replacing: .saveItem) {}
        CommandGroup(replacing: .sidebar) {}
        CommandGroup(replacing: .singleWindowList) {}
        CommandGroup(replacing: .systemServices) {}
        CommandGroup(replacing: .toolbar) {}
        CommandGroup(replacing: .windowList) {}
    }
}
