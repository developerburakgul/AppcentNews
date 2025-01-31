//
//  DetailViewController.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 11.01.2025.
//

//MARK: - Todo
/*
 Author ve Date kısımları yapılcak
 bu sayfaya geldiğimizde eğer favorilerde varsa kalbin dolu olmasını eğer değilse boş olmasını bekleriz.
 paylaşma butonu yapılcak

 kalpe tıklayınca favorilere ekleme user defaults model nasıl kaydedilir ? ViewModel ?

 */

import SnapKit
import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    private var article: Article

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
//        scrollView.backgroundColor = .blue
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemGray
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
//        stack.backgroundColor = .green
        return stack
    }()

    private let titleLabel : UILabel = {
        let label = UILabel()
//        label.backgroundColor = .brown
//        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release o"
        label.numberOfLines = 0
        return label
    }()
    private let descriptionLabel : UILabel = {
        let label = UILabel()
//        label.backgroundColor = .yellow
//        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release o Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release oLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release o"
        label.numberOfLines = 0
        return label
    }()



    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    //MARK: - Init Functions
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
        setAttributes(article)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttributes(_ article: Article)  {
        self.article = article
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.description
        if let urlToImage = article.urlToImage {
            let url = URL(string: urlToImage)
            let processor = DownsamplingImageProcessor(size: self.imageView.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 20)
            self.imageView.kf.indicatorType = .activity
            self.imageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        } else {
            self.imageView.image = UIImage(systemName: "photo")
        }
    }




    //MARK: - Setup Functions
    private func setup() {
        setupNewsSourceButton()
        setupContentView()
        setupScrollView()
        setupImageView()
        setupStackView()
        setupLabels()
        setupNavigationBar()
        addTargetNewsSourceButton()
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
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.trailing)
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.bottom.equalToSuperview()

        }



    }

    private func setupLabels() {
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
    }

    private func setupNavigationBar() {
        let heart = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .done,
            target: self,
            action: #selector(tappedHeart)
        )

        let share =  UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .done,
            target: self,
            action: #selector(tappedShare)
        )

        navigationItem.rightBarButtonItems = [heart, share]
    }

    private func addTargetNewsSourceButton() {
        newsSourceButton.addTarget(
            self,
            action: #selector(tappedNewsSourceButton),
            for: .touchUpInside
        )
    }
    @objc
    private func tappedHeart() {

    }
    @objc
    private func tappedShare() {

    }

    @objc
    private func tappedNewsSourceButton() {

        let webViewController = WebViewController(urlString: "https://www.icommunity.com.tr")
        navigationController?.pushViewController(webViewController, animated: true)

    }

}

