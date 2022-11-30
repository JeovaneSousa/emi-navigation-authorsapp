//
//  LivrosTableViewCell.swift
//  LearningTask-8.2
//
//  Created by jeovane.barbosa on 30/11/22.
//

import UIKit

class LivrosTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tituloLivroLabel: UILabel!
    @IBOutlet weak var capaLivroImageView: UIImageView!
    
    var livro: Livro? {
        didSet {
            guard let livro = livro else {return}
            let height = 86.0
            let width = height * 1.75
            tituloLivroLabel.text = livro.titulo
            capaLivroImageView.image = UIImage(livro.imagemDeCapaURI, aspectFillIn: CGRect(x: 0, y: 0, width: width , height: height))
        }
    }

}
