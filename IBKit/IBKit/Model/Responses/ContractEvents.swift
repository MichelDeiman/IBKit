//
//  ContractEvents.swift
//	IBKit
//
//	Copyright (c) 2016-2023 Sten Soosaar
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.
//




import Foundation


public struct IBContractDetails: Decodable, IBMarketEvent {
	
	public var requestID: Int
	
	public var contract: IBContract
	
	
	/// For derivatives, the symbol of the underlying contract.
	public var underlyingSymbol: String?
	
	/// For derivatives, returns the underlying security type.
	public var underlyingSecurityType: IBSecuritiesType?
	
	
	/// Real expiration date. Requires TWS 968+ and API v973.04+. Python API specifically requires API v973.06+.
	public var realExpirationDate: Date?
	
	/// Typically the contract month of the underlying for a Future contract.
	public var contractMonth: String?
	
	var includeExpired: Bool = false
	
	/// The market name for this product.
	public var marketName: String?
	
	/// The minimum allowed price variation. Note that many securities vary their minimum tick size according to their price.
	/// This value will only show the smallest of the different minimum tick sizes regardless of the product's price. 
	public var minimumTick: Double
	
	/// Allows execution and strike prices to be reported consistently with market data, historical data and the order price, i.e. Z on LIFFE is reported in Index points and not GBP.
	public var priceMagnifier: Double?
	
	/// Returns the size multiplier for values returned to tickSize from a market data request. Generally 100 for US stocks and 1 for other instruments.
	public var mdSizeMultiplier: Double?
	
	public var multiplier: Double?  {
		return contract.multiplier
	}
	
	/// Supported order types for this product.*/
	public var orderTypes: [String]?
	
	/// Valid exchange fields when placing an order for this contract. The list of exchanges will is provided in the same order as the corresponding MarketRuleIds list.
	public var validExchanges: [String]?
	
	/// For derivatives, the contract ID (conID) of the underlying instrument.
	public var underlyingContractID: Int?
	
	/// Descriptive name of the product.*/
	public var longName: String?
	
	/// The industry classification of the underlying/product. For example, Financial
	public var industry: String?
	
	/// The industry category of the underlying. For example, InvestmentSvc
	public var category: String?
	
	/// The industry subcategory of the underlying. For example, Brokerage
	public var subcategory: String?
	
	/// The time zone for the trading hours of the product. For example, EST
	public var timeZoneID: String?
	
	/// The trading hours of the product.
	public var tradingHours: [IBTradingHour]?
	
	/// The liquid hours of the product.
	public var liquidHours: [IBTradingHour]?
	
	/// Contains the Economic Value Rule name and the respective optional argument.
	/// The two values should be separated by a colon. For example, aussieBond:YearsToExpiration=3.
	/// When the optional argument is not present, the first value will be followed by a colon.
	public var evRule: String?
	
	/// Tells you approximately how much the market value of a contract would change if the price were to change by 1.
	///  It cannot be used to get market value by multiplying the price by the approximate multiplier
	public var evMultiplier: Double?
	
	/// A list of contract identifiers that the customer is allowed to view. CUSIP/ISIN/etc.
	///  For US stocks, receiving the ISIN requires the CUSIP market data subscription.
	///  For Bonds, the CUSIP or ISIN is input directly into the symbol field of the Contract class.
	public var secIdList: [IBContract.SecurityID] = []
	
	
	/// Aggregated group Indicates the smart-routing group to which a contract belongs. contracts which cannot be smart-routed have aggGroup = -1.
	public var aggGroup: Int?
	
	
	/// The list of market rule IDs separated by comma Market rule IDs can be used to determine the minimum price increment at a given price.
	public var marketRuleIds: String?
	
	
	// BOND values
	
	/// The nine-character bond CUSIP. For Bonds only. Receiving CUSIPs requires a CUSIP market data subscription.*/
	public var cusip: String?
	
	/// Identifies the credit rating of the issuer. This field is not currently available from the TWS API. For Bonds only.
	/// A higher credit rating generally indicates a less risky investment. Bond ratings are from Moody's and S&P respectively.
	/// Not currently implemented due to bond market data restrictions.
	public var ratings: String?
	
	/// A description string containing further descriptive information about the bond. For Bonds only.*/
	public var descAppend: String?
	
	///  The type of bond, such as "CORP."
	public var bondType: String?
	
	/// The type of bond coupon. This field is currently not available from the TWS API. For Bonds only.
	public var couponType: String?
	
	/// If true, the bond can be called by the issuer under certain conditions. This field is currently not available from the TWS API. For Bonds only.
	public var callable: Bool?
	
	/// Values are True or False. If true, the bond can be sold back to the issuer under certain conditions. This field is currently not available from the TWS API. For Bonds only.
	public var putable: Bool?
	
	/// The interest rate used to calculate the amount you will receive in interest payments over the course of the year. This field is currently not available from the TWS API. For Bonds only
	public var coupon: Double?
	
	/// Values are True or False. If true, the bond can be converted to stock under certain conditions. This field is currently not available from the TWS API. For Bonds only.
	public var convertible: Bool?
	
	/// The date on which the issuer must repay the face value of the bond. This field is currently not available from the TWS API. For Bonds only. Not currently implemented due to bond market data restrictions.*/
	public var maturity: Date?
	
	/// The date the bond was issued. This field is currently not available from the TWS API. For Bonds only. Not currently implemented due to bond market data restrictions.
	public var issueDate: Date?
	
	/// Only if bond has embedded options. This field is currently not available from the TWS API. Refers to callable bonds and puttable bonds. Available in TWS description window for bonds.
	public var nextOptionDate: Date?
	
	/// Type of embedded option. This field is currently not available from the TWS API. Only if bond has embedded options.
	public var nextOptionType: String?
	
	/// Only if bond has embedded options. This field is currently not available from the TWS API. For Bonds only.
	public var nextOptionPartial: Bool?
	
	/// If populated for the bond in IB's database. For Bonds only.
	public var notes: String?
	
	
	public init(from decoder: Decoder) throws {
		
		guard let decoder = decoder as? IBDecoder,
			  let serverVersion = decoder.serverVersion else {
			throw IBError.codingError("No server version found. Check the connection!")
		}

		var container = try decoder.unkeyedContainer()
		let version = try container.decode(Int.self)
			
		self.requestID = version >= 3 ? try container.decode(Int.self) : -1

		let symbol = try container.decode(String.self)
		let type = try container.decode(IBSecuritiesType.self)
		let expiration = try container.decodeOptional(Date.self)
		let strikePrice = try container.decodeOptional(Double.self)
		let executionRight = try container.decodeOptional(IBContract.ExecutionRight.self)
		let exchange = try container.decode(IBExchange.self)
		let currency = try container.decode(String.self)
		let localSymbol = try container.decode(String.self)
		self.marketName = try container.decode(String.self)
		let tradingClass = try container.decode(String.self)
		let contractId = try container.decode(Int.self)
		self.minimumTick = try container.decode(Double.self)
		
		
		
		if serverVersion >= IBServerVersion.MD_SIZE_MULTIPLIER{
			self.mdSizeMultiplier = try container.decodeOptional(Double.self)
		}
		
		let multiplier = try container.decodeOptional(Double.self)
		self.orderTypes = try container.decode(String.self).components(separatedBy: ",")
		self.validExchanges = try container.decode(String.self).components(separatedBy: ",")
		self.priceMagnifier = try container.decode(Double.self)
		self.underlyingContractID = try container.decode(Int.self)
		self.longName = try container.decode(String.self)
		let primaryExchange = try container.decodeOptional(IBExchange.self)

		self.contract = IBContract(conId: contractId, symbol: symbol, secType: type, currency: currency, expiration: expiration,
								  strike: strikePrice, right: executionRight, multiplier: multiplier, exchange: exchange,
								  primaryExchange: primaryExchange, localSymbol: localSymbol,
								  tradingClass: tradingClass)

		
		
		if version >= 6 {
			self.contractMonth = try container.decodeOptional(String.self)
			self.industry = try container.decodeOptional(String.self)
			self.category = try container.decodeOptional(String.self)
			self.subcategory = try container.decodeOptional(String.self)
			self.timeZoneID = try container.decode(String.self)

			self.tradingHours = try container.decode(String.self).components(separatedBy: ";").filter{$0.count > 0}.map{
				IBTradingHour(string: $0, zone: self.timeZoneID!)
			}

			self.liquidHours = try container.decode(String.self).components(separatedBy: ";").filter{$0.count > 0}.map{
				IBTradingHour(string: $0, zone: self.timeZoneID!)
			}
		}
		
		if version >= 8 {
			self.evRule = try container.decodeOptional(String.self)
			self.evMultiplier = try container.decodeOptional(Double.self)
		}
		
		if version >= 7 {
			let count = try container.decode(Int.self)
			for _ in 0..<count{
				let value = try container.decode(IBContract.SecurityID.self)
				self.secIdList.append(value)
			}
		}
		
		if serverVersion >= IBServerVersion.AGG_GROUP{
			self.aggGroup = try container.decodeOptional(Int.self)
		}
		
		if serverVersion >= IBServerVersion.UNDERLYING_INFO{
			self.underlyingSymbol = try container.decodeOptional(String.self)
			self.underlyingSecurityType = try container.decodeOptional(IBSecuritiesType.self)
		}
		
		if serverVersion >= IBServerVersion.MARKET_RULES {
			self.marketRuleIds = try container.decodeOptional(String.self)
		}

		if serverVersion >= IBServerVersion.REAL_EXPIRATION_DATE {
			self.realExpirationDate = try container.decodeOptional(Date.self)
		}
	}
	
}


public struct IBContractDetailsEnd: Decodable, IBMarketEvent {
	
	public var requestID: Int
	
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		_ = try container.decode(Int.self)
		self.requestID = try container.decode(Int.self)
	}

}


public struct IBOptionChain: Decodable, IBMarketEvent {
	
	public var requestID: Int
	public var exchange: String
	public var underlyingContractId: Int
	public var tradingClass : String
	public var multiplier: String
	public var expirations: [Date] = []
	public var strikes: [Double] = []

	public init(from decoder: Decoder) throws {
		
		var container = try decoder.unkeyedContainer()
		
		requestID = try container.decode(Int.self)
		exchange = try container.decode(String.self)
		underlyingContractId = try container.decode(Int.self)
		tradingClass = try container.decode(String.self)
		multiplier = try container.decode(String.self)
		
		let expCount = try container.decode(Int.self)
		
		if let decoder = decoder as? IBDecoder{
			decoder.dateFormatter.dateFormat = "yyyyMMdd"
		}
		
		for _ in 0..<expCount{
			let expiration = try container.decode(Date.self)
			expirations.append(expiration)
		}

		let strikeCount = try container.decode(Int.self)
		for _ in 0..<strikeCount{
			let strike = try container.decode(Double.self)
			strikes.append(strike)
		}

	}

}


public struct IBOptionChainEnd: Decodable, IBMarketEvent {
	
	public var requestID: Int
	
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		self.requestID = try container.decode(Int.self)
	}

}


public struct IBContractSearchResult: Decodable, IBSystemEvent {
	
	public struct Contract: Decodable {
		
		let contractID: Int
		let symbol: String
		let type: IBSecuritiesType
		let primaryExchange: String
		let currency: String
		var availableTypes: [IBSecuritiesType]
		
		public init(from decoder: Decoder) throws {
			var container = try decoder.unkeyedContainer()
			self.contractID = try container.decode(Int.self)
			self.symbol = try container.decode(String.self)
			self.type = try container.decode(IBSecuritiesType.self)
			self.primaryExchange = try container.decode(String.self)
			self.currency = try container.decode(String.self)
			let derivateCount = try container.decode(Int.self)
			availableTypes = []
			for _ in 0..<derivateCount{
				let obj = try container.decode(IBSecuritiesType.self)
				availableTypes.append(obj)
			}
		}

	}
	
	let requestId: Int
	
	var values: [Contract] = []
	
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		requestId = try container.decode(Int.self)
		let resultCount = try container.decode(Int.self)
		for _ in 0..<resultCount {
			let object = try container.decode(Contract.self)
			values.append(object)
		}
	}

}


public struct IBFinancialReport: Decodable, IBMarketEvent {
	
	public var requestID: Int

	public var xml: XMLDocument
	
	public init(from decoder: Decoder) throws {
		
		var container = try decoder.unkeyedContainer()
		_ = try container.decode(Int.self)
		requestID = try container.decode(Int.self)
		let content = try container.decode(String.self)
		xml = try XMLDocument(xmlString: content)
	}
	
}
