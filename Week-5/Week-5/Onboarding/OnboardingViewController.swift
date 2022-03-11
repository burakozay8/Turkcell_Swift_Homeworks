//
//  ViewController.swift
//  Week-5
//
//  Created by Burak Ozay on 6.02.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        slides = [
                    OnboardingSlide(title: "Welcome To The Future!", description: "Future is a crypto wallet app where you can make your transactions quickly and securely.", image: #imageLiteral(resourceName: "slide1")),
                    OnboardingSlide(title: "Most Trusted Crypto Wallet.", description: "Take full control of your tokens, collectibles by storing them on your device.", image: #imageLiteral(resourceName: "slide2")),
                    OnboardingSlide(title: "Come On In!", description: "Complete your profile in less than 5 minutes to start your crypto journey.", image: #imageLiteral(resourceName: "slide3"))
                ]
        
        view.backgroundColor = .black
        
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        
        if currentPage == (slides.count - 1) {
            print("Go to the next page")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
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

