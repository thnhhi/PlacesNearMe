//
//  HomeInteractor.swift
//  PlacesNearMe
//
//  Created by VTVH on 17/7/25.
//

protocol HomeInteractorInputProtocol {
    func getCategoryPlaces()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func didGetCategoryPlaces(_ categoryPlace: [CategoryPlace])
}

class HomeInteractor: HomeInteractorInputProtocol {
    weak var presenter: HomeInteractorOutputProtocol?
    
    func getCategoryPlaces() {
        let arrCategoryPlace = [
            CategoryPlace(img: "car_dealer.png", nameEn: "EV charging station", nameVi: "Trạm sạc xe điện", type: "electric_vehicle_charging_station", keyword: "EV charging station"),
            CategoryPlace(img: "restaurant.png", nameEn: "Restaurant", nameVi: "Nhà hàng", type: "restaurant", keyword: ""),
            CategoryPlace(img: "coffee_shops.png", nameEn: "Cafe", nameVi: "Cafe", type: "cafe", keyword: ""),
            CategoryPlace(img: "atm.png", nameEn: "ATM", nameVi: "ATM", type: "atm", keyword: ""),
            CategoryPlace(img: "bank.png", nameEn: "Bank", nameVi: "Ngân hàng", type: "bank", keyword: ""),
            
            CategoryPlace(img: "post_office.png", nameEn: "Post office", nameVi: "Bưu điện", type: "post_office", keyword: ""),
            CategoryPlace(img: "gas_station.png", nameEn: "Gas station", nameVi: "Trạm xăng", type: "gas_station", keyword: ""),
            CategoryPlace(img: "parking.png", nameEn: "Parking", nameVi: "Bãi đỗ xe", type: "parking", keyword: ""),
            CategoryPlace(img: "lodging.png", nameEn: "Hotel", nameVi: "Khách sạn", type: "lodging", keyword: ""),
            CategoryPlace(img: "convenience_store.png", nameEn: "Convenience store", nameVi: "Cửa hàng tiện lợi", type: "convenience_store", keyword: ""),
            
            CategoryPlace(img: "supermarket.png", nameEn: "Supermarket", nameVi: "Siêu thị", type: "supermarket", keyword: ""),
            CategoryPlace(img: "police.png", nameEn: "Police", nameVi: "Công an", type: "police", keyword: ""),
            CategoryPlace(img: "police.png", nameEn: "Fire station", nameVi: "Trạm cứu hoả", type: "fire_station", keyword: ""),
            CategoryPlace(img: "library.png", nameEn: "Library", nameVi: "Thư viện", type: "library", keyword: ""),
            CategoryPlace(img: "hospital.png", nameEn: "Hospital", nameVi: "Bệnh viện", type: "hospital", keyword: ""),
            
            CategoryPlace(img: "hospital.png", nameEn: "Doctor", nameVi: "Bác sĩ", type: "hospital", keyword: "doctor"),
            CategoryPlace(img: "hospital.png", nameEn: "Dentist", nameVi: "Nha sĩ", type: "hospital", keyword: "dentist"),
            CategoryPlace(img: "pharmacy.png", nameEn: "Pharmacy", nameVi: "Nhà thuốc", type: "pharmacy", keyword: ""),
            CategoryPlace(img: "veterinary_care.png", nameEn: "Veterinary care", nameVi: "Thú y", type: "veterinary_care", keyword: ""),
            CategoryPlace(img: "school.png", nameEn: "School", nameVi: "Trường học", type: "school", keyword: ""),
            
            CategoryPlace(img: "clothing_store.png", nameEn: "Clothing store", nameVi: "Cửa hàng quần áo", type: "clothing_store", keyword: ""),
            CategoryPlace(img: "shoe_store.png", nameEn: "Shoe store", nameVi: "Cửa hàng giày dép", type: "shoe_store", keyword: ""),
            CategoryPlace(img: "electronics_store.png", nameEn: "Electronics store", nameVi: "Cửa hàng điện tử", type: "electronics_store", keyword: ""),
            CategoryPlace(img: "furniture_store.png", nameEn: "Furniture store", nameVi: "Cửa hàng nội thất", type: "furniture_store", keyword: ""),
            CategoryPlace(img: "sport.png", nameEn: "Sport store", nameVi: "Cửa hàng thể thao", type: "store", keyword: "sport"),
            
            CategoryPlace(img: "sport.png", nameEn: "Gym", nameVi: "Phòng gym", type: "gym", keyword: ""),
            CategoryPlace(img: "book_store.png", nameEn: "Book Store", nameVi: "Nhà sách", type: "book_store", keyword: ""),
            CategoryPlace(img: "car_dealer.png", nameEn: "Car dealer", nameVi: "Đại lý xe hơi", type: "car_dealer", keyword: ""),
            CategoryPlace(img: "computer.png", nameEn: "Computer store", nameVi: "Máy tính", type: "electronics_store", keyword: "computer"),
            CategoryPlace(img: "clothing_store.png", nameEn: "Jewelry store", nameVi: "Cửa hàng trang sức", type: "jewelry_store", keyword: ""),
            
            CategoryPlace(img: "veterinary_care.png", nameEn: "Pet store", nameVi: "Cửa hàng thú cưng", type: "store", keyword: "pet"),
            CategoryPlace(img: "bar.png", nameEn: "Bar", nameVi: "Bar", type: "bar", keyword: ""),
            CategoryPlace(img: "karaoke.png", nameEn: "Karaoke", nameVi: "Karaoke", type: "night_club", keyword: "karaoke"),
            CategoryPlace(img: "bakery.png", nameEn: "bakery", nameVi: "Tiệm bánh", type: "bakery", keyword: ""),
            CategoryPlace(img: "movie_theater.png", nameEn: "Movie theater", nameVi: "Rạp chiếu phim", type: "movie_theater", keyword: ""),
            
            CategoryPlace(img: "museum.png", nameEn: "Museum", nameVi: "Bảo tàng", type: "museum", keyword: ""),
            CategoryPlace(img: "stadium.png", nameEn: "Stadium", nameVi: "Sân vận động", type: "stadium", keyword: ""),
            CategoryPlace(img: "park.png", nameEn: "Park", nameVi: "Công viên", type: "park", keyword: ""),
            CategoryPlace(img: "zoo.png", nameEn: "Zoo", nameVi: "Sở thú", type: "zoo", keyword: ""),
            CategoryPlace(img: "spa.png", nameEn: "Spa", nameVi: "Spa", type: "spa", keyword: ""),
            
            CategoryPlace(img: "hair.png", nameEn: "Hair care", nameVi: "Salon tóc", type: "hair_care", keyword: ""),
            CategoryPlace(img: "beauty_salon.png", nameEn: "Beauty salon", nameVi: "Thẩm mỹ viện", type: "beauty_salon", keyword: ""),
            CategoryPlace(img: "travel_agency.png", nameEn: "Travel agency", nameVi: "Đại lý du lịch", type: "travel_agency", keyword: ""),
            CategoryPlace(img: "airport.png", nameEn: "Airport", nameVi: "Sân bay", type: "airport", keyword: ""),
            CategoryPlace(img: "bus_station.png", nameEn: "Bus station", nameVi: "Bến xe buýt", type: "bus_station", keyword: ""),
            
            CategoryPlace(img: "train_station.png", nameEn: "Train station", nameVi: "Ga xe lửa", type: "train_station", keyword: ""),
            CategoryPlace(img: "real_estate_agency.png", nameEn: "Real estate agency", nameVi: "Bất động sản", type: "real_estate_agency", keyword: ""),
            CategoryPlace(img: "cemetery.png", nameEn: "Cemetery", nameVi: "Nghĩa trang", type: "cemetery", keyword: ""),
            CategoryPlace(img: "church.png", nameEn: "Church", nameVi: "Nhà thờ", type: "church", keyword: ""),
        ]
        presenter?.didGetCategoryPlaces(arrCategoryPlace)
    }
}
