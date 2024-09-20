import { CyVideo } from '../../entry/CyVideo'
import { http } from '@kit.NetworkKit'
import { router } from '@kit.ArkUI'

const menuList : string[] =
  ['直播', '首页', '热点', '电视剧', '电影', '娱乐', '小说']

@Extend(Text) function DefaultMenuButton(){
  .fontColor('rgba(255,255,255,0.7)')
  .fontSize(16)
  .margin({
    right: 15
  })
}

@Extend(Text) function SelectedMenuButton(){
  .DefaultMenuButton()
  .fontColor(Color.White)
  .fontSize(20)
}

@Component
export struct Home {
  @State currentMenu : number = 1
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

  onPageShow(): void {
    console.log('home 页面显示了')
  }

  onPageHide(): void {
    console.log('home 页面隐藏了')
  }

  build() {
    Column(){
      Row() {
        Image($r('app.media.logo'))
          .width(40)
        Search({
          placeholder: '搜索电视剧...'
        })
          .searchIcon({
            src: $r('app.media.sousuo')
          })
          .borderRadius(60)
          .backgroundColor('rgba(0,0,0,0.3)')
          .height(30)
          .margin({
            left: 15,
            right: 15
          })
          .placeholderColor(Color.Gray)
          .layoutWeight(1)
        Row(){
          Image($r('app.media.shizhong'))
            .width(23)
            .margin({right: 10})
          Image($r('app.media.jiahao'))
            .width(23)
        }
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .linearGradient({
        direction: GradientDirection.LeftTop,
        colors: [[0x194c23, 0.0], [0x103e59, 1.0]]
      })
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height(60)
      .padding(15)

      Row(){
        List(){
          ForEach(menuList, (item : string, index : number) => {
            ListItem(){
              if (index == this.currentMenu){
                Text(item).SelectedMenuButton()
              }else{
                Text(item).DefaultMenuButton()
              }
            }
          })
        }
        .listDirection(Axis.Horizontal)
        .layoutWeight(1)
        .height(25)
        .margin(15)
        .alignListItem(ListItemAlign.Center)

        Image($r('app.media.menu'))
          .width(20)
          .margin({
            right: 15
          })
      }

      Scroll(){
        Column(){
          Swiper(){
            Image($r('app.media.b1')).width('100%')
            Image($r('app.media.b2')).width('100%')
            Image($r('app.media.b3')).width('100%')
            Image($r('app.media.b4')).width('100%')
          }
          .autoPlay(true)
          .indicator(true)
          .interval(2000)
          .margin({left: 15, right: 15})

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
                left: i % 2 == 0 ? 15 : 7.5,
                right: i % 2 == 0 ? 7.5 : 15,
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
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[0x194b26, 0.0], [0x111214, 0.2]]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .height('100%')
  }
}