import { CyVideo } from '../../entry/CyVideo';
import { http } from '@kit.NetworkKit';
import { router } from '@kit.ArkUI';

const types = ['电视剧', '电影', '综艺', '纪录片', '动漫'];
const nations = ['美国', '英国', '韩国', '日本', '泰国', '内地', '中国香港', '中国大陆'];
const types2 = ['动作', '冒险', '爱情', '热血', '日常', '搞笑', '悬疑'];
const years = ['2024', '2023', '2022', '2021', '2016-2020', '2011-2015'];
const tags = ['高颜值', '校园', '青春', '人性', '浪漫', '治愈'];

@Builder function TypeBar(title : string, content : string[]){
  Row(){
    Text(title)
      .fontColor("#35e679")
      .fontSize(14)

    List(){
      ForEach(content, (text : string, index) => {
        ListItem(){
          Button(text)
            .backgroundColor("#1b1b1b")
            .fontSize(14)
            .margin({left: 15})
            .height(30)
        }
      })
    }
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
  }
  .width('100%')
  .height(30)
  .alignItems(VerticalAlign.Center)
  .margin({top: 10, left: 10})
}

@Component
export struct Discover {
  @State videoList : CyVideo[] = []

  aboutToAppear(): void {
    console.log('home 页面被创建力')
    let client = http.createHttp()
    client.request('http://8.134.96.242/movie/list.json', {
      method: http.RequestMethod.GET
    }).then(resp => {
      console.log('已成功获取电影信息')
      let result = resp.result
      console.log('Json 内容：' + result)
      let list : CyVideo[] = JSON.parse('' + result)
      this.videoList = list
      console.log(JSON.stringify(this.videoList))
    }).catch((err : Error) => {
      console.log('获取失败：' + err.message + '\n' + err.stack)
    })
  }

  build() {
    Column() {
      Search({
        placeholder: '请输入剧集名称...'
      })
        .width('100%')
        .fontColor(Color.Gray)
        .placeholderColor(Color.Gray)
        .borderRadius(99)
        .backgroundColor("#2b2b2b")
        .searchIcon({
          src: $r('app.media.sousuo')
        })

      TypeBar('片型', types)
      TypeBar('国家', nations)
      TypeBar('类型', types2)
      TypeBar('年份', years)
      TypeBar('标签', tags)

      Scroll(){
        Column(){
          Flex({
            wrap: FlexWrap.Wrap
          }){
            ForEach(this.videoList, (v : CyVideo, i : number) => {
              Column(){
                Image(v.image)
                  .width('100%')
                Text(v.title)
                  .fontColor(Color.White)
                  .fontSize(14)
                  .margin({top: 5, bottom: 5})
                Text(v.description)
                  .fontColor(Color.Gray)
                  .fontSize(11)
              }
              .onClick((event) => {
                console.log('点击了视频')
                router.replaceUrl({
                  url: 'pages/Detail',
                  params: {
                    videoID: v.id
                  }
                }, router.RouterMode.Single)
              })
              .padding({
                left: i % 2 == 0 ? 8 : 4,
                right: i % 2 == 0 ? 4 : 8,
                bottom: 0
              })
              .margin({
                bottom: 10,
                top: (i <= 1 ? 15 : 0)
              })
              .width('50%')
              .alignItems(HorizontalAlign.Center)
            })
          }

          Column(){

          }.height(130)
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0x111214)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .padding(15)
  }
}