#!/bin/bash
# Branding
sed -i 's/OpenWrt/DMS Firmware for HG680P/g' package/base-files/files/etc/banner

# Set password root menjadi '12345'
# Encrypted: $1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.
sed -i 's|root:::|root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:17854:0:99999:7:::|g' package/base-files/files/etc/shadow

# Aktifkan WiFi saat boot
uci set wireless.@wifi-device[0].disabled='0'
uci commit wireless

# Kosongkan password WiFi (open)
uci set wireless.@wifi-iface[0].encryption='none'
uci delete wireless.@wifi-iface[0].key
uci commit wireless