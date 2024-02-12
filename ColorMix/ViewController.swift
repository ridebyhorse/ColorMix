//
//  ViewController.swift
//  ColorMix
//
//  Created by Мария Нестерова on 10.02.2024.
//

import UIKit

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}

class ViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    private var currentColor = 0
    
    private var threeColorMixing = false
    
    private let mainLabel: UILabel = {
        let mainLabel = UILabel()
        mainLabel.font = .systemFont(ofSize: 28, weight: .medium)
        mainLabel.text = "Mix your perfect color"
        
        return mainLabel
    }()
    
    private let firstColorButton: UIButton = {
        let firstColorButton = UIButton()
        firstColorButton.backgroundColor = .red
        firstColorButton.layer.borderColor = UIColor.systemGray5.cgColor
        firstColorButton.layer.borderWidth = 2
        firstColorButton.addTarget(self, action: #selector(firstColorButtonTapped), for: .touchUpInside)
        
        return firstColorButton
    }()
    
    private let secondColorButton: UIButton = {
        let secondColorButton = UIButton()
        secondColorButton.backgroundColor = .blue
        secondColorButton.layer.borderColor = UIColor.systemGray5.cgColor
        secondColorButton.layer.borderWidth = 2
        secondColorButton.addTarget(self, action: #selector(secondColorButtonTapped), for: .touchUpInside)
        
        return secondColorButton
    }()
    
    private let thirdColorButton: UIButton = {
        let thirdColorButton = UIButton()
        thirdColorButton.backgroundColor = .systemBackground
        thirdColorButton.layer.borderColor = UIColor.systemGray5.cgColor
        thirdColorButton.layer.borderWidth = 2
        thirdColorButton.setImage(UIImage(systemName: "plus"), for: .normal)
        thirdColorButton.addTarget(self, action: #selector(thirdColorButtonTapped), for: .touchUpInside)
        
        return thirdColorButton
    }()
    
    private let resultColorView: UIView = {
        let resultColorView = UIView()
        resultColorView.layer.borderColor = UIColor.systemGray5.cgColor
        resultColorView.layer.borderWidth = 2
        
        return resultColorView
    }()
    
    private let firstColorLabel: UILabel = {
        let firstColorLabel = UILabel()
        firstColorLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        return firstColorLabel
    }()
    
    private let secondColorLabel: UILabel = {
        let secondColorLabel = UILabel()
        secondColorLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        return secondColorLabel
    }()
    
    private let thirdColorLabel: UILabel = {
        let thirdColorLabel = UILabel()
        thirdColorLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        return thirdColorLabel
    }()
    
    private let resultColorLabel: UILabel = {
        let resultColorLabel = UILabel()
        resultColorLabel.font = .systemFont(ofSize: 18, weight: .regular)
        
        return resultColorLabel
    }()
    
    private let closeThirdColorButton: UIButton = {
        let closeThirdColorButton = UIButton()
        closeThirdColorButton.backgroundColor = .systemBackground
        closeThirdColorButton.layer.borderColor = UIColor.systemGray5.cgColor
        closeThirdColorButton.tintColor = UIColor.systemGray
        closeThirdColorButton.layer.borderWidth = 2
        closeThirdColorButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeThirdColorButton.isHidden = true
        closeThirdColorButton.addTarget(self, action: #selector(closeThirdColorButtonTapped), for: .touchUpInside)
        
        return closeThirdColorButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    override func viewWillLayoutSubviews() {
        mixColors()
        for view in view.subviews {
            if view is UILabel {
                continue
            }
            view.layer.cornerRadius = view.frame.width / 2
            view.clipsToBounds = true
        }
    }
    
    private func setupViews() {
        view.addSubview(mainLabel)
        view.addSubview(firstColorButton)
        view.addSubview(secondColorButton)
        view.addSubview(thirdColorButton)
        view.addSubview(resultColorView)
        view.addSubview(firstColorLabel)
        view.addSubview(secondColorLabel)
        view.addSubview(thirdColorLabel)
        view.addSubview(resultColorLabel)
        view.addSubview(closeThirdColorButton)
        
        for view in view.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            secondColorButton.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 80),
            secondColorButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            secondColorButton.widthAnchor.constraint(equalToConstant: 50),
            secondColorButton.heightAnchor.constraint(equalTo: secondColorButton.widthAnchor),
            firstColorButton.topAnchor.constraint(equalTo: secondColorButton.topAnchor),
            firstColorButton.trailingAnchor.constraint(equalTo: secondColorButton.leadingAnchor, constant: -50),
            firstColorButton.widthAnchor.constraint(equalTo: secondColorButton.widthAnchor),
            firstColorButton.heightAnchor.constraint(equalTo: firstColorButton.widthAnchor),
            thirdColorButton.topAnchor.constraint(equalTo: secondColorButton.topAnchor),
            thirdColorButton.leadingAnchor.constraint(equalTo: secondColorButton.trailingAnchor, constant: 50),
            thirdColorButton.widthAnchor.constraint(equalTo: secondColorButton.widthAnchor),
            thirdColorButton.heightAnchor.constraint(equalTo: thirdColorButton.widthAnchor),
            resultColorView.topAnchor.constraint(equalTo: secondColorButton.bottomAnchor, constant: 70),
            resultColorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            resultColorView.widthAnchor.constraint(equalToConstant: 240),
            resultColorView.heightAnchor.constraint(equalTo: resultColorView.widthAnchor),
            firstColorLabel.centerXAnchor.constraint(equalTo: firstColorButton.centerXAnchor),
            firstColorLabel.bottomAnchor.constraint(equalTo: firstColorButton.topAnchor, constant: -8),
            secondColorLabel.centerXAnchor.constraint(equalTo: secondColorButton.centerXAnchor),
            secondColorLabel.topAnchor.constraint(equalTo: firstColorLabel.topAnchor),
            thirdColorLabel.centerXAnchor.constraint(equalTo: thirdColorButton.centerXAnchor),
            thirdColorLabel.topAnchor.constraint(equalTo: secondColorLabel.topAnchor),
            resultColorLabel.centerXAnchor.constraint(equalTo: resultColorView.centerXAnchor),
            resultColorLabel.bottomAnchor.constraint(equalTo: resultColorView.topAnchor, constant: -8),
            closeThirdColorButton.centerYAnchor.constraint(equalTo: thirdColorButton.topAnchor, constant: 6),
            closeThirdColorButton.centerXAnchor.constraint(equalTo: thirdColorButton.trailingAnchor, constant: -6),
            closeThirdColorButton.widthAnchor.constraint(equalToConstant: 24),
            closeThirdColorButton.heightAnchor.constraint(equalTo: closeThirdColorButton.widthAnchor)
        ])
        
    }
    
    private func mixColors() {
        guard let first = firstColorButton.backgroundColor else { return }
        guard let second = secondColorButton.backgroundColor else { return }
        guard let third = thirdColorButton.backgroundColor else { return }
        if !threeColorMixing {
            let red = (first.rgba.red + second.rgba.red) / 2
            let green = (first.rgba.green + second.rgba.green) / 2
            let blue = (first.rgba.blue + second.rgba.blue) / 2
            let newColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
            resultColorView.backgroundColor = newColor
        } else {
            let red = (first.rgba.red + second.rgba.red + third.rgba.red) / 3
            let green = (first.rgba.green + second.rgba.green + third.rgba.green) / 3
            let blue = (first.rgba.blue + second.rgba.blue + third.rgba.blue) / 3
            let newColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
            resultColorView.backgroundColor = newColor
            thirdColorLabel.text = thirdColorButton.backgroundColor?.accessibilityName.localizedCapitalized
        }
        
        firstColorLabel.text = firstColorButton.backgroundColor?.accessibilityName.localizedCapitalized
        secondColorLabel.text = secondColorButton.backgroundColor?.accessibilityName.localizedCapitalized
        resultColorLabel.text = resultColorView.backgroundColor?.accessibilityName.localizedCapitalized
        
    }
    
    private func createColorPicker(initialColor: UIColor) -> UIColorPickerViewController {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = initialColor
        colorPicker.supportsAlpha = false
        colorPicker.modalPresentationStyle = .popover
        colorPicker.isModalInPresentation = true
        
        
        return colorPicker
    }
    
    func colorPickerViewController(_: UIColorPickerViewController, didSelect: UIColor, continuously: Bool) {
        switch currentColor {
        case 1:
            firstColorButton.backgroundColor = didSelect
        case 2:
            secondColorButton.backgroundColor = didSelect
        case 3:
            thirdColorButton.backgroundColor = didSelect
        default:
            break
        }
        mixColors()
    }
    
    @objc private func firstColorButtonTapped(_ sender: UIButton) {
        print("First color button tapped")
        currentColor = 1
        guard let first = firstColorButton.backgroundColor else { return }
        let colorPicker = createColorPicker(initialColor: first)
        colorPicker.title = "Choose first color"
        self.present(colorPicker, animated: true)
    }
    
    @objc private func secondColorButtonTapped(_ sender: UIButton) {
        print("Second color button tapped")
        currentColor = 2
        guard let second = firstColorButton.backgroundColor else { return }
        let colorPicker = createColorPicker(initialColor: second)
        colorPicker.title = "Choose second color"
        self.present(colorPicker, animated: true)
    }
    
    @objc private func thirdColorButtonTapped(_ sender: UIButton) {
        print("Third color button tapped")
        currentColor = 3
        if thirdColorButton.imageView?.image != nil {
            thirdColorButton.setImage(nil, for: .normal)
            threeColorMixing = true
            closeThirdColorButton.isHidden = false
        }
        guard let third = firstColorButton.backgroundColor else { return }
        let colorPicker = createColorPicker(initialColor: third)
        colorPicker.title = "Choose third color"
        self.present(colorPicker, animated: true)
    }
    
    @objc private func closeThirdColorButtonTapped(_ sender: UIButton) {
        print("Close third color button tapped")
        threeColorMixing = false
        thirdColorButton.backgroundColor = .systemBackground
        thirdColorButton.setImage(UIImage(systemName: "plus"), for: .normal)
        closeThirdColorButton.isHidden = true
    }
    
}
