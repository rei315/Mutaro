//
//  MutaroInfoUploadViewModel.swift
//  
//
//  Created by minguk-kim on 2023/01/12.
//

import Foundation

final public class MutaroInfoUploadViewModel: NSObject {
    typealias Routes = MutaroInfoUploadRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
}
