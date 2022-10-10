//
//  ViewController.swift
//  it FACTORY Test task
//
//  Created by Илья Синицын on 03.10.2022.
//

import UIKit

class SectionsViewController: UIViewController {
    
    private var sections: [Section]? = nil
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .none
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    enum Sections: Int {
        case eatingHabits
        case discipline
        case eatingWell
        case eatingScience
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupCollectionView()
        setupConstraints()
        loadData()
    }
    
    // MARK: - setupCollectionView
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.register(EatingHabitsCell.self, forCellWithReuseIdentifier: EatingHabitsCell.reuseId)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        
        collectionView.dataSource = self
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - LoadData
    private func loadData() {
        if let url = Bundle.main.url(forResource: "jsonviewer", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode(JsonData.self, from: data)
                self.sections = jsonData.sections
            } catch let error {
                print("Failed to decode JSON, \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - CreateCompositionLayout
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnviroment) -> NSCollectionLayoutSection? in
            
            guard let sections = Sections(rawValue: sectionIndex) else { return nil }
            
                switch sections {
                case .eatingHabits,
                        .discipline,
                        .eatingWell,
                        .eatingScience:
                    return self.createEatingHabitsSections()
                }
            
        }
        
        let configurationLayout = UICollectionViewCompositionalLayoutConfiguration()
        configurationLayout.interSectionSpacing = 20
        layout.configuration = configurationLayout
        
        return layout
    }
    
    
    private func createEatingHabitsSections() -> NSCollectionLayoutSection {
//MARK: Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8)
        
//MARK: Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
//MARK: Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .groupPaging
        
//MARK: SectionHeader
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}

// MARK: - UICollectionViewDataSource
extension SectionsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections?[section].items.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EatingHabitsCell.reuseId, for: indexPath) as? EatingHabitsCell else { return UICollectionViewCell() }

        guard let section = sections?[indexPath.section].items[indexPath.item] else { return UICollectionViewCell() }

        cell.configurationCell(item: section)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { return UICollectionReusableView() }

        sectionHeader.configurationCell(text: sections?[indexPath.section].header ?? "")

        return sectionHeader
    }
}

// MARK: - SwiftUI
import SwiftUI

struct SectionsViewControllerProvider: PreviewProvider {
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
