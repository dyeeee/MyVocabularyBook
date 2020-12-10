//
//  WordDetailView.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/11/24.
//

import SwiftUI
import MobileCoreServices

//一个单词的详情页面
//关键在于，如何让每个不同地方的点进来的时候都是更新好的页面
//之前用一个全局controller实现的，用viewmodel的话不同页面有不同的模型？
//每次onAppear的时候都刷新一次？详情页面的Viewmodel之前没写过类似的
//List页面用一个model，
struct WordDetailView: View {
    @ObservedObject var wordItem:WordItem
    @State var showTrans = true
    @State var showExchange = true
    @State var showExampleSentences = false
    @ObservedObject var wordItemController: WordItemController
    
    var body: some View {
        VStack {
            List {
                VStack(alignment:.leading) {
                    HStack {
                        Menu{
                            Button(action: {
                                UIPasteboard.general.string = wordItem.wordContent ?? "null"
                            }) {
                                Text("Copy to clipboard")
                                Image(systemName: "doc.on.doc")
                            }
                        }label: {
                            Text(wordItem.wordContent ?? "null")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
//                        SelectableTextView(wordItem.wordContent ?? "null",textStyle: UIFont.TextStyle.largeTitle)
                        Spacer()
                        Text("StarLevel "+String(wordItem.starLevel))
                    }
                    Menu{
                        VStack{
                            Text("gk: 高考")
                            Text("cet4/6: 四六级单词")
                            Text("ky: 考研单词")
                            Text("toefl: 托福单词")
                            Text("ielts: 雅思单词")
                            Text("gre: GRE单词")
                        }.font(.caption2)
                    }label: {Text(wordItem.tag ?? "null")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    }
                    
                    HStack{
                        Text(String(wordItem.collinsLevel))
                        Text(String(wordItem.oxfordLevel))
                        Text(String(wordItem.bncLevel))
                        Text(String(wordItem.frqLevel))
                    }.font(.subheadline)
                }.padding(.bottom,10)
                
                Section(header: ListHeader(img: "lightbulb.fill", text: "释义", showContent: $showTrans))
                {
                    if(showTrans) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(dealBreak(wordItem.translation ?? "null"))
                            
                        Text(dealBreak(wordItem.attrTest1 ?? "null"))
                    }
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = dealBreak(wordItem.attrTest1 ?? "null")
                            }) {
                                Text("Copy to clipboard")
                                Image(systemName: "doc.on.doc")
                            }
                         }
                    }
                }.animation(.default)
                
                Section(header: ListHeader(img: "doc.on.doc.fill", text: "词形变化", showContent: $showExchange))
                {
                    if(showExchange) {
                    VStack {
                        SelectableTextView(dealExchanges(str: wordItem.exchanges ?? "null"))
                            .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .leading)
                            
                    }.padding(.leading, 5)
                    }
                }.animation(.default)
                
                Section(header: HStack {
                    ListHeader(img:"scroll.fill",text:"例句", showContent: $showExampleSentences)
                })
                {
                    if(showExampleSentences) {
                        VStack {
                            SelectableTextView(dealExampleSentences(str: wordItem.exampleSentences ?? "null"),scrollEnable: true)
                                .frame(maxWidth: .infinity, idealHeight: 400, maxHeight: .infinity, alignment: .leading)
                        }.padding(.leading, 5)
                    }
                }.animation(.easeInOut)
                
                
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar(content: {
                ToolbarItem(placement: .bottomBar) {
                    Image(systemName: "star.fill")
                }
                ToolbarItem(placement: .bottomBar) {
                    Image(systemName: "eyes.inverse")
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        wordItem.wordContent = "test"
                        wordItem.starLevel = 10
                        wordItemController.saveToPersistentStore()
                    }, label: {
                        Text("test")
                    })
                }
            })
        }
        .navigationTitle(wordItem.wordContent ?? "null")
    }
    
    func dealBreak(_ str:String) -> String {
        print(str)
        let result = str.replacingOccurrences(of: "\\n", with: "\n")
        return result
    }
    
    func dealExampleSentences(str:String) -> String {
        let result = str.replacingOccurrences(of: "<br>", with: "\n")
        return result
    }
    
    func dealExchanges(str:String) -> String {
        var result = str
        result = result.replacingOccurrences(of: "/", with: "\n")
        result = result.replacingOccurrences(of: "p:", with: "过去式（did）: ")
        result = result.replacingOccurrences(of: "d:", with: "过去分词（done）: ")
        result = result.replacingOccurrences(of: "i:", with: "现在分词（doing）: ")
        result = result.replacingOccurrences(of: "3:", with: "第三人称单数（does）: ")
        result = result.replacingOccurrences(of: "r:", with: "形容词比较级（-er）: ")
        result = result.replacingOccurrences(of: "t:", with: "形容词最高级（-est）: ")
        result =  result.replacingOccurrences(of: "0:", with: "词缀（lemma） ")
        result = result.replacingOccurrences(of: "1:", with: "词缀的复数形式（lemma）: ")
        return result
    }
}

struct ListHeader: View {
    var img:String = "scroll.fill"
    var text:String = "header"
    @Binding var showContent:Bool
    
    var body: some View {
        HStack {
            Image(systemName: img)
                .foregroundColor(.blue)
            Text(text)
                .fontWeight(.light)
                .foregroundColor(.blue)
            Spacer()
            Button(action: {showContent.toggle()}, label: {
                Text("show")
                Image(systemName: self.showContent ? "chevron.down" :"chevron.right")
            })
            .foregroundColor(.blue)
        }
    }
}


struct WordDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let wordItem = WordItem(context: PersistenceController.preview.container.viewContext)
        wordItem.wordContent = "alleviate"
        wordItem.phonetic = "ә'li:vieit"
        wordItem.attrTest1 = "v provide physical relief, as from pain\nv make easier"
        wordItem.translation = "vt. 减轻, 使缓和"
        wordItem.collinsLevel = 1
        wordItem.tag = "cet6 ky toefl ielts gre"
        wordItem.bncLevel = 7706
        wordItem.frqLevel = 7531
        wordItem.exchanges = "d:alleviated/i:alleviating/3:alleviates/p:alleviated"
        wordItem.exampleSentences = "Excuse me what eyedrop can be treated or to what eyedrop can be treated or alleviate myopic eyedrop ah?<br>请问一下有没有什么眼药水可以治疗或缓解近视的眼药水啊？<br>And ease the tension in the form of many, why not bring serious harm to the body of a factor to alleviate it?<br>而且缓解紧张情绪的形式很多，为什么非要拿一个严重危害身体的因素来缓解呢？<br>The reason that cats can alleviate negative moods is often attributed to attachment - the emotional bond between cat and owner.<br>猫能够改善人们负性情绪的原因往往都归于他们对人的依恋——猫与主人间的感情粘合剂。<br>'We'd like to see if diet after birth could alleviate this problem that was programmed before birth, ' he said.<br>“我们希望能看见出生后饮食方式的改变可以减轻这些出生前引起的问题，”他说。<br>Use in the database compress a technology, it is to solve (perhaps alleviate at least) place of this kind of pressure one of made effort.<br>在数据库中使用压缩技术，是为了解决（或者至少缓解）这种压力所做出的努力之一。<br>And if scientists can unravel what underlies these biological differences, they might be able to alleviate inborn disparities.<br>如果科学家们能够解决造成这种生物学差异的原因，也许就能缓解人们的先天差距。<br>North Korea said on Monday that it was ready to discuss humanitarian aid from the South to alleviate damage caused by flooding and typhoons.<br>周一，朝鲜表示已准备好就从韩国获取人道主义援助进行商讨，以缓解洪灾和台风造成的损失。<br>Goldman Sachs said the moves 'should help to . . . alleviate market stresses, but are incremental rather than transformational' .<br>高盛（GoldmanSachs）表示：“此举应有助于……减轻市场压力，但是是一种量变而非质变。”<br>Jesus' hunger, she said, is what 'you and I must find' and alleviate.<br>她说，“耶稣的饥渴，是你我必须要寻求且予以帮助的。”<br>One of the nurses asked if I would like some ice chips to help alleviate problem.<br>一位护士问我要不要含一些碎冰块来缓解一下。<br>"
        
        return WordDetailView(wordItem: wordItem, wordItemController: WordItemController()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
