//
//  HomeStoreView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 12.09.2022.
//

import SwiftUI

struct ShopView: View {
    @EnvironmentObject var cartManager: CartManager
    @Binding var isActiveFilterView: Bool
    @State private var search: String = ""
    @State private var selectedIndex: Int = 0
    let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        NaviganionBarView(isActiveFilterView: $isActiveFilterView)
                        
                        CategoryScrollView()
                        
                        SearchProductView(search: $search)
                        
                        HotSalesScrollView()
                        
                        BestSellerScrolView()
                        
                        Spacer()
                    }
                    .frame(width: width)
                    .padding(.top, 45)
                }
            }
        }
        .background(Color(UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor))
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}

struct HomeStoreView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView(isActiveFilterView: .constant(false))
            .environmentObject(NetworkServiceManager())
            .environmentObject(CartManager())
    }
}

struct NaviganionBarView: View {
    @Binding var isActiveFilterView: Bool
    @State private var selectedPlace = 0
    let place = ["Zihuatanejo, Gro"]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image("map1")
                    .resizable()
                    .frame(width: 12,height: 15.31)
                    .padding(.leading, 128)
                
                Menu {
                    Picker("Place", selection: $selectedPlace) {
                        ForEach(place, id: \.self) { index in
                            Text(index)
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                                .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)))
                        }
                    }
                } label: {
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color(UIColor(red: 0.702, green: 0.702, blue: 0.702, alpha: 1).cgColor))
                            .padding(.leading, 8)
                    .overlay(
                        Text("\(place[selectedPlace])")
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)))
                            .padding(.leading, -130)
                    )
                    .padding(.leading, 130)
                }
                
                Spacer()
                
                Button {
                    print("Filter")
                    isActiveFilterView.toggle()
                } label: {
                    Image("filter")
                        .resizable()
                        .frame(width: 11, height: 13)
                }
                .padding(.trailing, 35)
            }
        }
    }
}

struct CategoryScrollView: View {
    @State private var selectedIndex: Int = 0
    private let category: [Category] = [
        Category(id: 0, image: "category_1", text: "Phones"),
        Category(id: 1, image: "category_2", text: "Computer"),
        Category(id: 2, image: "category_3", text: "Health"),
        Category(id: 3, image: "category_4", text: "Books"),
        Category(id: 4, image: nil, text: nil)]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("Select category")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                    
                    Spacer()
                    
                    Button {
                        print("View all")
                    } label: {
                        Text("view all")
                            .font(.system(size: 15))
                            .fontWeight(.regular)
                            .foregroundColor(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))
                    }
                }
                .padding(.leading, 17)
                .padding(.trailing, 33)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 23){
                    ForEach(category, id: \.id) { index in
                        Button {
                            selectedIndex = index.id
                        } label: {
                            CategoryView(isActive: selectedIndex == index.id, category: index)
                        }
                    }
                }
            }
            .padding(.top, 15)
            .padding(.horizontal, 27)
        }
        .padding(.top, 10)
    }
}

struct CategoryView: View {
    var isActive: Bool
    let category: Category
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(isActive ? Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor) : Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                    .shadow(color: Color(UIColor(red: 0.656, green: 0.669, blue: 0.788, alpha: 0.15).cgColor), radius: 20)
                    .frame(width: 71, height: 71)
                    .overlay(
                        RoundedRectangle (cornerRadius: 50)
                            .stroke(lineWidth: 0.5)
                            .foregroundColor(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor))
                    )
                
                Image(category.image)
                    .renderingMode(.template)
                    .foregroundColor(isActive ? Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor) : Color(UIColor(red: 0.702, green: 0.702, blue: 0.765, alpha: 1).cgColor))
            }
            .padding(.bottom, 7)
            
            Text(category.text)
                .font(.system(size: 12))
                .fontWeight(.medium)
                .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
        }
    }
}

struct SearchProductView: View {
    @Binding var search: String
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    HStack(spacing: 15) {
                        Image("search")
                            .resizable()
                            .frame(width: 13.52, height: 13.52)
                            .padding(.leading, 24)
                        
                        TextField("Search", text: $search)
                            .frame(height: 34)
                            
                    }
                    .background(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                    .frame(width: 300, height: 34)
                    .shadow(color: Color(UIColor(red: 0.75, green: 0.771, blue: 0.962, alpha: 0.15).cgColor), radius: 20)
                    .cornerRadius(50)
                  
                    Spacer()
                    
                    Button {
                        print("Search")
                    } label: {
                        Image("scan")
                            .resizable()
                            .frame(width: 14.78, height: 14.78)
                    }
                    .frame(width: 34, height: 34)
                    .background(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))
                    .shadow(color: Color(UIColor(red: 0.75, green: 0.771, blue: 0.962, alpha: 0.15).cgColor), radius: 20)
                    .cornerRadius(50)
                }
                .padding(.leading, 32)
                .padding(.trailing, 37)
            }
        }
        .frame(width: 300, height: 34)
        .padding(.top, 15)
    }
}


struct HotSalesScrollView: View {
    @State private var selectedIndex = 0
    @EnvironmentObject var networkServiceManager: NetworkServiceManager

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0){
                    Text("Hot sales")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                    
                    Spacer()
                    
                    Button {
                        print("See more")
                    } label: {
                        Text("see more")
                            .font(.system(size: 15))
                            .fontWeight(.regular)
                            .foregroundColor(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))
                    }
                }
                .padding(.leading, 17)
                .padding(.trailing, 33)
                    
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 21) {
                        ForEach(networkServiceManager.shopModels.first?.homeStore ?? [], id: \.id) { index in
                            HotSaleView(product: index)
                        }
                    }
                }
                .frame(width: 360,height: 182)
                .padding(.horizontal, 25)
            }
            .padding(.top, 10)
        }
    }
}

struct HotSaleView: View {
    let product: HomeStore

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor)
                
                AsyncImage(url: URL(string: product.picture ?? "")) { imageUrl in
                    if let image = imageUrl.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 360, height: 182)
                            .clipped()
                    }
                }
        
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        if product.isNew ?? false {
                            ZStack {
                                Circle()
                                    .frame(width: 27, height: 27)
                                    .foregroundColor(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))

                                Text("New")
                                    .font(.system(size: 10))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                            }
                        }

                        Text(product.title ?? "")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                            .padding(.top, 18)

                        Text(product.subtitle ?? "")
                            .font(.system(size: 11))
                            .fontWeight(.regular)
                            .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                            .padding(.top, 5)

                        Button {
                            print("Buy now")
                        } label: {
                            Text("Buy now!")
                                .font(.system(size: 11))
                                .fontWeight(.regular)
                                .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                        }
                        .frame(width: 98, height: 23)
                        .background(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                        .cornerRadius(5)
                        .padding(.top, 26)

                        Spacer()
                    }
                    .padding(.top, (product.isNew ?? false) ? 14 : 41)

                    Spacer()
                }
                .padding(.leading, 25)
            }
            .frame(width: 360, height: 182)
            .overlay(
                RoundedRectangle (cornerRadius: 10)
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor))
            )
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}

struct BestSellerScrolView: View {
    @EnvironmentObject var networkServiceManager: NetworkServiceManager
    @State private var selectedIndex = 0
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("Best Seller")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                    
                    Spacer()
                    
                    Button {
                        print("See more")
                    } label: {
                        Text("see more")
                            .font(.system(size: 15))
                            .fontWeight(.regular)
                            .foregroundColor(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))
                    }
                }
                .padding(.leading, 17)
                .padding(.trailing, 33)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(networkServiceManager.shopModels.first?.bestSeller ?? [], id: \.id) { index in
                            VStack(spacing: 0) {
                                NavigationLink {
                                    DetailView()
                                } label: {
                                    BestSellerView(product: index)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 15)
            
            }
            .padding(.top, 10)
        }
    }
}

struct BestSellerView: View {
    let product: BestSeller

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color( UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor)
       
                AsyncImage(url: URL(string: product.picture ?? "")) { imageUrl in
                    if let image = imageUrl.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 175, height: 177)
                            .clipped()
                            .padding(.bottom, 55)
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Spacer()
                        
                        Button {
                            print("Like")
                        } label: {
                            Image(systemName: (product.isFavorites ?? false) ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 11, height: 10)
                        }
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))
                        .background(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                        .cornerRadius(50)
                    }
                    .padding(.top, 6)
                    .padding(.trailing, 15)
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Text("$\(product.discountPrice ?? 0)")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                            
                        Text("$\(product.priceWithoutDiscount ?? 0)")
                            .font(.system(size: 10))
                            .fontWeight(.medium)
                            .foregroundColor(Color(UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor))
                            .strikethrough()
                            .padding(.leading, 7)
                        
                        Spacer()
                    }
                    
                    Text(product.title ?? "")
                        .font(.system(size: 10))
                        .fontWeight(.regular)
                        .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                        .padding(.top, 5)
                }
                .padding(.leading, 21)
                .padding(.bottom, 15)
            }
            .frame(width: 175, height: 227)
            .overlay(
                RoundedRectangle (cornerRadius: 10)
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor))
            )
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .padding(.bottom, 5)
        .padding(.top, 5)
    }
}
