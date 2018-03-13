# HEScrollView
- 基于UIScrollView实现的无限轮播视图
- 使用3个UIImageView循环利用实现无限轮播
- 只需三行代码配置，就能实现一个基于UIScrollView的无限轮播视图
- 根据业务需要自定义UIPageControl的图片

## HEScrollView的使用

```
let  scrollView = HEScrollView.init(frame: view.bounds)
```
### 设置要轮播的图片数组images
```
scrollView.images = images
```

### 设置页码的普通状态图
```
scrollView.pageImgs = pageImgs
```

### 设置页码的高亮状态图
```
scrollView.pageLightImgs = pageCurrentImgs
```
## 效果图
![image](https://github.com/heyode/HEScrollView/blob/master/myProject.gif)

