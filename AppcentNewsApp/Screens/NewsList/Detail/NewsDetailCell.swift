//
//  NewsDetailCellTableViewCell.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 10.01.2025.
//


//MARK: - Todo
/*
 configure
 */
import UIKit

class NewsDetailCell: UITableViewCell {
    
    
    static let identifier = "NewsDetailCell"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.label
        label.numberOfLines = 1
        label.backgroundColor = .red
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.secondaryLabel
        label.backgroundColor = .yellow
        label.numberOfLines = 2
        return label
    }()
    
    private var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
//        image.backgroundColor = .green
        imageView.backgroundColor = UIColor.green
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemGray
        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: image.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: image.bottomAnchor)
            
        ])
    }

    
    func configureWith(_ news: Article) {
        //MARK: - TO DO
        // gelen newsin özellikleri uı elementlerine setlencek
        self.titleLabel.text = news.title // bunun gibi

    }
    

}

#Preview("Cell") {
    NewsViewController()
}
