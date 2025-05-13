# UTS
A small Swift wrapper around the C struct `utsname` on Unix systems.

> [!NOTE]
> Windows traditionally does not provide `uname` nor `utsname`, however this package provides its own shim specifically for Windows within the `UTSwin` target.

## Example Usage
```swift
import UTS

let uts: UTS = .shared
print(uts.sysname) // Darwin / Linux / Windows
print(uts.machine) // x86_64 / arm64 / etc
```

## License
See [`LICENSE`](LICENSE) for details.
