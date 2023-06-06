//
//  CIProductsDTO.swift
//
//
//  Created by minguk-kim on 2023/06/06.
//

import Core
import Foundation

public struct CIProductsDTO: Codable {}

// {
//  "links" : {
//    "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts"
//  },
//  "data" : [
//    {
//      "id" : "5E8FA748-1FF5-4518-BD6E-50773059C370",
//      "relationships" : {
//        "app" : {
//          "links" : {
//            "related" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/5E8FA748-1FF5-4518-BD6E-50773059C370\/app",
//            "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/5E8FA748-1FF5-4518-BD6E-50773059C370\/relationships\/app"
//          }
//        },
//        "additionalRepositories" : {
//          "links" : {
//            "related" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/5E8FA748-1FF5-4518-BD6E-50773059C370\/additionalRepositories",
//            "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/5E8FA748-1FF5-4518-BD6E-50773059C370\/relationships\/additionalRepositories"
//          }
//        },
//        "buildRuns" : {
//          "links" : {
//            "related" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/5E8FA748-1FF5-4518-BD6E-50773059C370\/buildRuns",
//            "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/5E8FA748-1FF5-4518-BD6E-50773059C370\/relationships\/buildRuns"
//          }
//        },
//        "workflows" : {
//          "links" : {
//            "related" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/5E8FA748-1FF5-4518-BD6E-50773059C370\/workflows",
//            "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/5E8FA748-1FF5-4518-BD6E-50773059C370\/relationships\/workflows"
//          }
//        },
//        "primaryRepositories" : {
//          "links" : {
//            "related" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/5E8FA748-1FF5-4518-BD6E-50773059C370\/primaryRepositories",
//            "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/5E8FA748-1FF5-4518-BD6E-50773059C370\/relationships\/primaryRepositories"
//          }
//        }
//      },
//      "links" : {
//        "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/5E8FA748-1FF5-4518-BD6E-50773059C370"
//      },
//      "type" : "ciProducts",
//      "attributes" : {
//        "name" : "Mutaro",
//        "createdDate" : "2023-01-09T11:11:35.756Z",
//        "productType" : "APP"
//      }
//    },
//    {
//      "id" : "97BFBDE6-C16F-466A-9586-6A3393937B5E",
//      "relationships" : {
//        "app" : {
//          "links" : {
//            "related" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/97BFBDE6-C16F-466A-9586-6A3393937B5E\/app",
//            "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/97BFBDE6-C16F-466A-9586-6A3393937B5E\/relationships\/app"
//          }
//        },
//        "additionalRepositories" : {
//          "links" : {
//            "related" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/97BFBDE6-C16F-466A-9586-6A3393937B5E\/additionalRepositories",
//            "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/97BFBDE6-C16F-466A-9586-6A3393937B5E\/relationships\/additionalRepositories"
//          }
//        },
//        "buildRuns" : {
//          "links" : {
//            "related" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/97BFBDE6-C16F-466A-9586-6A3393937B5E\/buildRuns",
//            "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/97BFBDE6-C16F-466A-9586-6A3393937B5E\/relationships\/buildRuns"
//          }
//        },
//        "workflows" : {
//          "links" : {
//            "related" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/97BFBDE6-C16F-466A-9586-6A3393937B5E\/workflows",
//            "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/97BFBDE6-C16F-466A-9586-6A3393937B5E\/relationships\/workflows"
//          }
//        },
//        "primaryRepositories" : {
//          "links" : {
//            "related" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/97BFBDE6-C16F-466A-9586-6A3393937B5E\/primaryRepositories",
//            "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/97BFBDE6-C16F-466A-9586-6A3393937B5E\/relationships\/primaryRepositories"
//          }
//        }
//      },
//      "links" : {
//        "self" : "https:\/\/api.appstoreconnect.apple.com\/v1\/ciProducts\/97BFBDE6-C16F-466A-9586-6A3393937B5E"
//      },
//      "type" : "ciProducts",
//      "attributes" : {
//        "name" : "MutaroDev",
//        "createdDate" : "2023-05-15T11:27:35.332Z",
//        "productType" : "APP"
//      }
//    }
//  ],
//  "meta" : {
//    "paging" : {
//      "total" : 2,
//      "limit" : 50
//    }
//  }
// }
