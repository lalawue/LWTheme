//
//  ViewController.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/15.
//  Copyright © 2019 lalawue. All rights reserved.
//

import UIKit
import LWThemeSwift

class ViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadThemeWithMode(LWThemeMode.Light)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onChangeTheme),
                                               name:NSNotification.Name(rawValue: kLWThemeModeUpdateNotification),
                                               object:nil)
        
        // text label
        self.titleLabel.lw_textColor = "TitleLabel";
        self.navigationController?.navigationBar.addSubview(self.titleLabel)
        
        self.navigationController?.navigationBar.lw_barTintColor = "NavBarTintColor";
        self.view.lw_backgroundColor = "#909090"; ///< #RGBA, fixed color
        
        self.view.addSubview(self.tableView)
        
        // sub views
        let image = UIImage.init(named: "wifi_icon")
        
        // image named
        self.imageNamed.lw_imageName = "sign_icon"
        
        // image view
        self.imageView.lw_setImage(image, tintColor: "ImageTintColor")
        
        // image button
        self.imageButton.titleLabel?.lw_font = "ImageButtonFont"
        self.imageButton.lw_setTitleColor("TitleLabel", for: UIControl.State.normal)
        self.imageButton.lw_setBackgroundImage(image, tintColor: "ImageButtonTint", for: UIControl.State.normal)
        self.imageButton.layer.lw_borderColor = "ImageButtonBorder";
        
        // attr label
        self.attrLabel.lw_font = "AttrStringFont"
        self.attrLabel.lw_setAttributes([NSAttributedString.Key.foregroundColor : "LabelAttrString",
                                         NSAttributedString.Key.backgroundColor : "LabelAttrBackground"],
                                        range: NSMakeRange(0, 11))
        self.attrLabel.lw_setAttributes([NSAttributedString.Key.foregroundColor : "LabelAttrBackground",
                                         NSAttributedString.Key.backgroundColor : "LabelAttrString"],
                                        range: NSMakeRange(11, self.attrLabel.attributedText!.length - 11))
        
        // switch
        self.switchButton.lw_onTintColor = "SwitchOnTint"
        self.switchButton.lw_tintColor = "SwitchThumb";
        self.switchButton.lw_thumbTintColor = "SwitchThumb";
        
        // gradient layer
        self.gradientLayer.lw_colors = [ "GradientLayerStart", "GradientLayerEnd"];
        
        // button
        self.actionButton.lw_setTitleColor("ActionButtonTitle", for: UIControl.State.normal);
        self.actionButton.lw_backgroundColor = "ActionButtonBackground"; ///< color from map
        self.view.addSubview(self.actionButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let viewSize = self.view.frame.size;

        let navBarSize = self.navigationController?.navigationBar.bounds.size ?? CGSize(width: 0, height: 0)
        self.titleLabel.center = CGPoint(x: navBarSize.width/2, y: navBarSize.height/2);
        
        self.tableView.frame = self.view.bounds
        
        self.actionButton.center = CGPoint(x: viewSize.width/2, y: viewSize.height - 80);
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let style = LWThemeManager.sharedInstance.isDarkMode ? UIStatusBarStyle.lightContent : UIStatusBarStyle.default
        return style
    }
    
    //MARK:
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat = 0.0
        switch (indexPath.row) {
        case 0: height = self.imageNamed.frame.size.height; break;
        case 1: height = self.imageView.frame.size.height; break;
        case 2: height = self.imageButton.frame.size.height; break;
        case 3: height = self.attrLabel.frame.size.height; break;
        case 4: height = self.switchButton.frame.size.height; break;
        case 5: height = self.gradientLayer.frame.size.height; break;
        default:
            break;
        }
        return height + 20.0;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.textAlignment = NSTextAlignment.right
        
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "UIImage\nimageNamed"
            cell?.textLabel?.numberOfLines = 2
            cell?.contentView.addSubview(self.imageNamed)
            break;
            
        case 1:
            cell?.textLabel?.text = "UIImageView\ntint image"
            cell?.textLabel?.numberOfLines = 2
            cell?.contentView.addSubview(self.imageView)
            break;
            
        case 2:
            cell?.textLabel?.text = "UIButton\ntitle color\nfont family:size\nborder color\ntint background image"
            cell?.textLabel?.numberOfLines = 5
            cell?.contentView.addSubview(self.imageButton)
            break;
            
        case 3:
            cell?.textLabel?.text = "UILabel\ntext color\nattributed string color\nfont family:size"
            cell?.textLabel?.numberOfLines = 4
            cell?.contentView.addSubview(self.attrLabel)
            break;
            
        case 4:
            cell?.textLabel?.text = "UISwitch"
            cell?.contentView.addSubview(self.switchButton)
            break;
            
        case 5:
            cell?.textLabel?.text = "CAGraidentLayer"
            cell?.contentView.layer.addSublayer(self.gradientLayer)
            break;
            
        default:
            break;
        }
        return cell!
    }
    
    //MARK:
    
    @objc func onChangeTheme() {
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @objc func onAction() {
        if (LWThemeManager.sharedInstance.isDarkMode) {
            loadThemeWithMode(LWThemeMode.Light)
        } else {
            loadThemeWithMode(LWThemeMode.Dark)
        }
    }
    
    //MARK:
    
    func loadThemeWithMode(_ themeMode : LWThemeMode) {
        let fileMap = [ LWThemeMode.Light : "LightMap", LWThemeMode.Dark : "DarkMap" ]
        let themeMap = themeMapWithName(fileMap[themeMode] ?? "LightMap" )
        LWThemeManager.sharedInstance.useThemeMode(themeMode, themeMap: themeMap)
    }
    
    func themeMapWithName(_ name : String) -> NSDictionary {
        let path = Bundle.main.path(forResource: name, ofType: "plist")
        return NSDictionary(contentsOfFile: path!) ?? [:]

    }
    
    //MARK:
    
    lazy var titleLabel : UILabel = {
        let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 35)))
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = NSTextAlignment.center;
        label.text = "Title Label";
        return label
    }()
    
    lazy var imageNamed : UIImageView = {
        let view = UIImageView(frame: CGRect(origin: CGPoint(x: 24, y: 10), size: CGSize(width: 100, height: 100)))
        return view
    }()
    
    lazy var imageView : UIImageView = {
        let view = UIImageView(frame: CGRect(origin: CGPoint(x: 24, y: 10), size: CGSize(width: 100, height: 100)))
        return view
    }()
    
    lazy var imageButton : UIButton = {
        let button = UIButton(frame: CGRect(origin: CGPoint(x: 24, y: 10), size: CGSize(width: 100, height: 100)))
        button.setTitle("Button", for: UIControl.State.normal)
        button.layer.cornerRadius = 50
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 1;
        return button
    }()
    
    lazy var attrLabel : UILabel = {
        let label = UILabel(frame: CGRect(origin: CGPoint(x: 24, y: 10), size: CGSize(width: 300, height: 80)))
        label.textAlignment = NSTextAlignment.left;
        label.attributedText = NSAttributedString.init(string: "Attributed  String");
        return label
    }()
    
    lazy var switchButton : UISwitch = {
        let button = UISwitch(frame: CGRect(origin: CGPoint(x: 24, y: 10), size: CGSize(width: 75, height: 40)))
        button.isOn = true
        return button
    }()
    
    lazy var gradientLayer : CAGradientLayer = {
        let layer = CAGradientLayer.init()
        layer.frame = CGRect(origin: CGPoint(x: 24, y: 10), size: CGSize(width: 100, height: 100))
        layer.cornerRadius = 50
        layer.masksToBounds = true
        return layer
    }()
    
    lazy var actionButton : UIButton = {
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 180, height: 35)))
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.setTitle("Change Theme", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(onAction), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var tableView : UITableView  = {
        let view = UITableView(frame: CGRect(origin: CGPoint.zero, size: CGSize.zero))
        view.backgroundColor = UIColor.clear
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        return view
    }()
}

