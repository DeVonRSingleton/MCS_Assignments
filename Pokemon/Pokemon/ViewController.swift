import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func goToFirstPage(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    var pokemons: [String: Any] = [:]
    var arrayPassedOn: [Any] = []
    var dictionaryPassedOn: [String: Any] = [:]
    var keys = "" //why?
    var key = "" //why?
    var value = (Any).self //why?
    var array = [Any]()
    var sortedKeys: [String] = []
    var sortedValues: [Any] = []
    
    
    var urlLink = "https://pokeapi.co/api/v2"
    
    func loadNewTableWithData(theNewTable: UITableView)
    {
        theNewTable.dataSource = self
        theNewTable.delegate = self
        theNewTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //set up our table.
        loadNewTableWithData(theNewTable: tableView)
        
        
        // Do any additional setup after loading the view
        guard let theURL = URL(string: urlLink) else {return}
        URLSession.shared.dataTask(with: theURL) { (data, response, error) in
            //make sure that there IS data
            //make sure it IS a JSON
            //make sure it IS a dictionary
            //THEN you can assign it to your own dict.
            guard let dataThingy = data else {
                print("no data")
                return}
            let myJSONThingy = try? JSONSerialization.jsonObject(with: dataThingy, options: [])
            guard let myDataThingy = myJSONThingy else {
                print("it isn't a JSON")
                return}
            guard let myDictionaryThingy = myDataThingy as? [String: Any] else {
                print("it is not a dictionary")
                return}
            self.pokemons = myDictionaryThingy
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            }.resume()
        
        
    }
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (arrayPassedOn.isEmpty == false) {return arrayPassedOn.count }
        else if (dictionaryPassedOn.isEmpty == false) {return dictionaryPassedOn.count}
        else{
            print(dictionaryPassedOn)
            print(arrayPassedOn)
            return pokemons.keys.count}
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        //use "cell" to fill in the data your cell should contain
        if (arrayPassedOn.isEmpty == false){
            cell.textLabel?.text = "Index[\(indexPath.row)]"
        }
        else if (dictionaryPassedOn.isEmpty == false){
            var myKeys = Array(self.dictionaryPassedOn.keys)
            var keyValue = Array(self.dictionaryPassedOn.values)
            print("hey")
            print(myKeys)
            print(keyValue)
            cell.textLabel?.text = myKeys[indexPath.row]
            if (keyValue[indexPath.row] is String){
                cell.detailTextLabel?.text = keyValue[indexPath.row] as! String}
        } else
        {
            var myKeys = Array(self.pokemons.keys).sorted()
            sortedKeys = myKeys
            var keyValue = Array(self.pokemons.values)
            var indexForLoop=0
            for _ in 0..<pokemons.count{
                
                keyValue[indexForLoop] = pokemons[myKeys[indexForLoop]]
                indexForLoop += 1
            }
            sortedValues = keyValue
            
            
            cell.textLabel?.text = myKeys[indexPath.row]
            cell.textLabel?.numberOfLines = 1
            cell.detailTextLabel?.numberOfLines = 1
            
            switch keyValue[indexPath.row]{
            case is String:
                cell.detailTextLabel?.text = keyValue[indexPath.row] as? String
            case is Int:
                // string interpulation
                cell.detailTextLabel?.text = "\(keyValue[indexPath.row] as! Int)"
            case is Bool:
                cell.detailTextLabel?.text = "\(keyValue[indexPath.row] as? Bool)"
            case is Array<Any>:
                cell.detailTextLabel?.text = "Array with \( (keyValue[indexPath.row] as! Array<Any>).count ) elements "
                
                
            case is Dictionary<String, Any>:
                cell.detailTextLabel?.text = "Dictionary with \((keyValue[indexPath.row] as! Dictionary<String,Any>).count) elements"
            case is URL:
                cell.detailTextLabel?.text = "\(keyValue[indexPath.row] as? URL)"
            case is NSNull:
                cell.detailTextLabel?.text = "Null Value"
            default:
                cell.detailTextLabel?.text = ""
                
            }
            
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "nextView") as! ViewController
        if (arrayPassedOn.isEmpty == false){
            print("you pressed on an array element at \(indexPath.row)")
            switch arrayPassedOn[indexPath.row]{
            case is Array<Any>:
                print("it's an array")
                nextViewController.arrayPassedOn = arrayPassedOn[indexPath.row] as! Array<Any>
            case is Dictionary<String, Any>:
                print("it's a dictionary!")
                nextViewController.dictionaryPassedOn = arrayPassedOn[indexPath.row] as! Dictionary<String, Any>
            default:
                print("It's something else")
            }
            self.navigationController?.pushViewController(nextViewController, animated: true)
        } else if (dictionaryPassedOn.isEmpty == false){
            var values = Array(dictionaryPassedOn.values)
            switch values[indexPath.row]{
            case is String:
                nextViewController.urlLink = (values[indexPath.row] as! String)
            case is URL:
                nextViewController.urlLink = (values[indexPath.row] as! URL).absoluteString
            case is Array<Any>:
                nextViewController.arrayPassedOn = values[indexPath.row] as! Array<Any>
            case is Dictionary<String, Any>:
                nextViewController.dictionaryPassedOn = values[indexPath.row] as! Dictionary<String, Any>
            default:
                nextViewController.urlLink = ""
            }
            if (nextViewController.urlLink.contains("https://")){
                self.navigationController?.pushViewController(nextViewController, animated: true)}
            
        } else
        {
            
            
            let key = sortedKeys[indexPath.row]
            nextViewController.title = key
            switch sortedValues[indexPath.row]{
            case is URL:
                nextViewController.urlLink = (sortedValues[indexPath.row] as! URL).absoluteString
            case is String:
                nextViewController.urlLink = (sortedValues[indexPath.row] as! String)
            case is Array<Any>:
                print("pass the array and show it on the table \(sortedValues[indexPath.row])")
                nextViewController.arrayPassedOn = sortedValues[indexPath.row] as! Array<Any>
                print(nextViewController.arrayPassedOn)
            case is Dictionary<String, Any>:
                print("pass the dictionary and show it on the table")
                nextViewController.dictionaryPassedOn = sortedValues[indexPath.row] as! Dictionary<String, Any>
            default:
                nextViewController.urlLink = ""
            }
            if (nextViewController.urlLink.contains("https://")){
                self.navigationController?.pushViewController(nextViewController, animated: true)}
        }
        
        
        
        
        
        
    }
}

