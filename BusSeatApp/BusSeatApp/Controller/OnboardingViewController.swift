//
//  OnboardingViewController.swift
//  BusSeatApp
//
//  Created by Burak Ozay on 23.02.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var slides: [OnboardingSlide] = []
    var customBlack = UIColor(rgb: 0x071E3D)
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Hadi Başlayalım", for: .normal)
            } else {
                nextButton.setTitle("İlerle", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = customBlack
        collectionView.backgroundColor = customBlack
        
        slides = [
                    OnboardingSlide(title: "Hayallerinizi Ertelemeyin", description: "Seyahatınızı bizimle planlayın, güvenli ve hızlı bir şekilde dilediğiniz yere ulaşın.", image: #imageLiteral(resourceName: "onboarding1")),
                    OnboardingSlide(title: "Bagajınız Bizimle Güvende", description: "Siz bizimle olun ya da olmayın, bagajınızı dilediğiniz yere güvenle taşıma garantisi sunuyoruz.", image: #imageLiteral(resourceName: "onboarding2")),
                    OnboardingSlide(title: "Artık Hazırsınız!", description: "Hadi biletinizi almak için sizi uygulamamıza yönlendirelim.", image: #imageLiteral(resourceName: "onboarding7"))
                ]
        
    }
    


    @IBAction func nextButtonAction(_ sender: Any) {
        
        if currentPage == (slides.count - 1) {
            performSegue(withIdentifier: "toHomeVC", sender: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as! OnboardingCell
        
        cell.configure(slide: slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
