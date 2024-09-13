import { CyVideo } from '../../entry/CyVideo'

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
  @State videoList : CyVideo[] = [
    new CyVideo(1, $r('app.media.s1'), '琅琊榜之风起长林', '观看至第49集'),
    new CyVideo(2, $r('app.media.s2'), '城中之城', '天塌了苏见仁撞见赵辉周琳暖昧'),
    new CyVideo(3, $r('app.media.s3'), '乘风踏浪', '贾为民卖布料孤立彭家人'),
    new CyVideo(4, $r('app.media.s4'), '旺卡', '哈利波特团队全新IP'),
    new CyVideo(5, $r('app.media.s5'), '狂飙·正义接力', '张译张颂文黑白较量'),
    new CyVideo(6, $r('app.media.s6'), '超意神探', '港星齐聚上演强爽追凶'),
    new CyVideo(7, $r('app.media.s7'), '追风者·信念如磐', '王一博李沁坚定前行'),
    new CyVideo(8, $r('app.media.s8'), '种地吧第2季', '赵一博再对李耕耘做啾咪'),
    new CyVideo(9, $r('app.media.s9'), '种地吧第2季', '赵一博少熙劝架插不上话'),
    new CyVideo(10, $r('app.media.s10'), '五哈第4季', '鹿晗猛泼邓超泼上头了'),
    new CyVideo(11, $r('app.media.s11'), '幸运旅行家', '宋轶马伯骞“衰神”附体'),
    new CyVideo(12, $r('app.media.s12'), '萌探2024·抢先看', '这么刺激？黄子韬高喊救命'),
    new CyVideo(13, $r('app.media.s13'), '新说唱2024', 'rapper上大分'),
    new CyVideo(14, $r('app.media.s14'), '17号音乐仓库第2季', '房东的猫致敬张雨生'),
    new CyVideo(15, $r('app.media.s15'), '王牌对王牌·精编', '沙溢杨迪被泼成蓄水池'),
    new CyVideo(16, $r('app.media.s16'), '萌探探探案第3季', '赵丽颖孙红雷扭得太欢啦')
  ]

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
                Text(v.desc)
                  .fontColor(Color.Gray)
                  .fontSize(11)
              }
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
    .height('100%')
  }
}