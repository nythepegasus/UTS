import Foundation
import Testing
@testable import UTS


@Suite("UTS class Tests") struct UTSTests {
    let uts: UTS = .shared

    @Test("utsname().sysname converts to String") func sysname() async throws {
        #expect(type(of: uts.sysname) == String.self)
    }

    @Test("utsname().nodename converts to String") func nodename() async throws {
        #expect(type(of: uts.nodename) == String.self)
    }

    @Test("utsname().release converts to String") func release() async throws {
        #expect(type(of: uts.release) == String.self)
    }

    @Test("utsname().version converts to String") func version() async throws {
        #expect(type(of: uts.version) == String.self)
    }

    @Test("utsname().machine converts to String") func machine() async throws {
        #expect(type(of: uts.machine) == String.self)
    }

    @Test("UTS Encodable") func encodeUTS() async throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(uts)
        #expect(data != nil, "Encoder could not encode UTS class!")
        print(String(data: data!, encoding: .utf8)!)
    }
}
