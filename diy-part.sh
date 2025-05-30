#!/bin/bash
# diy-part.sh untuk DMS HG680P

# =======================
# ✅ Branding Banner
# =======================
sed -i 's/OpenWrt/DMS Firmware for HG680P/g' package/base-files/files/etc/banner

# =======================
# ✅ Root password: 12345 (hash OpenWRT default)
# =======================
# Hash untuk password "12345" (via OpenWRT default)
# Ini akan overwrite shadow file agar root bisa login dengan 12345
sed -i 's|root:::|root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::|g' package/base-files/files/etc/shadow

# =======================
# ✅ WiFi aktif dan tanpa password saat boot
#     Ditambahkan melalui uci-defaults
# =======================
mkdir -p package/base-files/files/etc/uci-defaults
cat << 'EOF' > package/base-files/files/etc/uci-defaults/99-wifi-dms
#!/bin/sh
uci set wireless.@wifi-device[0].disabled='0'
uci set wireless.@wifi-iface[0].encryption='none'
uci delete wireless.@wifi-iface[0].key
uci commit wireless
EOF

chmod +x package/base-files/files/etc/uci-defaults/99-wifi-dms
