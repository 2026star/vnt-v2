# VNT2 & VNTS2 梅林路由器整合项目工作区

本仓库是一个 Monorepo 工作区，包含了 VNT2 客户端、VNTS2 服务端以及配套的梅林路由器插件。

## 目录结构

*   `vnt/`: 客户端 Rust 源码 (基于 v2.0.0)。
*   `vnts/`: 服务端 Rust 源码 (基于 v2.0.0)。
*   `merlin_plugin/`: 梅林路由器软件中心适配插件 (包含界面和启动管理脚本)。

## 编译方法

在根目录下，您可以使用 Cargo 命令同时或单独编译子项目：

```bash
# 检查工作区所有项目
cargo check

# 编译客户端
cargo build -p vnt --release

# 编译服务端
cargo build -p vnts2 --release
```

针对路由器环境的编译，建议在具有对应交叉编译工具链的环境中运行，例如：
`cargo build --target armv7-unknown-linux-musleabi -p vnt --release`
