# SwiftEasyExtension

### Hi there 👋

SwiftEasyExtension is an collection of commonly used extension written in Swift.

## Requirements

iOS 10.0+ / macOS 10.12+ 
Xcode 10+
Swift 4 +

## Installation

Download this project and simply drag and drop extension folder into your xcode project.


## Uses 

#### UIView+Ext

    ## 1. Add your own NavigationView
    
    private let naContainerV = UIView()
 
    override func viewDidLoad() {
        //TODO: - Title
        naContainerV.configureContainerView(navigationItem)
    }
    
    ## 2. Set Shadow For View
    
    let containerView = UIView()
    
     override func viewDidLoad() {
        //TODO: - Shadow
        containerView.setupShadowForView(view)
    }
    
    
   
#### UILabel+Ext

    ## 1. Add Navigation Title

    private let titleLbl = UILabel()
 
    override func viewDidLoad() {
        //TODO: - Title
        titleLbl.configureTitleForNavi(naContainerV, isTxt: "Home Page")
    }
    
 


## Reach me via 👇🏻
[![Instagram](https://i.ibb.co/3m04rjW/insta.png)](https://www.instagram.com/developer.arvind/) [![Linkedin](https://i.ibb.co/ZdvBhbV/linkedin.png)](https://www.linkedin.com/in/arvindcs/)
