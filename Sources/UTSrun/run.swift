import UTS

@main
struct UTSTester {
    static let uts: UTS = .shared

    static func main() throws {
        print("sysname: \(uts.sysname)")
        print("nodename: \(uts.nodename)")
        print("release: \(uts.release)")
        print("version: \(uts.version)")
        print("machine: \(uts.machine)")
        print("Press Enter to continue...")
        _ = readLine()
    }
}
