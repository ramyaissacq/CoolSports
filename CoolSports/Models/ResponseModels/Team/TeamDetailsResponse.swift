//
//  TeamDetailsResponse.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on December 19, 2022
//
import Foundation
import SwiftyJSON

struct TeamDetailsResponse {

	let teamInfoData: [TeamInfoData]?
	let teamPlayerData: [TeamPlayerData]?
	let teamPlayerTransferData: [TeamPlayerTransferData]?

	init(_ json: JSON) {
		teamInfoData = json["teamInfoData"].arrayValue.map { TeamInfoData($0) }
		teamPlayerData = json["teamPlayerData"].arrayValue.map { TeamPlayerData($0) }
		teamPlayerTransferData = json["teamPlayerTransferData"].arrayValue.map { TeamPlayerTransferData($0) }
	}

}