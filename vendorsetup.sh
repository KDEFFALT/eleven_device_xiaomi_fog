# ROM source patches

color="\033[0;32m"
end="\033[0m"

echo -e "${color}Applying patches${end}"
sleep 1

# Remove pixel headers to avoid conflicts
rm -rf hardware/google/pixel/kernel_headers/Android.bp

# Remove megvii libs on hardware/xiaomi to avoid conflicts
rm -rf hardware/xiaomi/megvii

# Kernel Sources
git clone https://github.com/KDEFFALT/kernel_xiaomi_fog -b artifact-new kernel/xiaomi/fog

# Bengal HALs
git clone https://github.com/KDEFFALT/hardware_qcom-caf_bengal -b eleven hardware/qcom-caf/bengal

# Vendor Sources
git clone https://github.com/KDEFFALT/vendor_xiaomi_fog -b eleven vendor/xiaomi/fog

# Proton clang
git clone --depth=1 https://github.com/kdrag0n/proton-clang prebuilts/clang/host/linux-x86/clang-proton

# Vanillaify

# Dialer
sudo rm -rf vendor/codeaurora/commonsys/packages/apps/Dialer
git clone https://github.com/KDEFFALT/android_packages_apps_Dialer -b los18.1-clo packages/apps/Dialer

echo -e "${color}Finished sync!${end}"