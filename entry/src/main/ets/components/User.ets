@Builder
function Icon(icon : ResourceStr,
              scale : number = 1,
              color : ResourceColor = "#8f9094")
{
  Image(icon)
    .width(28)
    .height(28)
    .margin(7)
    .fillColor(color)
    .scale({
      x: scale, y: scale
    })
}

@Builder
function ToolIcon(icon : ResourceStr,
  scale : number = 1,
  color : ResourceColor = "#8f9094")
{
  Image(icon)
    .width(22)
    .height(22)
    .margin(7)
    .fillColor(color)
    .scale({
      x: scale, y: scale
    })
}

@Builder
function Arrow(){
  Text('>')
    .fontColor(Color.Gray)
    .margin({left: 25, right: 5})
    .fontSize(18)
}

@Builder
function ToolItem(icon : ResourceStr,
                  title : string[],
                  scale : number,
                  color : ResourceColor)
{
  Row(){
    Row(){
      ToolIcon(icon, scale, color)
    }
    Row(){
      Row(){
        ForEach(title, (item : string, index : number) => {
          Text(item)
            .fontColor(Color.White)
            .fontSize(16)
          if (index != title.length - 1){
            Text("/")
              .fontColor(Color.Gray)
              .margin({left: 8, right: 8})
              .fontSize(16)
          }
        });
      }.width("70%")
      Arrow()
    }.justifyContent(FlexAlign.SpaceBetween)
  }
  .width("100%")
  .justifyContent(FlexAlign.SpaceBetween)
  .padding({top: 5, bottom: 5})
}

@Extend(Column) function ToolMenu(){
  .justifyContent(FlexAlign.SpaceBetween)
  .margin({top: 15})
  .width("90%")
  .backgroundColor("#18191F")
  .borderRadius(10)
  .padding({left: 15, right: 15, top: 5, bottom: 5})
}

@Component
export struct User{
  build() {
    Column(){
      Row(){
        Row(){
          Icon($r('app.media.sign'), 0.9)
        }.layoutWeight(0)
        Row(){
          Stack(){
            Icon($r('app.media.notify'), 1.1)
            Row(){
              Text("31")
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .fontSize(10)
            }
            .position({right: -5, top: 0})
            .padding({left: 7, right: 7, bottom: 3, top: 3})
            .borderRadius(10)
            .backgroundColor("#cc5974")
          }
          Icon($r('app.media.scan'))
          Icon($r('app.media.qrcode'), 0.9)
          Icon($r('app.media.sousuo'), 0.9)
        }
      }
      .padding({
        left: 10,
        right: 10
      })
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.SpaceBetween)

      Row(){
        Row(){
          Image($r('app.media.avator'))
            .width(48)
            .height(48)
            .borderRadius(48)
        }
        Row(){
          Text('设置我的昵称')
            .fontColor(Color.White)
            .fontSize(18)
            .margin({left: 20})
          Arrow()
        }
        .width("73%")
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .margin({top: 8})
      .justifyContent(FlexAlign.SpaceBetween)

      Row(){
        Column(){
          Row(){
            Text("黄金VIP会员")
              .fontColor("#d1ac77")
              .fontSize(18)
            Image($r('app.media.vip_crown'))
              .width(18).height(18).margin({left:5})
          }
          Row(){
            Image($r('app.media.coin'))
              .width(16).height(16)
            Text("1145")
              .fontColor(Color.Gray)
              .fontSize(14)
              .margin({left: 5})
            Text("|")
              .fontColor(Color.Gray)
              .fontSize(12)
              .margin({left: 9, right: 9})
            Text("已持续616天")
              .fontSize(14)
              .fontColor(Color.Gray)
          }.margin({top: 10})
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(0)
        Row(){
          Stack(){
            Button("立即抢购")
              .fontColor("#795c2e")
              .fontWeight(FontWeight.Bolder)
              .width(110)
              .linearGradient({
                direction: GradientDirection.Right,
                colors: [[0xebcea5, 0.0], [0xd2ac73, 1]]
              })
            Row(){
              Text("升级白金特惠")
                .fontColor("#fbfcfc")
                .fontSize(11)
            }.backgroundColor("#6a686c")
            .padding({left: 8, right: 8, top: 4, bottom: 4})
            .position({right: -10, top: -13})
            .borderRadius(5)
          }
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({top: 15})
      .width("90%")
      .padding(15)
      .backgroundColor("#18191F")
      .borderRadius(10)
      .borderColor("#444444")
      .borderWidth(1)

      Column(){
        ToolItem($r('app.media.history'), ["观看历史", "下载"], 1, "#35e679")
        ToolItem($r('app.media.favorite'), ["收藏", "预约", "书架"], 1.1, "#2fdabb")
      }.ToolMenu()

      Column(){
        ToolItem($r('app.media.wallet'), ["钱包"], 1.1, "#35e679")
        ToolItem($r('app.media.loan'), ["借钱额度"], 1.1, "#2fdabb")
        ToolItem($r('app.media.ticket'), ["票夹"], 1.1, "#1cb4ed")
      }.ToolMenu()

      Column(){
        ToolItem($r('app.media.free'), ["免流量服务"], 1.3, "#35e679")
        ToolItem($r('app.media.video'), ["创作中心"], 1.2, "#2fdabb")
        ToolItem($r('app.media.chat'), ["一起聊"], 1, "#1cb4ed")
        ToolItem($r('app.media.service'), ["微服务"], 1.5, "#0382fe")
      }.ToolMenu()
    }
    .padding({
      top: 8
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .height('100%')
  }
}