//
//  MutaroInfoUploadViewController.swift
//  
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit

final public class MutaroInfoUploadViewController: UIViewController {

    private let viewModel: MutaroInfoUploadViewModel
    
    public init(viewModel: MutaroInfoUploadViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
