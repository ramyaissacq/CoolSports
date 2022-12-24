//
//  TeamInfoData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on December 19, 2022
//
import Foundation
import SwiftyJSON

struct TeamInfoData {

	let teamId: Int?
	let leagueId: Int?
	let nameEn: String?
	let nameChs: String?
	let nameCht: String?
	let foundingDate: String?
	let areaEn: String?
	let areaCn: String?
	let gymEn: String?
	let gymCn: String?
	let capacity: String?
	let logo: String?
	let addrEn: String?
	let addrCn: String?
	let website: String?
	let coachEn: String?
	let coachCn: String?
	let nameId: String?
	let areaId: String?
	let gymId: String?
	let coachId: String?
	let nameVi: String?
	let areaVi: String?
	let gymVi: String?
	let coachVi: String?
	let nameTh: String?
	let areaTh: String?
	let gymTh: String?
	let coachTh: String?
	let nameCn: String?

	init(_ json: JSON) {
		teamId = json["teamId"].intValue
		leagueId = json["leagueId"].intValue
		nameEn = json["nameEn"].stringValue
		nameChs = json["nameChs"].stringValue
		nameCht = json["nameCht"].stringValue
		foundingDate = json["foundingDate"].stringValue
		areaEn = json["areaEn"].stringValue
		areaCn = json["areaCn"].stringValue
		gymEn = json["gymEn"].stringValue
		gymCn = json["gymCn"].stringValue
		capacity = json["capacity"].stringValue
		logo = json["logo"].stringValue
		addrEn = json["addrEn"].stringValue
		addrCn = json["addrCn"].stringValue
		website = json["website"].stringValue
		coachEn = json["coachEn"].stringValue
		coachCn = json["coachCn"].stringValue
		nameId = json["nameId"].stringValue
		areaId = json["areaId"].stringValue
		gymId = json["gymId"].stringValue
		coachId = json["coachId"].stringValue
		nameVi = json["nameVi"].stringValue
		areaVi = json["areaVi"].stringValue
		gymVi = json["gymVi"].stringValue
		coachVi = json["coachVi"].stringValue
		nameTh = json["nameTh"].stringValue
		areaTh = json["areaTh"].stringValue
		gymTh = json["gymTh"].stringValue
		coachTh = json["coachTh"].stringValue
		nameCn = json["nameCn"].stringValue
	}

}