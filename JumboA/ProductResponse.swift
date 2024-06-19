import Foundation

struct ProductResponse: Decodable {
    let products: ProductsData
    
    struct ProductsData: Decodable {
        let data: [Product]
        let total: Int
    }
}

struct Product: Identifiable, Decodable, Equatable {
    let id: String
    let title: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageInfo = "imageInfo"
        
        enum ImageInfoKeys: String, CodingKey {
            case primaryView = "primaryView"
        }
        
        enum PrimaryViewKeys: String, CodingKey {
            case url = "url"
        }
    }
    
    init(id: String, title: String, imageURL: String) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        
        let imageInfoContainer = try container.nestedContainer(keyedBy: CodingKeys.ImageInfoKeys.self, forKey: .imageInfo)
        var primaryViewContainer = try imageInfoContainer.nestedUnkeyedContainer(forKey: .primaryView)
        let primaryViewItem = try primaryViewContainer.nestedContainer(keyedBy: CodingKeys.PrimaryViewKeys.self)
        imageURL = try primaryViewItem.decode(String.self, forKey: .url)
    }
}
