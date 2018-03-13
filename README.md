# HEScrollView
- 基于UIScrollView实现的无限轮播视图
- 使用3个UIImageView循环利用实现无限轮播
- 只需三行代码配置，就能实现一个基于UIScrollView的无限轮播视图
- 根据业务需要自定义UIPageControl的图片

## HEScrollView的使用
### 导入HEScrollView.h和HEScrollView.m两个文件到工程，在控制器中创建HEScrollView
```
HEScrollView *view = [[HEScrollView alloc] initWithFrame:self.view.bounds];
```
### 设置要轮播的图片数组images
```
view.images = images;
```

### 设置页码的普通状态图
```
view.pageImgs = pageImgs;
```

### 设置页码的高亮状态图
```
 view.pageLightImgs = pageCurrentImgs;
```
## 效果图
![image](https://github.com/heyode/HEScrollView/blob/master/myProject.gif)
## 致谢 
感谢MJ大神提供的思路
