import http from '@ohos.net.http';
import { CyVideo } from '../../entry/CyVideo'
import router from '@ohos.router';

const episodes : number[] = [1, 2, 3, 4, 5, 6, 7, 8];

class Movie {
  cover: ResourceStr;
  title: string;

  constructor(cover : ResourceStr, title : string) {
    this.cover = cover;
    this.title = title;
  }
}

const movies : Movie[] =
  [
    new Movie($r('app.media.mnzl'), '魔女之旅'),
    new Movie($r('app.media.zsdfll'), '葬送的芙莉莲'),
    new Movie($r('app.media.richang'), '日常'),
    new Movie($r('app.media.overlord'), 'OVERLORD III'),
    new Movie($r('app.media.qysn'), '轻音少女')
  ]

@Builder function MovieBlock(movie : Movie, index : number){
  Column(){
    Stack(){
      Image(movie.cover)
        .width(100)
        .borderRadius(6)
      Image($r('app.media.favorite'))
        .width(20)
        .height(20)
        .fillColor(Color.White)
        .position({left: 5, top: 5})
    }.align(Alignment.TopStart)
    Text(movie.title)
      .fontSize(14)
      .fontColor(Color.Gray)
      .margin({ top: 8 })
  }.margin(5)
}

@Entry
@Component
struct Detail{
  @State message : string = '视频播放器'
  @State videoInfo : CyVideo | null = null
  httpClient : http.HttpRequest = http.createHttp()

  getVideoInfo(videoID : number){
    this.httpClient.request(`http://8.134.96.242/movie/detail/${videoID}.json`)
      .then(resp => {
        let result = resp.result
        console.log('获取电影详情信息成功！')
        this.videoInfo = JSON.parse('' + result)
      }).catch((err : Error) => {
        console.log('获取信息失败：' + JSON.stringify(err))
    })
  }

  aboutToAppear(): void {
    let params = router.getParams() as [key : string]
    let videoID : number | null = null;
    if (params){
      videoID = params['videoID']
      console.log('获取的ID是：' + videoID)
    }

    if (videoID == null){
      router.replaceUrl({
        url: 'pages/Index'
      })
    }

    this.getVideoInfo(videoID as number)
  }

  aboutToDisappear(): void {
    this.httpClient.destroy()
  }

  @Builder EpisodeItem(index : number) {
    Stack(){
      Text(index.toString())
        .fontWeight(FontWeight.Bold)
        .padding({left: 20, right: 20, top: 15, bottom: 15})
        .fontColor(index != 1 ? Color.White : Color.Red)
        .backgroundColor("#1b1b1b")
        .borderRadius(5)
        .margin({right: 10})
      if (index >= 3){
        Text("VIP")
          .position({top: 0, right: 3})
          .borderRadius(10)
          .padding({left: 5, right: 5, top: 2, bottom: 2})
          .fontColor("#795c2e")
          .fontWeight(FontWeight.Bolder)
          .fontSize(11)
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [[0xebcea5, 0.0], [0xd2ac73, 1]]
          })
      }
    }
  }

  build(){
    Column(){
      Column(){
        if (this.videoInfo){
          Video({
            src: this.videoInfo.videoSrc
          }).height(200)
            .width('100%')
        }
      }

      Row() {
        Row(){
          Stack(){
            Row(){

            }
            .width(50)
            .height(10)
            .borderRadius(4)
            .position({bottom: -4, left: 0})
            .linearGradient({
              direction: GradientDirection.Right,
              colors: [[0xea1b25, 0.0], [0x111214, 1.0]]
            })
            Text("视频")
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .fontSize(18)
          }
          Text("讨论")
            .fontColor(Color.White)
            .margin({left: 15})
          Text("6.7万")
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Red)
            .fontSize(12)
            .margin({left: 5})
          Text("原著")
            .fontColor(Color.White)
            .margin({left: 15})
        }.alignItems(VerticalAlign.Bottom)
        Row(){
          Button("特权待使用")
            .fontColor("#795c2e")
            .fontSize(14)
            .height(30)
            .linearGradient({
              direction: GradientDirection.Right,
              colors: [[0xebcea5, 0.0], [0xd2ac73, 1]]
            })
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding({left: 15, right: 15, top: 15, bottom: 15})
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[0x2b1716, 0.0], [0x111214, 1.0]]
      })

      Row(){
        Text(this.videoInfo?.title)
          .fontColor(Color.White)
          .fontSize(24)
        Text("简介 >")
          .fontSize(16)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({left: 20, right: 20, top: 5, bottom: 15})

      Row(){
        Row(){
          Text("9.4分")
            .fontSize(12)
            .fontColor("#e1853c")
            .fontWeight(FontWeight.Bold)
        }
        .padding({left: 10, right: 10, top: 4, bottom: 4})
        .borderRadius(5)
        .backgroundColor("#2b2b2b")
        Row(){
          Text("电视剧必看榜第1名")
            .fontSize(12)
            .fontColor(Color.White)
        }
        .margin({left: 7})
        .padding({left: 10, right: 10, top: 4, bottom: 4})
        .borderRadius(5)
        .backgroundColor("#2b2b2b")
        Text("警匪")
          .fontSize(12)
          .margin({left: 7})
          .fontColor(Color.White)
        Text("/")
          .fontSize(12)
          .margin({left: 7})
          .fontColor(Color.Gray)
        Text("罪案")
          .fontSize(12)
          .margin({left: 4})
          .fontColor(Color.White)
        Text("/")
          .fontSize(12)
          .margin({left: 7})
          .fontColor(Color.Gray)
        Text("悬疑")
          .fontSize(12)
          .margin({left: 4})
          .fontColor(Color.White)
      }
      .width('100%')
      .padding({left: 20, right: 20, top: 0, bottom: 15})

      Row(){
        Text("选集")
          .fontColor(Color.White)
          .fontSize(18)
        Text("39集全 · VIP会员看全集 >")
          .fontColor(Color.Gray)
          .fontSize(12)
      }
      .width('100%')
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({left: 20, right: 20, top: 5, bottom: 15})

      Row(){
        List(){
          ForEach(episodes, (episode : number, index) => {
            ListItem(){
              this.EpisodeItem(episode)
            }
          })
        }.listDirection(Axis.Horizontal)
      }
      .width('100%')
      .height(70)
      .padding({left: 20, right: 0, top: 0, bottom: 15})

      Row(){
        Row(){
          Image($r('app.media.milthm'))
            .width(120)
            .borderRadius(5)
        }
        Column(){
          Text("所有的词语，都是雨的旋律。")
            .fontColor(Color.White)
            .fontSize(14)
          Button("点我玩玩")
            .margin({top: 10})
            .height(25)
            .fontSize(12)
            .backgroundColor(Color.Red)
            .fontColor(Color.White)
        }
        .margin({left: 20})
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding({left: 20, right: 20, top: 0, bottom: 15})

      Row(){
        Text("狂飙不止，精彩不停")
          .fontColor(Color.White)
          .fontSize(18)
        Text("查看全部 >")
          .fontColor(Color.Gray)
          .fontSize(12)
      }
      .width('100%')
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({left: 20, right: 20, top: 5, bottom: 5})

      Row(){
        List(){
          ForEach(movies, (item : Movie, index : number) => {
            ListItem(){
              MovieBlock(item, index)
            }
          })
        }
        .scrollBar(BarState.Off)
        .listDirection(Axis.Horizontal)
        .width('100%')
        .margin({ top: 0, bottom: 15, left: 10 })
      }
      .padding({left: 5})

      Row(){
        TextInput({
          placeholder: '参与讨论',
        }).borderRadius(10)
          .width('45%')
          .backgroundColor("#1b1b1b")
          .fontColor(Color.Gray)
          .maxFontSize(12)
          .placeholderColor(Color.Gray)

        Row(){
          Column(){
            Image($r('app.media.chat'))
              .fillColor(Color.White)
              .width(20)
            Text("一起聊")
              .fontSize(11)
              .fontColor(Color.Gray)
              .margin({top: 5})
          }
          Column(){
            Image($r('app.media.favorite'))
              .fillColor(Color.White)
              .width(20)
            Text("收藏")
              .fontSize(11)
              .fontColor(Color.Gray)
              .margin({top: 5})
          }
          Column(){
            Image($r('app.media.download'))
              .fillColor(Color.White)
              .width(20)
            Text("下载")
              .fontSize(11)
              .fontColor(Color.Gray)
              .margin({top: 5})
          }
          Column(){
            Image($r('app.media.forward'))
              .fillColor(Color.White)
              .width(20)
            Text("10.4w")
              .fontWeight(FontWeight.Bold)
              .fontSize(11)
              .fontColor(Color.Gray)
              .margin({top: 5})
          }
        }.width('50%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .backgroundColor(0x111214)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({left: 20, right: 10, top: 10, bottom: 10})
      .position({ bottom: 0 })
    }
    .width('100%')
    .backgroundColor(0x111214)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .height('100%')
  }
}