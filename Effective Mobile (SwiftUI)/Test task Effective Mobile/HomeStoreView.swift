//
//  HomeStoreView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 12.09.2022.
//

import SwiftUI

struct HomeStoreView: View {
    private let category: [CategoryImage] = [
        CategoryImage(image: "category_1", text: "Phones"),
        CategoryImage(image: "category_2", text: "Computer"),
        CategoryImage(image: "category_3", text: "Health"),
        CategoryImage(image: "category_4", text: "Books"),
        CategoryImage(image: "", text: "")]
    @State private var search: String = ""
    @State private var isActiveFilterView: Bool = false
    @EnvironmentObject var networkServiceManager: NetworkServiceManager
    
    var body: some View {
        ZStack {
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                NaviganionBarView(isActive: $isActiveFilterView)
                
                CategoryScrollView(categories: category)
                
                SearchProductView(search: $search)
                
                HotSalesScrollView(shopModels: networkServiceManager.shopModels)
                
                if !isActiveFilterView {
                    BestSellerScrolView(shopModels: networkServiceManager.shopModels)
                } else {
                    FilterView(isActive: $isActiveFilterView)
                }
                
                Spacer()
            }
            .padding(.top, 45)
            .ignoresSafeArea()
        }
    }
}

struct HomeStoreView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStoreView()
            .environmentObject(NetworkServiceManager())
    }
}

struct NaviganionBarView: View {
    @Binding var isActive: Bool
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("map")
                    .padding(.leading, 116)
                
                Text("Zihuatanejo, Gro")
                    .font(.system(size: 15).bold())
                
                Button {
                    print("Place")
                } label: {
                    Image("line")
                }

                Spacer()
                
                Button {
                    print("Filter")
                    isActive.toggle()
                } label: {
                    Image("filter")
                }
                .padding(.trailing, 35)
            }
        }
    }
}

struct CategoryScrollView: View {
    @State private var selectedIndex = 0
    let categories: [CategoryImage]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Text("Select category")
                        .font(.system(size: 25).bold())
                    
                    Spacer()
                    
                    Button {
                        print("View all")
                    } label: {
                        Text("view all")
                            .foregroundColor(Color("orange"))
                    }
                }
                .padding(.leading, 17)
                .padding(.trailing, 33)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 23){
                    ForEach(0 ..< categories.count) { index in
                        Button {
                            selectedIndex = index
                        } label: {
                            CategoryView(isActive: selectedIndex == index,
                                         text: categories[index].text,
                                         image: categories[index].image)
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
    let isActive: Bool
    let text: String
    let image: String
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(isActive ? Color("orange") : .white)
                    .frame(width: 71, height: 71)

                Image(image)
                    .renderingMode(.template)
                    .foregroundColor(isActive ? .white : Color("gray"))
            }
            .padding(.bottom, 7)
            
            Text(text)
                .font(.system(size: 12).bold())
                .foregroundColor(.black)
        }
    }
}

struct SearchProductView: View {
    @Binding var search: String
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                HStack {
                    HStack {
                        Image("search")
                            .padding(.leading, 24)
                        
                        TextField("Search", text: $search)
                            .frame(height: 34)
                    }
                    .background(.white)
                    .frame(width: 300, height: 34)
                    .cornerRadius(50)
                  
                    Spacer()
                    
                    Button {
                        print("Search")
                    } label: {
                        Image("scan")
                    }
                    .frame(width: 34, height: 34)
                    .background(Color("orange"))
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
    let shopModels: [ShopModel]

    var body: some View {
            VStack {
                VStack {
                    HStack {
                        Text("Hot sales")
                            .font(.system(size: 25).bold())
                        Spacer()
                        
                        Button {
                            print("See more")
                        } label: {
                            Text("see more")
                                .foregroundColor(Color("orange"))
                        }
                    }
                    .padding(.leading, 17)
                    .padding(.trailing, 33)
                        
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 21) {
                            ForEach(0 ..< (shopModels.first?.homeStore.count ?? 0)) { index in
                                HotSaleView(isActive: selectedIndex == index,
                                            isNew: shopModels.first?.homeStore[index].isNew ?? false,
                                            title: shopModels.first?.homeStore[index].title ?? "",
                                            subtitle: shopModels.first?.homeStore[index].subtitle ?? "",
                                             image: shopModels.first?.homeStore[index].picture ?? "")
                                .onTapGesture {
                                    selectedIndex = index
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

struct HotSaleView: View {
    let isActive: Bool
    let isNew: Bool
    let title: String
    let subtitle: String
    let image: String

    var body: some View {
        VStack {
            ZStack {
                Color.white
                
                AsyncImage(url: URL(string: image)) { imageUrl in
                    if let image = imageUrl.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 360, height: 182)
                    }
                }
        
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        if isNew {
                            ZStack {
                                Circle()
                                    .frame(width: 27, height: 27)
                                    .foregroundColor(Color("orange"))

                                Text("New")
                                    .font(.system(size: 10).bold())
                                    .foregroundColor(.white)
                            }
                        }

                        Text(title)
                            .font(.system(size: 25).bold())
                            .foregroundColor(.white)
                            .padding(.top, 18)

                        Text(subtitle)
                            .font(.system(size: 11))
                            .foregroundColor(.white)
                            .padding(.top, 5)

                        Button {
                            print("Buy now")
                        } label: {
                            Text("Buy now!")
                                .font(.system(size: 11).bold())
                                .foregroundColor(.black)
                        }
                        .frame(width: 98, height: 23)
                        .background(Color.white)
                        .cornerRadius(5)
                        .padding(.top, 26)

                        Spacer()
                    }
                    .padding(.top, isNew ? 14 : 41)

                    Spacer()
                }
                .padding(.leading, 25)
            }
            .frame(width: 360, height: 182)
            .cornerRadius(10)
        }
    }
}

struct BestSellerScrolView: View {
    @State private var selectedIndex = 0
    let shopModels: [ShopModel]
    let columns = [GridItem(.flexible()),
                  GridItem(.flexible())]
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Best Seller")
                        .font(.system(size: 25).bold())
                    
                    Spacer()
                    
                    Button {
                        print("See more")
                    } label: {
                        Text("see more")
                            .foregroundColor(Color("orange"))
                    }
                }
                .padding(.leading, 17)
                .padding(.trailing, 33)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(0 ..< (shopModels.first?.bestSeller.count ?? 0)) { index in
                            VStack {
                                BestSellerView(isActive: selectedIndex == index, isFavorites: shopModels.first?.bestSeller[index].isFavorites ?? false, title: shopModels.first?.bestSeller[index].title ?? "", image: shopModels.first?.bestSeller[index].picture ?? "", priceWithoutDiscount: shopModels.first?.bestSeller[index].priceWithoutDiscount ?? 0, discountPrice: shopModels.first?.bestSeller[index].discountPrice ?? 0)
                                .onTapGesture {
                                    selectedIndex = index
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
    let isActive: Bool
    let isFavorites: Bool
    let title: String
    let image: String
    let priceWithoutDiscount: Int
    let discountPrice: Int

    var body: some View {
        VStack {
            ZStack {
                Color.white
       
                AsyncImage(url: URL(string: image)) { imageUrl in
                    if let image = imageUrl.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 175, height: 177)
                            .padding(.bottom, 55)
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        
                        Button {
                            print("Like")
                        } label: {
                            Image(systemName: isFavorites ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 11, height: 10)
                        }
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color("orange"))
                        .background(.white)
                        .cornerRadius(50)
                    }
                    .padding(.top, 6)
                    .padding(.trailing, 15)
                    
                    Spacer()
                    
                    HStack {
                        Text("$\(discountPrice)")
                            .font(.system(size: 16).bold())
                        
                        Text("$\(priceWithoutDiscount)")
                            .font(.system(size: 10))
                            .foregroundColor(Color("grayprice"))
                            .strikethrough()
                            .padding(.leading, 7)
                        
                        Spacer()
                    }
                    
                    Text(title)
                        .font(.system(size: 10))
                        .padding(.top, 5)
                }
                .padding(.leading, 21)
                .padding(.bottom, 15)
            }
            .frame(width: 175, height: 227)
            .cornerRadius(10)
        }
    }
}
