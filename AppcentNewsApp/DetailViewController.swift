//
//  DetailViewController.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 11.01.2025.
//

import SnapKit
import UIKit

class DetailViewController: UIViewController {
    
    private var model: Model

    //MARK: - UI ELEMENTS
    
    private let newsSourceButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitle("News Source", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .blue
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        return view
    }()
    
    private var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        return label
    }()
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        return label
    }()
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Init Functions
    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Setup Functions
    private func setup() {
        setupNewsSourceButton()
        setupContentView()
        setupScrollView()
        setupImageView()
        setupStackView()
//        setupTitleLabel()
        
    }
    
    private func setupNewsSourceButton() {
        view.addSubview(newsSourceButton)
        newsSourceButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(newsSourceButton.snp.top).offset(-16)
        }
    }
    
    private func setupScrollView() {
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
        }
    }
    private func setupImageView() {
        scrollView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(imageView.snp.width).multipliedBy(0.5)
        }
    }
    private func setupStackView() {
        scrollView.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-16)
            
        }
    }
    
//    private func setupTitleLabel() {
//        scrollView.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { make in
//            make.leading.equalTo(imageView.snp.leading)
//            make.trailing.equalTo(imageView.snp.trailing)
//            make.top.equalTo(imageView.snp.bottom).offset(16)
//            make.height.equalTo(64)
//        }
//    }

    

    

    
}


#Preview() {
    DetailViewController(
        model: Model(title: "iCommunity", description: "UIKİT")
    )
}
