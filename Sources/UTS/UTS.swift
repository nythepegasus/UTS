#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#elseif canImport(Musl)
import Musl
#elseif canImport(ucrt)
import UTSwin
#endif

/// A Swift wrapper class around the C `uname` function and `utsname` struct
public final class UTS: Sendable, Encodable {
    /// A shared instance of the UTS class
    public static let shared = UTS()

    /// Name of this implementation of the operating system.
    public let sysname: String
    /// Name of this node within the communications network to which this node is attached, if any.
    public let nodename: String
    /// Current release level of this implementation.
    public let release: String
    /// Current version level of this release.
    public let version: String
    /// Name of the hardware type on which the system is running.
    public let machine: String

    private init() {
        var uts = utsname()
#if os(Windows)
        win_uname(&uts)
#else
        uname(&uts)
#endif
        self.sysname = withUnsafePointer(to: uts.sysname) { ptr in
            String(cString: ptr.pointer(to: \.0)!)
        }
        self.nodename = withUnsafePointer(to: uts.nodename) { ptr in
            String(cString: ptr.pointer(to: \.0)!)
        }
        self.release = withUnsafePointer(to: uts.release) { ptr in
            String(cString: ptr.pointer(to: \.0)!)
        }
        self.version = withUnsafePointer(to: uts.version) { ptr in
            String(cString: ptr.pointer(to: \.0)!)
        }
        self.machine = withUnsafePointer(to: uts.machine) { ptr in
            String(cString: ptr.pointer(to: \.0)!)
        }
    }
}
