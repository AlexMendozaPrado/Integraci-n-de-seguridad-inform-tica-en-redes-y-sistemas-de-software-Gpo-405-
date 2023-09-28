//
//  MongoConstants.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 26/09/23.
//

import Foundation
let mongoBaseUrl: String = "http://10.14.255.179:3000"
let mongoApiAuth = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOnsiX2lkIjoiNjUxMGViM2MxM2UyMzRiNjNiZGUxNjkyIiwiZmlyc3ROYW1lIjoiUGF0cmljaW8iLCJsYXN0TmFtZSI6IlZpbGxhcnJlYWwiLCJlbWFpbCI6InBhdG92d0BnbWFpbC5jb20iLCJwaG9uZU51bWJlciI6IjgxMTU5MTQxNDQiLCJyb2xlIjoiNjUxMGVhZTExM2UyMzRiNjNiZGUxNjhhIn0sImlhdCI6MTY5NTk0MDM2Nn0.4-WZM25if4Vry06NBurKliDWUbsxexESy2c0CrLfv2o"
let mongoHeaders = [ "Authorization": "Bearer \(mongoApiAuth)", "Accept": "application/json", "Content-Type": "application/json" ]
