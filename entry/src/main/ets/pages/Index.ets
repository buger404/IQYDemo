import { Home } from '../components/Home'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0

  @Builder
  navigatorBar(index : number, image : Resource, title : string)
  {
    Column(){
      Image(image)
        .height(22)
        .fillColor(index == this.currentIndex ? '#62ea4d' : Color.White)
        .margin({bottom: 5})
      Text(title)
        .fontColor(index == this.currentIndex ? '#62ea4d' : Color.Gray)
        .fontSize(11)
        .margin({bottom: 5})
    }
  }

  build() {
    Tabs({
      barPosition: BarPosition.End
    }){
      TabContent(){
        Home()
      }
      .tabBar(this.navigatorBar(0, $r('app.media.home'), '首页'))
      TabContent(){
        Text("这是第二个页面")
      }
      .tabBar(this.navigatorBar(1, $r('app.media.random'), '随意视频'))
      TabContent(){
        Text("第三个页面")
      }
      .tabBar(this.navigatorBar(2, $r('app.media.discover'), '发现'))
      TabContent(){
        Text("第四个页面")
      }
      .tabBar(this.navigatorBar(3, $r('app.media.vip'), '会员'))
      TabContent(){
        Text("第5个页面")
      }
      .tabBar(this.navigatorBar(4, $r('app.media.user'), '我的'))
    }
    .backgroundColor(Color.Black)
    .barHeight(70)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}