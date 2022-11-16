import SwiftUI

struct MyView: View {
    @EnvironmentObject var myViewModel: AppViewModel
    @State var showQRCodeScanner = false
    @StateObject var viewModel = MyViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .foregroundColor(.blue)
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "crown.fill")
                            Text(viewModel.nickname).bold()
                            Image(systemName: "figure.stand") // gender
                        }
                        HStack {
                            HStack(spacing: 2) {
                                Text("关注")
                                Text("0")
                            }
                            HStack(spacing: 2) {
                                Text("粉丝")
                                Text("0")
                            }
                        }.foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                        .imageScale(.small)
                }.padding(.horizontal)
                .frame(maxHeight: 75)
                .onTapGesture {
                    myViewModel.model.showPref.toggle()
                }
                HStack {
                    Spacer()
                    VStack {
                        Text("1").font(.title2).bold()
                        Text("我的帖子").font(.footnote).foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack {
                        Text("6").font(.title2).bold()
                        Text("关注的吧").font(.footnote).foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack {
                        Text("0").font(.title2).bold()
                        Text("收藏").font(.footnote).foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack {
                        Text("270").font(.title2).bold()
                        Text("浏览历史").font(.footnote).foregroundColor(.secondary)
                    }
                    Spacer()
                }.padding()
                ScrollView(.horizontal) {
                    Text("1")
                }
                VStack {
                    VStack {
                        HStack {
                            Text("辅助功能").bold().font(.callout)
                            Spacer()
                        }
                        HStack {
                            
                        }
                    }.padding(.top)
                    .padding(.horizontal, 8)
                }.background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                .padding()
                    
            }.toolbar {
                HStack {
                    Button {
                        showQRCodeScanner.toggle()
                    } label: {
                        Image(systemName: "qrcode.viewfinder")
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "basket.fill")
                    }
                    Button {
                        myViewModel.model.showPref.toggle()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
        }.navigationViewStyle(.stack)
            .fullScreenCover(isPresented: $showQRCodeScanner) {
                QRCodeScannerView(showQRCodeScanner: $showQRCodeScanner)
            }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
