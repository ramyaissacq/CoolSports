//
//  TeamPlayerTransferData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on December 19, 2022
//
import Foundation
import SwiftyJSON

struct TeamPlayerTransferData {

	let id: Int?
	let playId: Int?
	let transferTime: String?
	let endTime: String?
	let fromTeamEn: String?
	let fromTeamChs: String?
	let fromTeamCht: String?
	let fromTeamId: Int?
	let toTeamEn: String?
	let toTeamChs: String?
	let toTeamCht: String?
	let toTeamId: Int?
	let money: String?
	let season: String?
	let typeEn: String?
	let tpyeCn: String?
	let updateTime: String?
	let playerName: String?
	let playerNameChs: String?
	let playerNameCn: String?
	let playerNameEn: String?
	let playerPhoto: String?
	let playerNameId: String?
	let playerNameVi: String?
	let typeCn: String?
	let fromTeamNameCn: String?
	let toTeamNameCn: String?
	let fromTeamNameEn: String?
	let toTeamNameEn: String?
	let fromTeamNameId: String?
	let toTeamNameId: String?
	let fromTeamNameVi: String?
	let toTeamNameVi: String?

	init(_ json: JSON) {
		id = json["id"].intValue
		playId = json["playId"].intValue
		transferTime = json["transferTime"].stringValue
		endTime = json["endTime"].stringValue
		fromTeamEn = json["fromTeamEn"].stringValue
		fromTeamChs = json["fromTeamChs"].stringValue
		fromTeamCht = json["fromTeamCht"].stringValue
		fromTeamId = json["fromTeamId"].intValue
		toTeamEn = json["toTeamEn"].stringValue
		toTeamChs = json["toTeamChs"].stringValue
		toTeamCht = json["toTeamCht"].stringValue
		toTeamId = json["toTeamId"].intValue
		money = json["money"].stringValue
		season = json["season"].stringValue
		typeEn = json["typeEn"].stringValue
		tpyeCn = json["tpyeCn"].stringValue
		updateTime = json["updateTime"].stringValue
		playerName = json["playerName"].stringValue
		playerNameChs = json["playerNameChs"].stringValue
		playerNameCn = json["playerNameCn"].stringValue
		playerNameEn = json["playerNameEn"].stringValue
		playerPhoto = json["playerPhoto"].stringValue
		playerNameId = json["playerNameId"].stringValue
		playerNameVi = json["playerNameVi"].stringValue
		typeCn = json["typeCn"].stringValue
		fromTeamNameCn = json["fromTeamNameCn"].stringValue
		toTeamNameCn = json["toTeamNameCn"].stringValue
		fromTeamNameEn = json["fromTeamNameEn"].stringValue
		toTeamNameEn = json["toTeamNameEn"].stringValue
		fromTeamNameId = json["fromTeamNameId"].stringValue
		toTeamNameId = json["toTeamNameId"].stringValue
		fromTeamNameVi = json["fromTeamNameVi"].stringValue
		toTeamNameVi = json["toTeamNameVi"].stringValue
	}

}