'use strict'
const merge = require('webpack-merge')
const prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  // 接口地址配置
  BASE_URL: '"http://192.168.1.2:9000"',
  //ws 服务的地址配置
  WS_BASE_URL:'"ws://xxxx"',
  //cookie 的过期时间
  COOKIE_EXPIRED: 14,
  //cookie 域名
  COOKIE_DOMAIN: '"192.168.1.2"',
  //cookie 存储前缀
  COOKIE_SUFFIX: '"_TCLOUD_DEV"',
  //企业微信扫码登录的相关配置
  QYWX_APPID: '"xxxx"',
  QYWX_AGENTID: '"xxxx"',
  QYEX_REDIRECT_URI: '"xxxx"',
  STF_URL:'"http://192.168.1.2:7100"',
  LOCAL_FILE_HOST:'"http://192.168.1.2:9042"'
})
