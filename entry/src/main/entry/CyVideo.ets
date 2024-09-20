export class CyVideo{
  id : Number;
  image : Resource | string;
  title : string;
  description : string;
  videoSrc : Resource | string;

  constructor(id : number, image : Resource |string, title : string, desc : string, videoSrc : Resource | string = ''){
    this.id = id;
    this.title = title;
    this.image = image;
    this.description = desc;
    this.videoSrc = videoSrc;
  }
}