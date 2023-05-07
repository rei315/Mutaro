//
//  RequestError.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import Foundation

public enum RequestError: Error {
    case unknown
    case invalidHttpStatusCode

    case urlRequest(Error)
    case emptyData
    case decode
    case status
}
