import http from '@ohos.net.http';
import { CyVideo } from '../../entry/CyVideo'
import router from '@ohos.router';

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

  build(){
    Row(){
      Column(){
        if (this.videoInfo){
          Video({
            src: this.videoInfo.videoSrc
          }).height(200)
            .width('100%')
        }
      }
      .width('100%')
      .height('100%')
    }
  }
}