# 修改默认IP
sed -i 's/192.168.1.1/192.168.30.12/g' package/base-files/files/bin/config_generate

# 修改默认主题
rm -rf feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
cp -f $GITHUB_WORKSPACE/scripts/bg1.jpg feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
sed -i "s/luci-theme-bootstrap/luci-theme-argon/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")

# 修改主机名
sed -i 's/ImmortalWrt/QWRT/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/QWRT/g' include/version.mk
sed -i 's/SNAPSHOT/ /g' include/version.mk

# 删除luci首页显示
sed -i '/Target Platform/d' feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js

# 关闭RFC1918
sed -i 's/option rebind_protection 1/option rebind_protection 0/g' package/network/services/dnsmasq/files/dhcp.conf

# 修改插件位置
sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/root/usr/share/luci/menu.d/luci-app-zerotier.json

# etc默认设置
cp -a $GITHUB_WORKSPACE/scripts/etc/* package/base-files/files/etc/

./scripts/feeds update -a
./scripts/feeds install -a
