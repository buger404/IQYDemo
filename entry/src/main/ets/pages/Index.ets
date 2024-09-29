import { Home } from '../components/Home'
import { User } from '../components/User'
import { Discover } from '../components/Discover'

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
        Discover()
      }
      .tabBar(this.navigatorBar(2, $r('app.media.discover'), '发现'))
      TabContent(){
        User()
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