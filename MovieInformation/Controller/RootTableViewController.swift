import UIKit

class RootTableViewController: UIViewController {

    @IBOutlet weak var movieInfoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        movieInfoTableView.delegate = self
        movieInfoTableView.dataSource = self
    }


}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension RootTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
    
    
}

