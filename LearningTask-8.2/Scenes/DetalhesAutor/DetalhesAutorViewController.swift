//
//  DetalhesAutorViewController.swift
//  LearningTask-8.2
//
//  Created by jeovane.barbosa on 30/11/22.
//

import Foundation
import UIKit

class DetalhesAutorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var autor: Autor?
    var livrosApi: LivrosAPI?
    
    var livros: [Livro] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        setupTableView()
        setupViews()
        guard let autor = autor else {return}
        tableView.tableHeaderView = AutorTableHeaderView.constroi(para: autor)
        carregaLivros()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViews() {
        tableView.register(TableSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: TableSectionHeaderView.reuseId)
        tableView.sectionHeaderHeight = TableSectionHeaderView.alturaBase
        tableView.sectionHeaderTopPadding = 0
    }
    
    private func carregaLivros(){
        guard let livrosApi = livrosApi,
             let autor = autor else {return}
        livros = livrosApi.carregaLivros(por: autor)
    }
}

//MARK: - Implements DataSource

extension DetalhesAutorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return livros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LivroDoAutorViewCell", for: indexPath) as? LivrosTableViewCell else {
            fatalError("Unable to acquire cell to present.")
        }
        let livro = livros[indexPath.row]
        cell.livro = livro
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeaderView.reuseId) as? TableSectionHeaderView else {
            fatalError("Unable to acquire a SectionHeaderView to present.")
        }
        sectionHeaderView.titulo = "Livros publicados"
        return sectionHeaderView
    }
    
}

//MARK: - Implements Delegate

extension DetalhesAutorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
