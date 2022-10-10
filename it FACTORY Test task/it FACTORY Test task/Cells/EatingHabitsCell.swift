//
//  EatingHabitsCell.swift
//  it FACTORY Test task
//
//  Created by Илья Синицын on 03.10.2022.
//

import UIKit

class EatingHabitsCell: UICollectionViewCell {
    
    static var reuseId: String = "EatingHabitsCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 5
                layer.borderColor = UIColor(named: "purple")?.cgColor
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 15
        clipsToBounds = true
        addSubview(imageView)
        imageView.addSubview(blurView)
        imageView.addSubview(label)
    }
    
    func configurationCell(item: Item) {
        guard let url = URL(string: item.image.the1X) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.imageView.image = image
                }
        }.resume()
        
        label.text = item.title
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            blurView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct ViewControllerProvider: PreviewProvider {
    static var previews: some  View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = SectionsViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}

