#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP 默认IP由0.1修改为1.1
sed -i 's/192.168.0.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# 最大连接数修改为65535
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65535' package/base-files/files/etc/sysctl.conf

# drop mosdns and v2ray-geodata packages that come with the source
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f

git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
#git clone https://github.com/RavenCage/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

#echo '替换golang到1.22.x'
#rm -rf feeds/packages/lang/golang
#git clone -b 22.x --single-branch https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
#echo '=========Replace golang OK!========='

#echo '替换xray-core到go1.21构建'
#rm -rf feeds/packages/net/xray-core
#git clone -b main --single-branch https://github.com/sbwml/xray-core feeds/packages/net/xray-core
#echo '=========Replace xray-core OK!========='
