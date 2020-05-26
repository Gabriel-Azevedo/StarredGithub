import UIKit
import SnapKit

struct SpacingLayout {
    static let extraSmall: CGFloat = 4.0
    static let small: CGFloat = 8.0
    static let regular: CGFloat = 16.0
    static let image: CGFloat = 20.0
}

class RepositoryInformationTableViewCell: UITableViewCell {
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = SpacingLayout.extraSmall
        return stackView
    }()

    private var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = SpacingLayout.extraSmall
        return stackView
    }()
    
    private var starCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = SpacingLayout.extraSmall
        return stackView
    }()
    
    private var authorNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        //        imageView.kf
        return imageView
    }()
    
    private var repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.numberOfLines = .zero
        return label
    }()
    
    private var starIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        //        imageView.kf
        return imageView
    }()
    
    private var starCountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        contentView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints({ make in
            make.edges.equalToSuperview().inset(SpacingLayout.regular)
        })
        
        mainStackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(profilePhotoImageView)
        titleStackView.addArrangedSubview(authorNameLabel)
        profilePhotoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(SpacingLayout.image)
        }
        
        mainStackView.addArrangedSubview(repositoryNameLabel)
        mainStackView.addArrangedSubview(descriptionLabel)
        
        mainStackView.addArrangedSubview(starCountStackView)
        starCountStackView.addArrangedSubview(starIconImageView)
        starCountStackView.addArrangedSubview(starCountLabel)
        starIconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(SpacingLayout.image)
        }
    }
    
    func configure(repositoryName: String, authorName: String, starsCount: String, photoUrl: URL, descriptionText: String) {
        repositoryNameLabel.text = repositoryName
        authorNameLabel.text = authorName
        starCountLabel.text = starsCount
        descriptionLabel.text = descriptionText
        layoutIfNeeded()
    }
}
