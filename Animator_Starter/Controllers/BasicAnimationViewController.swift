import UIKit

class BasicAnimationViewController: UIViewController {
    
    // MARK: Storyboard outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var graphic: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    // MARK: Appearance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    //MARK: - LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // UI setup
        graphic.round(cornerRadius: graphic.frame.size.width/2, borderWidth: 3.0, borderColor: .black)
        
        // TODO: Animation setup
        titleLabel.alpha = 0
        graphic.alpha = 0
        loadingLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: Fire initial animations
        animateTitleLabelIn()
        animateGraphicIn() {
            self.animateLoadingLabelPulse()
            self.segueToNextViewController(segueID: Constants.Segues.toSpringsVC, delay: 3)
        }
        
    }
    
    
    
    //MARK: - ANIMATIONS
    
    private func animateTitleLabelIn() {
        UIView.animate(withDuration: 1.5) { [self] in
            titleLabel.alpha = 1
            titleLabel.frame.origin.y -= 50 // <-- In UIKit you move views up by decreasing the y value
        }
    }
    
    private func animateGraphicIn(animationOnCompletion : (() -> Void)? = nil) {
        UIView.animate(withDuration: 1.5, delay: 0.75, options: [.curveEaseInOut],
                       animations: { [self] in
            graphic.alpha = 1
            graphic.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { completed in
            animationOnCompletion?()
        }
    }
    
    func animateLoadingLabelPulse() {
        UIView.animate(withDuration: 0.6, delay: 0, options: [.autoreverse, .repeat, .curveEaseIn]) { [self] in
            loadingLabel.alpha = 1
            loadingLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
    
    
    
}

