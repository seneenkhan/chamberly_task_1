import UIKit

class TutorialViewController: UIViewController {

    private var pageViewController: UIPageViewController!
    private var pages: [UIViewController] = []
    private var currentIndex = 0
    
    private let skipButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TutorialViewController viewDidLoad called")
        setupPages()
        setupPageViewController()
        setupButtons()
        setupPageControl()
    }
    
    private func setupPages() {
        let pageData = [
            ("Profile page", "Profile"),
            ("Find chambers page", "Swipe to Chat"),
            ("My chambers page", "My Chambers"),
            ("My Journal Page", "Smart Journal & Mood Tracker"),
            ("Plupi Page", "Talk with Plupi")
        ]
        
        pages = pageData.map { TutorialPageViewController(imageName: $0.0, text: $0.1) }
        print("Pages set up: \(pages.count) pages")
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        print("Initial page set")
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupButtons() {
        skipButton.setTitle("Skip", for: .normal)
        nextButton.setTitle("Next", for: .normal)
        
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        skipButton.addTarget(self, action: #selector(skipTutorial), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupPageControl() {
        view.addSubview(pageControl)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func skipTutorial() {
        if currentIndex < pages.count - 2 {
            currentIndex += 2
        } else {
            currentIndex = 0
        }
        
        pageViewController.setViewControllers([pages[currentIndex]], direction: .forward, animated: true, completion: nil)
        updateButtonStates()
    }
    
    @objc private func nextPage() {
        if currentIndex < pages.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        pageViewController.setViewControllers([pages[currentIndex]], direction: .forward, animated: true, completion: nil)
        updateButtonStates()
    }
    
    private func updateButtonStates() {
        skipButton.isHidden = false
        nextButton.setTitle(currentIndex == pages.count - 1 ? "Done" : "Next", for: .normal)
        pageControl.currentPage = currentIndex
    }
}

extension TutorialViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
           let visibleViewController = pageViewController.viewControllers?.first,
           let index = pages.firstIndex(of: visibleViewController) {
            currentIndex = index
            updateButtonStates()
        }
    }
}

class TutorialPageViewController: UIViewController {
    private let imageView = UIImageView()
    private let textLabel = UILabel()
    
    init(imageName: String, text: String) {
        super.init(nibName: nil, bundle: nil)
        if let image = UIImage(named: imageName) {
            imageView.image = image
            print("Image loaded: \(imageName)")
        } else {
            print("Failed to load image: \(imageName)")
        }
        textLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white  // Set background color
        view.addSubview(imageView)
        view.addSubview(textLabel)
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            textLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
