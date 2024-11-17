import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Table View
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // Text Field
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter todo item"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    // Add Button
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(addTodoItem), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Todo Items Array
    private var todoItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "iTahDoodle"
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(textField)
        view.addSubview(addButton)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Text Field Constraints
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.widthAnchor.constraint(equalToConstant: 250),
            
            // Add Button Constraints
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Table View Constraints
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func addTodoItem() {
        guard let todoText = textField.text, !todoText.isEmpty else { return }
        
        todoItems.append(todoText)
        tableView.insertRows(at: [IndexPath(row: todoItems.count - 1, section: 0)], with: .automatic)
        textField.text = ""
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        cell.textLabel?.text = todoItems[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
