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

# Kernel Sources
git clone https://github.com/KDEFFALT/kernel_xiaomi_fog -b artifact-new kernel/xiaomi/fog

# Vendor Sources
git clone https://github.com/KDEFFALT/vendor_xiaomi_fog -b eleven vendor/xiaomi/fog

# fixup
sudo rm -rf packages/services/Telecomm
sudo rm -rf packages/apps/ManagedProvisioning
git clone https://github.com/KDEFFALT/packages_services_Telecomm -b eleven-xdcaf packages/services/Telecomm
git clone https://github.com/KDEFFALT/packages_apps_ManagedProvisioning -b eleven packages/apps/ManagedProvisioning

# Doubel definition
sudo mv packages/apps/Dialer/Android.mk packages/apps/Dialer/Androidmk

echo -e "${color}Finished sync!${end}"