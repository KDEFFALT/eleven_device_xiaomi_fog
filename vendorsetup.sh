# ROM source patches

color="\033[0;32m"
end="\033[0m"

echo -e "${color}Applying patches${end}"
sleep 1

# Remove pixel headers to avoid conflicts
rm -rf hardware/google/pixel/kernel_headers/Android.bp

# Remove included hardware_xiaomi
rm -rf hardware/xiaomi

# clone lineage os hardware_xiaomi
git clone https://github.com/LineageOS/android_hardware_xiaomi -b lineage-18.1 hardware/xiaomi

# Remove megvii libs on hardware/xiaomi to avoid conflicts
rm -rf hardware/xiaomi/megvii

# Vendor Sources
git clone https://github.com/KDEFFALT/vendor_xiaomi_fog -b eleven vendor/xiaomi/fog

# fixup 
sudo mv packages/apps/Dialer/Android.mk packages/apps/Dialer/Androidmk

echo -e "${color}Finished sync!${end}"