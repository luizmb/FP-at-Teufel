/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)

 ### Functional Reactive Programming

 Why?
 - Represent stream of events as values
 - Composable, testable, separation of declaration and execution, state consistency
 - Everything is a stream of events (user interactions, external actors, callbacks)

 How?
 - RxSwift, ReactiveSwift or Combine
 - - -
 ![FRP](FRP.mp4 width="388" height="692")

 ```
 let searchResults = searchBar.rx.text.orEmpty
     .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
     .distinctUntilChanged()
     .flatMapLatest { query -> Observable<[Repository]> in
         if query.isEmpty {
             return .just([])
         }
         return searchGitHub(query)
             .catchErrorJustReturn([])
     }
     .observeOn(MainScheduler.instance)

 searchResults
     .bind(to: tableView.rx.items(cellIdentifier: "Cell")) {
         (index, repository: Repository, cell) in
         cell.textLabel?.text = repository.name
         cell.detailTextLabel?.text = repository.url
     }
     .disposed(by: disposeBag)
 ```

*/
/*:
 [Previous](@previous) | [Topics](04%20-%20Topics) | [Next](@next)
 */
