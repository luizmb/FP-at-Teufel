/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)

 ### Declarative syntax

 Why?
 - It's not about code style, it's a tool that helps separating definition from execution
 - It enforces lazyness
 - It enforces consistency, because a set of rules is more consistent than a set of steps
 - Going toward DSL will unlock powerful things like multiple interpreters for same definition, as seen in SwiftUI

 How?
 - Learn composition and data type operations
 - Avoid imperative programming and implicit state, that leads to inconsistency
 - Experiment with DSL, trying to create your own language that won't run anything, only describe it
 - - -
 */
import PlaygroundSupport
import UIKit

func readVersion(major: Promise<Data, Error>, minor: Promise<Data, Error>) -> Promise<String, Error> {
    zip(major, minor)
        .map { characteristicLeft, characteristicRight -> (String?, String?) in
            let majorMaybe: String? = String(data: characteristicLeft, encoding: .utf8)
            let minorMaybe: String? = String(data: characteristicRight, encoding: .utf8)
            return (majorMaybe, minorMaybe)
        }
        .map(zip)
        .errorOnNil(ReadVersionError())
        .map { "\($0).\($1)" }
}

func readVersion() -> Promise<String, Error> {
    readVersion(major: readBluetoothCharacteristic(id: majorVersionCharacteristicId),
                minor: readBluetoothCharacteristic(id: minorVersionCharacteristicId))
}

class ViewController: UIViewController {
    private let label = UILabel(frame: .init(origin: .zero, size: .init(width: 200, height: 50)))
    private var cancellables = CancellableGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(label)

        readVersion()
            .receive(on: .main)
            .catchError { error in Promise<String, Never>.create(success: "??.??") }
            .bind(to: \.label.text, on: self)
            .disposed(by: cancellables)
    }
}

PlaygroundPage.current.liveView = ViewController()

/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)
 */
