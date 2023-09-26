//
//  MongoConstants.swift
//  SocialConnect
//
//  Created by Patricio Villarreal Welsh on 26/09/23.
//

import Foundation
let mongoBaseUrl: String = "http://localhost:3000"
let mongoApiAuth = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOnsiX2lkIjoiNjUxMGViM2MxM2UyMzRiNjNiZGUxNjkyIiwiZmlyc3ROYW1lIjoiUGF0cmljaW8iLCJsYXN0TmFtZSI6IlZpbGxhcnJlYWwiLCJlbWFpbCI6InBhdG92d0BnbWFpbC5jb20iLCJwaG9uZU51bWJlciI6IjgxMTU5MTQxNDQiLCJyb2xlIjoiNjUxMGVhZTExM2UyMzRiNjNiZGUxNjhhIn0sImlhdCI6MTY5NTc1MDYxMywiZXhwIjoxNjk1ODM3MDEzfQ.OaWPm6zYc2rCFX7tG6mUa0n5j9SeEF2m_83iqtAjkoo"
let mongoHeaders = [ "Authorization": "Bearer \(mongoApiAuth)", "Accept": "application/json", "Content-Type": "application/json" ]
