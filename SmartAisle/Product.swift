import Foundation

struct ProductSearchResponse: Decodable {
    let products: ProductsData
}

struct ProductsData: Decodable {
    let data: [Product]
}

struct ProductDetailResponse: Decodable {
    let product: ProductData
}

struct ProductData: Decodable {
    let data: Product
}

struct Product: Identifiable, Codable, Hashable {
    var id: String
    var title: String
    var prices: Prices
    var imageInfo: ImageInfo
    var quantity: String
    var description: String?
    var ingredients: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, prices, imageInfo, quantity, description
        case ingredients = "ingredientInfo"
    }
    
    struct IngredientInfo: Decodable {
        var ingredients: [Ingredient]
        
        enum CodingKeys: String, CodingKey {
            case ingredients
        }
    }
    
    struct Ingredient: Codable, Hashable {
        var name: String
    }
    
    // Custom decoder to handle nested ingredient names
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        prices = try container.decode(Prices.self, forKey: .prices)
        imageInfo = try container.decode(ImageInfo.self, forKey: .imageInfo)
        quantity = try container.decode(String.self, forKey: .quantity)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        
        // Decode ingredients
        if let ingredientInfo = try container.decodeIfPresent([IngredientInfo].self, forKey: .ingredients) {
            ingredients = ingredientInfo.first?.ingredients.map { $0.name }.joined(separator: ", ")
        } else {
            ingredients = nil
        }
    }
    
    // Explicit initializer for direct initialization
    init(id: String, title: String, prices: Prices, imageInfo: ImageInfo, quantity: String, description: String?, ingredients: String?) {
        self.id = id
        self.title = title
        self.prices = prices
        self.imageInfo = imageInfo
        self.quantity = quantity
        self.description = description
        self.ingredients = ingredients
    }
}

struct Prices: Codable, Hashable {
    var price: Price
}

struct Price: Codable, Hashable {
    var amount: Double
}

struct ImageInfo: Codable, Hashable {
    var primaryView: [ImageView]
}

struct ImageView: Codable, Hashable {
    var url: String
}
