//
//  SystemEvents.swift
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



public struct IBServerTime: IBSystemEvent {
	public let time: Date
}

extension IBServerTime: Decodable {
	
	public init(from decoder: Decoder) throws {

		var container = try decoder.unkeyedContainer()
		_ = try container.decode(Int.self)
		let unixTimestamp = try container.decode(Double.self)
		time = Date(timeIntervalSince1970: unixTimestamp)
	}
	
}




public struct IBNextRequestIdentifier: IBSystemEvent {
	public let value: Int
}

extension IBNextRequestIdentifier: Decodable {
	
	public init(from decoder: Decoder) throws {

		var container = try decoder.unkeyedContainer()
		_ = try container.decode(Int.self)
		value = try container.decode(Int.self)

	}
	
}




public struct IBServerError: IBSystemEvent {
	public let reqId: Int
	public let errorCode: Int
	public let errorString: String
	public let userInfo: String?
}

extension IBServerError: Decodable {
	
	public init(from decoder: Decoder) throws {
		
		guard let decoder = decoder as? IBDecoder, let serverVersion = decoder.serverVersion else {
			throw IBError.codingError("Decoder didn't found a server version. Check the connection!")
		}
		
		var container = try decoder.unkeyedContainer()
		_ = try container.decode(Int.self)
		self.reqId = try container.decode(Int.self)
		self.errorCode = try container.decode(Int.self)
		self.errorString = try container.decode(String.self)
		self.userInfo = serverVersion >= IBServerVersion.ADVANCED_ORDER_REJECT ? try container.decode(String.self) : nil
		
	}
	
}
