//
//  CellCustomTableViewCell.swift
//  AppPatronesDiegoAndrades
//
//  Created by Macbook Pro on 25/1/24.
//

import UIKit

class CellCustomTableViewCell: UITableViewCell {
    
    // MARK: - Identificador
    static let identifier = "CellCustomTableViewCell"
    
    //MARK: - OUTLETS

    @IBOutlet weak var nameHero: UILabel!
    @IBOutlet weak var imageHero: UIImageView!

    
    // MARK: - Configure
    func configure(with hero: HeroModel){
        nameHero.text = hero.name
        guard let imageURL = URL(string: hero.photo) else {
            return
        }
        imageHero.setImage(url: imageURL)
    }
}
