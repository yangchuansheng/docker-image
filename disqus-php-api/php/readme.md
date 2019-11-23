Disqus PHP API
===========
利用 PHP cURL 转发 Disqus API 请求

> Disqus 被墙，故做几个简单的接口，用于墙内环境访问 Disqus。

## 实现功能

* 评论列表
* 评论发表
* 图片上传
* Emoji 表情
* Gravatar 头像
* 邮件通知
* ……

注：由于 GDPR，Disqus 目前屏蔽了 Email 及 IP 的获取，因此 Gravatar 头像及匿名评论的邮件通知暂无法完美实现。目前暂存匿名评论者邮箱号，以发回复邮件通知显示 Gravatar 头像。

## Disqus 设置

使用 API 实现匿名评论功能，需在 Disqus 后台[网站设置](https://disqus.com/admin/settings/community/)，设置相关选项。

* 开启匿名评论，Guest Commenting 项中勾选 Allow guests to comment。
* 若需评论免审，Pre-moderation 项选中 None。

## 后端

* 需要部署在境外服务器。
* 依赖于 PHP 5.6+，采用 PHP cURL 请求 Disqus API，以获取评论数据，发送访客评论等操作。
* 配置文件为 `config.php`，有简单说明。

## 镜像使用方法

通过环境变量传入公钥私钥等相关信息，必须包含以下几个环境变量：

+ PUBLIC_KEY：即 Applications->Details->API Key
+ SECRET_KEY：即 Applications->Details->API Secret
+ USERNAME：即 Settings->Account->Username
+ EMAIL：即 Settings->Account->Email
+ PASSWD：disqus 登录密码
+ WEBSITE：即 Applications->Settings->Website
+ SHORTNAME: 即 Admin->Settings->General->Shortname

创建容器：

```bash

创建容器：

```bash
🐳  →  docker run -d -e PUBLIC_KEY=... -e SECRET_KEY=... -e USERNAME=... -e EMAIL=... -e PASSWD=... -e WEBSITE=... -e SHORTNAME=... yangchuansheng/disqus-php
```

### 重要

必须在 [Disqus API](https://disqus.com/api/applications/) 申请注册一个 App，取得相关的公钥（**API Key**）、私钥（**API Secret**），并填写于后端的配置文件 `config.php` 中。

App 设置方面，回调链接请填写 `login.php` 文件的绝对地址，主要的设置如下图，可根据自己情况填写。

![Disqus API 相关设置](https://uploads.disquscdn.com/images/013aa0590d3d091408c06d3d42b9e2fa15d6731f6c1e2cff5c8495fe23b21e80.png)

### 邮件发送

简易评论框及 Disqus 评论框皆可实现，规则如下：

1. 匿名者的回复提醒邮件（只有邮箱号存在才会发送）
2. 管理员的留言提醒邮件（只有[设置](https://disqus.com/home/settings/moderation/)未勾选站点邮件提醒时发送，管理员回复不发提醒）

## 前端

DEMO: http://blog.fooleap.org/disqus-php-api.html

项目将 Disqus 原生评论框加载代码打包在内，若使用本评论框，需将网页上所有与 Disqus 相关的元素清除，例如 id 为 `disqus_thread` 的容器、`disqus_config` 函数等。

Disqus 评论框的相关配置`disqus_config`：

* `this.page.identifier`: [identifier](#user-content-identifier)，若无设置则为 [url](#user-content-url)
* `this.page.title`: [title](#user-content-title)
* `this.page.url`: [site](#user-content-site) + [url](#user-content-url)

关于 Disqus 原生评论框配置的说明，可以看此页面：https://help.disqus.com/customer/portal/articles/472098-javascript-configuration-variables

### 引入 CSS

```html
<link rel="stylesheet" href="path/to/iDisqus.min.css" />
```

### 创建容器

```html
<div id="comment"></div>
```

### 引入 JS

```html
<script src="path/to/iDisqus.min.js"></script>
```

### 创建实例

```javascript
var disq = new iDisqus('comment', {
    forum: 'ifool',
    api: 'http://api.fooleap.org/disqus',
    site: 'http://blog.fooleap.org',
    mode: 1,
    timeout: 3000,
    init: true
});
```

### 配置参数

#### ID

* new iDisqus(`ID`, OPTIONS);
* DOM 节点的 id 属性
* {String}
* 默认：`"comment"`

#### OPTIONS

* new iDisqus(ID, `OPTIONS`);
* {Object}

##### api

* API 地址，PHP 代码部署的网址如：`http://api.fooleap.org/disqus`
* {String}
* **必填**，无默认值

##### forum

* Disqus forum 的 shortname
* {String}
* **必填**，无默认值

##### site

* 网站域名，建议填写，如：`http://blog.fooleap.org`
* {String}
* 默认：`location.origin`

##### url

* 页面链接，按需填写
* {String}
* 默认：`location.pathname + location.search`

##### identifier

* 页面标识，按需填写
* {String}
* 默认：[url](#user-content-url)

##### title

* 页面标题
* {String}
* 默认：`document.title`

##### mode

* `1` 检测能否访问 Disqus，若能则加载 Disqus 原生评论框，超时则加载简易评论框
* `2` 仅加载简易评论框
* `3` 同时加载两种评论框，先显示简易评论框，Disqus 加载完成则切换至 Disqus 评论框
* {Number}
* 默认：`1`

##### timeout

* 当 mode 为 1 时的超时时间
* {Number}
* 默认：`3000`

##### toggle

* 当 mode 为 3 时可用，作用是切换评论框
* 具体用法是在网页中放置一个 Checkbox，如 `<input type="checkbox" id="comment-toggle" disabled />`，此项则设置为 `"comment-toggle"`，当 Disqus 加载完时，选择框可用。
* {String}
* 无默认值

##### init

* 是否自动初始化
* {Boolean}
* 默认：`false`

##### autoCreate

* 是否自动创建 Thread，为了不创建垃圾 Thread，并不推荐设置为 `true`
* {Boolean}
* 默认：`false`

##### emojiPath

* Emoji 表情 PNG 图片路径
* {String}
* 默认：`"https://github.githubassets.com/images/icons/emoji/unicode/"`

##### emojiList

* 自定义评论框内的点选 Emoji 表情，具体可看 DEMO 页面
* {Object}

##### emojiPreview

* 评论预览是否支持 Emoji 短代码
* {Boolean}
* 默认：`false`

##### relatedType

* 相关文章类型，可选相关文章或热门文章
* {String}
* 默认：`Related`，可选`Popular`


### 实例方法

#### init

* 初始化评论框

#### destroy

* 销毁评论框 

#### count

* 加载评论数
* 用法：创建容器（可多个），加属性 data-disqus-url 值放页面链接，创建实例后执行则可显示评论数，具体可查看DEMO 页面

#### postsList

* 加载最近评论
* 用法：创建容器，指定Id（默认 disqusPostsList），创建实例后执行可显示最近评论，可通过指定参数设置加载评论数量（默认为 5）以及容器Id
