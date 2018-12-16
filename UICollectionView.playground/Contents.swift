//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.collectionView.reloadData()
        }
    }
}

extension MyViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.orange
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.3) {
            cell.transform = .identity
        }
    }

}

class Layout: UICollectionViewFlowLayout {
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes()
        attributes.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        return attributes
    }
}

let layout = Layout()
layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

PlaygroundPage.current.liveView = MyViewController(collectionViewLayout: layout)
