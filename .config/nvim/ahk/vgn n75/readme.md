# 厂家工具定义

由于用autoHotkey或PowerToys修改win键为alt键，仍然会导致按下物理win键+l时，触发锁屏。搜索了大量资料，没有发现完美的解决方案。 有一种方案是修改注册表，彻底关掉锁屏功能，但是这样太影响使用了。

*由于厂家的工具优先级高于autoHotkey，所以通过厂家工具定义win键为alt键，然后通过autoHotkey映射为win键。*

1. win > alt
2. alt > ctrl
3. ctrl > Pause （因为厂家工具不能直接改为win，所以改为Pause再通过autoHotkey映射为win）



# autoHotkey定义
1. 把Pause键映射为win键，并且增加一些win键常用快捷键。
2. 配置SpaceFn,space+hjkl映射为方向键。
