<script setup>
import { reactive, inject, ref  } from 'vue'
const axios = inject('axios')
//截图组件参数
const option = reactive({
  img: '',//裁剪图片的地址
  fixedBox:true,//是否固定截图框大小
  canMoveBox: false,//截图框能否拖动
  fixedNumber:[373,207],//截图框的宽高比例
  outputSize:1,//裁剪生成图片的质量:0.1 ~ 1
  outputType: 'jpeg',//裁剪生成图片的格式：jpeg, png, webp
  autoCrop: true,//是否默认生成截图框
  // 只有自动截图开启 宽度高度才生效
  autoCropWidth: 373,
  autoCropHeight: 207,
  // 真实的输出宽高
  infoTrue: true,//true 为展示真实输出图片宽高 false 展示看到的截图框宽高
  original:true,//上传图片显示原图，不会缩放
  centerBox:true,//截图框是否被限制在图片里面
  enlarge:1//图片根据截图框输出比例倍数
})

const data = reactive({ 
  file: null, 
  f: null,
  innerHTML:"",
  freshCropper:true,//是否要刷新当前组件，使得组件恢复初始状态
  thumbnail:"",//上传至服务器的图片的url
  isEditor:false//是否为编辑文章
})
//变换图片文件时调用（固定套路）
function uploadImg(event) {
  data.file = event.target.files[0];
  const item = {
    name: data.file.name,
    size: data.file.size,
    file: data.file
  };
  html5Reader(data.file, item);
  data.f = item;
  data.isEditor=false
  document.getElementById('fade').style.display = 'block'
  document.getElementById('upload2').value = '';  
}
// 将图片文件转成BASE64格式（固定套路）
function html5Reader(file, item) {
  const reader = new FileReader();
  reader.onload = e => {
    option.img = e.target.result;
  };
  reader.readAsDataURL(file);
}
//取消上传（固定套路）
function cancelUpload() {
  document.getElementById('fade').style.display = 'none'
}
//myCropper代表页面上的VueCropper组件
const myCropper = ref(null)
let lastEditRange = ref(0)

//点击确定，上传文件（基本是固定套路，只需注意axios.post上传的服务器端网址）
function determineUpload($event) {
  myCropper.value.getCropData((cropData) => {
    let theBlob = base64toFile(cropData, data.file.name)
    let formData = new FormData();
    formData.append("file", theBlob.file, theBlob.name);
    let config = {
      headers: {
        "Content-Type": "multipart/form-data"
      }
    }
    //只需注意axios.post上传的服务器端网址，其他固定套路
    axios.post("/api/article/upload", formData, config)
      .then(res => {
        //console.log(res);
        if (res.status === 200) {
          try {
            var editer = document.getElementById('text')
            data.thumbnail = res.data.map.url
            editer.focus()
            var lastEditRange1 = lastEditRange.value
            var selection = window.getSelection()
            // 判断是否有最后光标对象存在
            if (lastEditRange1) {// 存在最后光标对象，选定对象清除所有光标并添加最后光标还原之前的状态              
              selection.removeAllRanges()
              selection.addRange(lastEditRange1)
            }
            document.execCommand('InsertImage', false, data.thumbnail);
            lastEditRange.value = selection.getRangeAt(0)
          } catch (e) { console.log("捕获到异常：", e); }
        } else {
          console.log("失败" + 400);
        }
      });
    document.getElementById('fade').style.display = 'none'//隐藏
  })
}
//将base64转换为文件（固定套路）
function base64toFile(dataurl, filename) {
  var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1],
    bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
  while (n--) {
    u8arr[n] = bstr.charCodeAt(n);
  }
  let theBlob = new Blob([u8arr], { type: mime });
  theBlob.lastModeifiedDate = new Date();
  theBlob.name = filename;
  return {
    file: theBlob,
    name: filename
  }
}
function getLastEditRange() {
  // 获取选定对象
  var selection = window.getSelection()
  // 设置最后光标对象
  lastEditRange.value = selection.getRangeAt(0)
}
//将图片顺时针旋转90度
function rotateRight() {
  myCropper.value.rotateRight()
}

function onBlur($event){
  data.innerHTML = $event.target.innerHTML
}
//父组件的freshCropper方法
const freshCropper = inject("freshCropper")
//父组件调用，父组件获取上传到服务器端的图片的网址
const getThumbnail = () => {
  return data.thumbnail
}
//清空数据
function clearData(){
  data.thumbnail=""
  freshCropper()
}
//父组件在编辑文章时调用，以便设置data.thumbnail，并将组件设置为编辑状态
function setThumbnail(thumbnail){
  data.thumbnail=thumbnail
  data.isEditor=true
}
//开放给父组件，父组件可以调用当前组件的在此列举的方法
defineExpose({
  getThumbnail,
  clearData,
  setThumbnail
})
</script>
<template>
  <div id="fade" class="black_overlay" v-if="data.freshCropper">
    <div id="light" class="white_content">
      <div class="test">
        <VueCropper ref="myCropper" 
          :img="option.img" 
          :fixedBox="option.fixedBox"
          :canMoveBox="option.canMoveBox"
          :fixedNumber="option.fixedNumber"
          :outputSize="option.size" 
          :outputType="option.outputType"
          :infoTrue="option.infoTrue" 
          :autoCrop="option.autoCrop"
          :autoCropWidth="option.autoCropWidth" 
          :autoCropHeight="option.autoCropHeight" 
          :centerBox="option.centerBox"
          :original="option.original"
          :enlarge="option.enlarge">
        </VueCropper>
      </div>
      <div class="cropper-control">
        <el-row justify="end">
          <el-col :span="24 ">
            <span style="margin-right:10px">滚动鼠标滚轮可以缩放图片</span>
            <el-button type="primary" @click="cancelUpload()">取消</el-button>
            <el-button type="primary" @click="determineUpload($event)">确定</el-button>
            <el-button type="primary" @click="rotateRight()">向右边旋转90度</el-button>
          </el-col>
        </el-row>
      </div>
    </div>
  </div>

  <div style="height:380px;margin-top: 20px;">
    <el-space :size="30">
      <label class="btn-photo" for="upload2">选择文章标题图片(可以不设置，使用默认值)</label>
      <input ref="upload" type="file" id="upload2" 
        style="position:absolute; clip:rect(0 0 0 0);"
        accept="image/png, image/jpeg, image/gif, image/jpg" 
        @change="uploadImg($event)">
      <el-button type="primary" @click="freshCropper">清空图片</el-button>
    </el-space>
    <!-- 如果是编辑状态，将thumbnail图片显示在一个img中，添加状态则隐藏 -->
    <div v-if="data.isEditor" style="margin-top:10px">
      <img :src="data.thumbnail"/>
    </div>
    <!--显示下列div的时机： 1、添加文章；
      2、编辑文章时剪切的图片上传到服务器后，要在本地显示图片时 -->
    <div v-if="!data.isEditor" ref="cTextareaRef"  
      contenteditable="true" class="textdiv" id="text"
      @click="getLastEditRange()" 
      @onkeyup="getLastEditRange()" 
      :v-html="data.innerHTML"
      @blur="onBlur($event)">
    </div>
  </div>
</template>
<style scoped>
.cropper-control{
  margin-top:10px;
  /* margin-bottom:5px; */
  text-align:right;
}
.card {
  margin: 1% 1%;
}
@media (min-width: 480px) {
  .textdiv {
    border: 1px solid #ccc;
    margin-bottom: 20px;
    margin-top: 10px;
    padding: 5px 10px;
    min-width: 10%;
    max-width: 70%;
  }
  .btn-photo {
    height: 25px;
    width: 350px;
    text-align: center;
    padding: 5px;
    border-radius: 4px;
    color: #fff;
    background-color: #50bfff;
  }
  .white_content {
    left: 16%;
    width: 70%;
    height: 70%;
  }
}
@media (max-width: 480px) {
  .textdiv {
    border: 1px solid #ccc;
    margin-bottom: 20px;
    margin-right: 3%;
    padding: 1%;
    width: 74%;
  }
  .btn-photo {
    height: 23px;
    width: 15%;
    font-size: 12px;
    text-align: center;
    padding: 1%;
    border-radius: 4px;
    color: #fff;
    background-color: #50bfff;
  }
  .white_content {
    left: 5%;
    width: 90%;
    height: 80%;
  }
}
.card {
  margin: 1% 1%;
}
.textdiv img {
  max-width: 100%;
  display: block;
}
.black_overlay {
  display: none;
  position: absolute;
  top: 0%;
  left: 0%;
  width: 100%;
  height: 100%;
  background-color: black;
  z-index: 1000;
  filter: alpha(opacity=88);
}
.white_content {
  position: absolute;
  top: 16%;
  padding: 1%;
  border: 5px solid orange;
  background-color: white;
  z-index: 1002;
  overflow: auto;
}
.btn {
  margin-top: 15px;
  margin-left: 20px;
  float: right;
}
.test {
  height: 92%;
}
</style>