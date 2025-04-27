//
//  ViewController.swift
//  ToDoList1
//
//  Created by Даниил Муратович on 27.04.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var todos: [TodoItem] = [TodoItem(name: "Test todo item", isCompleted: false)] // Изначальный ToDo для примера
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // фон
        
        view.addSubview(tableView) // таблица
        constraintTableView() // констрэинты
        configureTableView() // делегаты и источники данных
        
        // добавление добавления
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAlert))
    }
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false // отключаем констрэинтся для автолэйаут
        return tableView
    }()
    
    /* после нажатия на кнопку "добавить" срабатывает эта функция и вводим новую
    задачу, а после её редачим и создаем кнопку сохранить,
    добавляем, обновляем */
    @objc func openAlert() {
        let alert = UIAlertController(title: "Create todo", message: "", preferredStyle: .alert)
        alert.addTextField()
        let saveButton = UIAlertAction(title: "Save", style: .default) { _ in
            if let textName = alert.textFields?.first?.text {
                self.addTodo(name: textName)
            }
        }
        alert.addAction(saveButton) // добавдение кнопки
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive) // аналогично кнопке "сохранить"
        alert.addAction(cancelButton)
        
        // отображение на экране
        present(alert, animated: true)
    }
    
    // добавление новой задачи
    func addTodo(name: String) {
        todos.append(TodoItem(name: name, isCompleted: false))
        tableView.reloadData()
    }
    
    // утсановление констрейнтов
    func constraintTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // настройки таблицы
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
    }
    
    // MARK: - Table View Methods

    // определение количества строк в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    // конфигурации ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        let todoItem = todos[indexPath.row]
        
        cell.textLabel?.text = todoItem.name // текст ячейки = название задачи
        cell.accessoryType = todoItem.isCompleted ? .checkmark : .none // отметка выполнения/неввыполнения задачи
        
        return cell
    }

    // вызывается при нажатии на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // переключение отметки
        todos[indexPath.row].isCompleted.toggle()
        
        // обновление accessoryType
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = todos[indexPath.row].isCompleted ? .checkmark : .none
        }

        // Убираем выделение ячейки
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // функция при удалении строки
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
