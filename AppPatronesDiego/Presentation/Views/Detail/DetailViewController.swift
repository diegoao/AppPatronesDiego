//
//  DetailViewController.swift
//  AppPatronesDiegoAndrades
//
//  Created by Macbook Pro on 25/1/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: IBOutlesç
    @IBOutlet weak var HeroNameLabel: UILabel!
    @IBOutlet weak var ImageHero: UIImageView!
    @IBOutlet weak var TextDescriptionLabel: UITextView!
    
    // MARK: ViewModel
    private var detailHeroViewModel : DetailHeroViewModel
    private var heroe: String = ""
    
    init(detailHeroViewModel: DetailHeroViewModel = DetailHeroViewModel(), heroe: String){
        self.heroe = heroe
        self.detailHeroViewModel = detailHeroViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailHeroViewModel.loadDetail(heroname: heroe)
        setObservers()
    }
    private func setObservers(){
        detailHeroViewModel.datailStatusLoad = { [weak self] status in
            switch status{
            case .loading:
                print("Detail Loading")
            case .loaded:
                self?.ViewData()
            case .error:
                print("Detail error")
            case .none:
                print("Detail none")
            }
        }
    }
    func ViewData(){
        HeroNameLabel.text = detailHeroViewModel.detailData[0].name
        TextDescriptionLabel.text = detailHeroViewModel.detailData[0].description
        guard let imageURL = URL(string: detailHeroViewModel.detailData[0].photo) else {
            return
        }
        ImageHero.setImage(url: imageURL)
    }
    
    
}

