//
//  PhotoList.swift
//  straiberry
//
//  Created by Behnam on 20.06.22.
//

import Foundation

// MARK: - PhotoList
class PhotoList: Codable {
    var photos: Photos?
    var stat: String?

    init(photos: Photos?, stat: String?) {
        self.photos = photos
        self.stat = stat
    }
}

// MARK: PhotoList convenience initializers and mutators

extension PhotoList {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PhotoList.self, from: data)
        self.init(photos: me.photos, stat: me.stat)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        photos: Photos?? = nil,
        stat: String?? = nil
    ) -> PhotoList {
        return PhotoList(
            photos: photos ?? self.photos,
            stat: stat ?? self.stat
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Photos
class Photos: Codable {
    var page, pages, perpage, total: Int?
    var photo: [Photo]?

    init(page: Int?, pages: Int?, perpage: Int?, total: Int?, photo: [Photo]?) {
        self.page = page
        self.pages = pages
        self.perpage = perpage
        self.total = total
        self.photo = photo
    }
}

// MARK: Photos convenience initializers and mutators

extension Photos {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Photos.self, from: data)
        self.init(page: me.page, pages: me.pages, perpage: me.perpage, total: me.total, photo: me.photo)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        page: Int?? = nil,
        pages: Int?? = nil,
        perpage: Int?? = nil,
        total: Int?? = nil,
        photo: [Photo]?? = nil
    ) -> Photos {
        return Photos(
            page: page ?? self.page,
            pages: pages ?? self.pages,
            perpage: perpage ?? self.perpage,
            total: total ?? self.total,
            photo: photo ?? self.photo
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Photo
class Photo: Codable {
    var id, owner, secret, server: String?
    var farm: Int?
    var title: String?
    var ispublic, isfriend, isfamily: Int?

    init(id: String?, owner: String?, secret: String?, server: String?, farm: Int?, title: String?, ispublic: Int?, isfriend: Int?, isfamily: Int?) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily
    }
}

// MARK: Photo convenience initializers and mutators

extension Photo {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Photo.self, from: data)
        self.init(id: me.id, owner: me.owner, secret: me.secret, server: me.server, farm: me.farm, title: me.title, ispublic: me.ispublic, isfriend: me.isfriend, isfamily: me.isfamily)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        owner: String?? = nil,
        secret: String?? = nil,
        server: String?? = nil,
        farm: Int?? = nil,
        title: String?? = nil,
        ispublic: Int?? = nil,
        isfriend: Int?? = nil,
        isfamily: Int?? = nil
    ) -> Photo {
        return Photo(
            id: id ?? self.id,
            owner: owner ?? self.owner,
            secret: secret ?? self.secret,
            server: server ?? self.server,
            farm: farm ?? self.farm,
            title: title ?? self.title,
            ispublic: ispublic ?? self.ispublic,
            isfriend: isfriend ?? self.isfriend,
            isfamily: isfamily ?? self.isfamily
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
