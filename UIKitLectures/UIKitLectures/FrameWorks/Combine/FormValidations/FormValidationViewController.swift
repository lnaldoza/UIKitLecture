//
//  FormValidationViewController.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/31/25.
//

import UIKit
import Combine

class FormValidationViewController: UIViewController {
    
    var formTableView: UITableView!
    
    
    @IBOutlet var formtable: UITableView!
    @IBOutlet var submitButtonOutlet: UIButton!
    
    let submitButton = UIButton()
    
    var store: Set<AnyCancellable> = []
    var datasource: UITableViewDiffableDataSource<Int, FieldModel>!
    let fieldModels = FieldModels()
    
    // Publisher bound to our UI which is the submit button
    var validationPublisher: AnyPublisher<Bool, Never>!
    
    struct Cells {
        static let numberView = "viewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindValidationMore()
        bindSubmitButton1()
    }
    
    func configureTableView() {
        view.addSubview(formTableView)
        
        setTableViewDelegates()
        
        formTableView.register(FieldTableViewCell.self, forCellReuseIdentifier: Cells.numberView)
    }
    
    func setTableViewDelegates() {
        formTableView.delegate = self
        formTableView.dataSource = self
    }
    
    @objc func submitActionButton() {
        print("[DEBUG] Sumbit button tapped")
    }
}

extension FormValidationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewCell", for: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
    
    func bindSubmitButton1() {
        validationPublisher
            .assign(to: \.isEnabled, on: submitButton)
            .store(in: &store)
    }
    
    func bindSubmitButton2() {
        validationPublisher
            .sink { isEnabled in
                self.submitButton.isEnabled = isEnabled
            }
            .store(in: &store)
    }
    
    fileprivate func bindValidation2() {
        validationPublisher =
        Publishers.CombineLatest(fieldModels.first.$value, fieldModels.second.$value)
            .map { value1, value2 in
                let valid = !value1.isEmpty && !value2.isEmpty
                return valid
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate func bindValidation3() {
        validationPublisher =
        Publishers.CombineLatest3(fieldModels.first.$value, fieldModels.second.$value, fieldModels.third.$value)
            .map { value1, value2, value3 in
                let valid = !value1.isEmpty && !value2.isEmpty && !value3.isEmpty
                return valid
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate func bindValidation4() {
        validationPublisher =
        Publishers.CombineLatest4(fieldModels.first.$value, fieldModels.second.$value, fieldModels.third.$value, fieldModels.fourth.$value)
            .map { value1, value2, value3, value4 in
                let valid = !value1.isEmpty && !value2.isEmpty && !value3.isEmpty && !value4.isEmpty
                return valid
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate func bindValidationMore() {
        let validation1: AnyPublisher<Bool, Never>! = Publishers.CombineLatest3(fieldModels.first.$value, fieldModels.second.$value, fieldModels.third.$value)
            .map { value1, value2, value3 in
                let valid = !value1.isEmpty && !value2.isEmpty && !value3.isEmpty
                return valid
            }
            .eraseToAnyPublisher()
        
        let validation2: AnyPublisher<Bool, Never>! = Publishers.CombineLatest3(fieldModels.fourth.$value, fieldModels.five.$value, fieldModels.sixth.$value)
            .map { value4, value5, value6 in
                let valid = !value4.isEmpty && !value5.isEmpty && !value6.isEmpty
                return valid
            }
            .eraseToAnyPublisher()
        
        validationPublisher = Publishers.CombineLatest(validation1, validation2)
            .map { result1, result2 in
                  let results = result1 && result2
                  return results
            }
            .eraseToAnyPublisher()
    }
}
