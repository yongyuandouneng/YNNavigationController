# YNNavigationController

####先上效果图

![](https://github.com/yongyuandouneng/YNNavigationController/blob/master/GifAndImage/YNNavigationControllerSliderGif.gif)
![](https://github.com/yongyuandouneng/YNNavigationController/blob/master/GifAndImage/YNNavigationControllerScaleGif.gif)

喜欢就start鼓励一下，您在使用过程中有任何问题、出现任何(BUG、Crash)，请加QQ群538133294或联系我的扣扣1003580893.

####集成方法
----

将原来的`UINavigationController`替换为`YNNavigationController`即可，
也可以采用继承YNNavigationController方式，重写里面的系统方法以及属性设置。详细见Demo.

####相关操作
----

    1.push一般会对返回按钮进行拦截，此时可以调用里面的返回动画方法yn_popViewController.
    
    2.pop、popToVC、popToRoot这三个方法如果不需要和返回手势那个动画的话则调用原生方法，如果需要则调用与之对应的方法。
    
    3.如果某控制器不需要手势返回则在里面写上禁止手势方法`self.yn_banRightSliderGesture = YES;`
    
    4.如果需要隔层替换滑动手势的话则先设置`yn_resetGestureViewController = YES`，然后再赋值你要替换的层控制器类名
      `self.yn_resetGestureViewControllerClass = [TestViewController class]`，详情使用请看Demo.
    
