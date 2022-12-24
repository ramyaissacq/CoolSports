//
//  TeamPlayerData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on December 19, 2022
//
import Foundation
import SwiftyJSON

struct TeamPlayerData {

	let id: Int?
	let playerId: Int?
	let nameEn: String?
	let nameChs: String?
	let nameCht: String?
	let birthday: String?
	let height: String?
	let weight: String?
	let countryEn: String?
	let countryCn: String?
	let countryId: String?
	let photo: String?
	let value: String?
	let feetEn: String?
	let feetCn: String?
	let introduceEn: String?
	let introduceCn: String?
	let teamID: Int?
	let positionEn: String?
	let positionCn: String?
	let number: String?
	let endDateContract: String?
	let nameCn: String?

	init(_ json: JSON) {
		id = json["id"].intValue
		playerId = json["playerId"].intValue
		nameEn = json["nameEn"].stringValue
		nameChs = json["nameChs"].stringValue
		nameCht = json["nameCht"].stringValue
		birthday = json["birthday"].stringValue
		height = json["height"].stringValue
		weight = json["weight"].stringValue
		countryEn = json["countryEn"].stringValue
		countryCn = json["countryCn"].stringValue
		countryId = json["countryId"].stringValue
		photo = json["photo"].stringValue
		value = json["value"].stringValue
		feetEn = json["feetEn"].stringValue
		feetCn = json["feetCn"].stringValue
		introduceEn = json["introduceEn"].stringValue
		introduceCn = json["introduceCn"].stringValue
		teamID = json["teamID"].intValue
		positionEn = json["positionEn"].stringValue
		positionCn = json["positionCn"].stringValue
		number = json["number"].stringValue
		endDateContract = json["endDateContract"].stringValue
		nameCn = json["nameCn"].stringValue
	}

}