#! /vendor/bin/sh

# Copyright (c) 2012-2013, 2016-2020, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

function 8953_sched_dcvs_eas()
{
    if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -ge 19 ]; then
        #governor settings
        echo 1 > /sys/devices/system/cpu/cpu0/online
        echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
        #set the hispeed_freq
        echo 1401600 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
        #default value for hispeed_load is 90, for 8953 and sdm450 it should be 85
        echo 85 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_load
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pl
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq

        echo 652800 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

        #input boost params
        echo 1401600 > /sys/module/cpu_boost/parameters/input_boost_freq
        echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms

        # sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
        echo -6 >  /sys/devices/system/cpu/cpu0/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu1/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu2/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu3/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu4/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu5/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost

        # Enable bus-dcvs
        for device in /sys/devices/platform/soc
        do
            for cpubw in $device/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw
            do
                echo "bw_hwmon" > $cpubw/governor
                echo 34 > $cpubw/bw_hwmon/io_percent
                echo 0 > $cpubw/bw_hwmon/guard_band_mbps
                echo 20 > $cpubw/bw_hwmon/hist_memory
                echo 10 > $cpubw/bw_hwmon/hyst_length
                echo 1600 > $cpubw/bw_hwmon/idle_mbps
                echo 20 > $cpubw/bw_hwmon/low_power_delay
                echo 34 > $cpubw/bw_hwmon/low_power_io_percent
                echo "1611 3221 5859 6445 7104" > $cpubw/bw_hwmon/mbps_zones
                echo 4 > $cpubw/bw_hwmon/sample_ms
                echo 250 > $cpubw/bw_hwmon/up_scale
                echo 1611 > $cpubw/min_freq
            done
        done
    else
        #governor settings
        echo 1 > /sys/devices/system/cpu/cpu0/online
        echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpufreq/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/schedutil/down_rate_limit_us
        #set the hispeed_freq
        echo 1401600 > /sys/devices/system/cpu/cpufreq/schedutil/hispeed_freq
        #default value for hispeed_load is 90, for 8953 and sdm450 it should be 85
        echo 85 > /sys/devices/system/cpu/cpufreq/schedutil/hispeed_load

        echo 652800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

    fi
}

function 8917_sched_dcvs_eas()
{
    if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -ge 19 ]; then
        #governor settings
        echo 1 > /sys/devices/system/cpu/cpu0/online
        echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
        #set the hispeed_freq
        echo 1094400 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
        #default value for hispeed_load is 90, for 8917 it should be 85
        echo 85 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_load
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pl
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq

        echo 960000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

        #input boost params
        echo 1094400 > /sys/module/cpu_boost/parameters/input_boost_freq
        echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms

        # sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
        echo -6 >  /sys/devices/system/cpu/cpu0/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu1/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu2/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu3/sched_load_boost

        # Enable bus-dcvs
        for device in /sys/devices/platform/soc
        do
            for cpubw in $device/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw
            do
                echo "bw_hwmon" > $cpubw/governor
                echo 20 > $cpubw/bw_hwmon/io_percent
                echo 30 > $cpubw/bw_hwmon/guard_band_mbps
            done
        done
    else
        #governor settings
        echo 1 > /sys/devices/system/cpu/cpu0/online
        echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpufreq/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/schedutil/down_rate_limit_us
        #set the hispeed_freq
        echo 1094400 > /sys/devices/system/cpu/cpufreq/schedutil/hispeed_freq
        #default value for hispeed_load is 90, for 8917 it should be 85
        echo 85 > /sys/devices/system/cpu/cpufreq/schedutil/hispeed_load

        echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    fi

    if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -ge 19 ]; then
        # memlat specific settings are moved to seperate file under
        # device/target specific folder
        setprop vendor.dcvs.prop 1
    fi
}

function 8937_sched_dcvs_eas()
{
    if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -ge 19 ]; then
        # enable governor for perf cluster
        echo 1 > /sys/devices/system/cpu/cpu0/online
        echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
        #set the hispeed_freq
        echo 1094400 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
        #default value for hispeed_load is 90, for 8937 it should be 85
        echo 85 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_load
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pl
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq

        echo 960000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

        ## enable governor for power cluster
        echo 1 > /sys/devices/system/cpu/cpu4/online
        echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
        #set the hispeed_freq
        echo 768000 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_freq
        #default value for hispeed_load is 90, for 8937 it should be 85
        echo 85 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_load
        echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/pl
        echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/rtg_boost_freq

        echo 768000 > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq

        #input boost params
        echo 109440 > /sys/module/cpu_boost/parameters/input_boost_freq
        echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms

        # sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
        echo -6 >  /sys/devices/system/cpu/cpu0/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu1/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu2/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu3/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu4/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu5/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost

        # Enable bus-dcvs
        for device in /sys/devices/platform/soc
        do
            for cpubw in $device/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw
            do
                echo "bw_hwmon" > $cpubw/governor
                echo 20 > $cpubw/bw_hwmon/io_percent
                echo 30 > $cpubw/bw_hwmon/guard_band_mbps
            done
        done
    else
        # enable governor for perf cluster
        echo 1 > /sys/devices/system/cpu/cpu0/online
        echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
        #set the hispeed_freq
        echo 1094400 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
        #default value for hispeed_load is 90, for 8937 it should be 85
        echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
        ## enable governor for power cluster
        echo 1 > /sys/devices/system/cpu/cpu4/online
        echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
        #set the hispeed_freq
        echo 768000 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
        #default value for hispeed_load is 90, for 8937 it should be 85
        echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load

        echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo 768000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    fi

    if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -ge 19 ]; then
        # memlat specific settings are moved to seperate file under
        # device/target specific folder
        setprop vendor.dcvs.prop 1
    fi
}

function configure_automotive_sku_parameters() {

    echo 1036800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    echo 1056000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    echo 1171200 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
    echo 1785600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    echo 902400000  > /sys/class/devfreq/18321110.qcom,cpu0-cpu-l3-lat/min_freq
    echo 902400000  > /sys/class/devfreq/18321110.qcom,cpu4-cpu-l3-lat/min_freq
    echo 902400000  > /sys/class/devfreq/18321110.qcom,cpu7-cpu-l3-lat/min_freq
    echo 1612800000 > /sys/class/devfreq/18321110.qcom,cpu0-cpu-l3-lat/max_freq
    echo 1612800000 > /sys/class/devfreq/18321110.qcom,cpu4-cpu-l3-lat/max_freq
    echo 1612800000 > /sys/class/devfreq/18321110.qcom,cpu7-cpu-l3-lat/max_freq
    echo 902400000  > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/min_freq
    echo 902400000  > /sys/class/devfreq/soc\:qcom,cpu4-cpu-l3-lat/min_freq
    echo 902400000  > /sys/class/devfreq/soc\:qcom,cpu7-cpu-l3-lat/min_freq
    echo 1612800000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/max_freq
    echo 1612800000 > /sys/class/devfreq/soc\:qcom,cpu4-cpu-l3-lat/max_freq
    echo 1612800000 > /sys/class/devfreq/soc\:qcom,cpu7-cpu-l3-lat/max_freq

#read feature id from nvram
reg_val=`cat /sys/devices/platform/soc/780130.qfprom/qfprom0/nvmem | od -An -t d4`
feature_id=$(((reg_val >> 20) & 0xFF))
log -t BOOT -p i "feature id '$feature_id'"
if [ $feature_id == 0 ]; then
       echo " SKU Configured : SA8155P"
       echo 2131200 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
       echo 2419200 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
       echo 0 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
elif [ $feature_id == 1 ]; then
        echo "SKU Configured : SA8150P"
        echo 1920000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        echo 2227200 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
        echo 3 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
else
        echo "unknown feature_id value" $feature_id
fi
}

function configure_automotive_sku_parameters_sa8195() {

	#Setting the min supported frequencies
        echo 1113600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo 1171200 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
        echo 940800000  > /sys/class/devfreq/18321110.qcom,cpu0-cpu-l3-lat/min_freq
        echo 940800000  > /sys/class/devfreq/18321110.qcom,cpu4-cpu-l3-lat/min_freq
        echo 1651200000 > /sys/class/devfreq/18321110.qcom,cpu0-cpu-l3-lat/max_freq
        echo 1651200000 > /sys/class/devfreq/18321110.qcom,cpu4-cpu-l3-lat/max_freq
	echo 940800000  > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/min_freq
        echo 940800000  > /sys/class/devfreq/soc\:qcom,cpu4-cpu-l3-lat/min_freq
        echo 1651200000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/max_freq
	echo 1651200000 > /sys/class/devfreq/soc\:qcom,cpu4-cpu-l3-lat/max_freq

	#read feature id
        reg_val=`cat /sys/devices/platform/soc/780130.qfprom/qfprom0/nvmem | od -An -t d4`
        feature_id=$(((reg_val >> 20) & 0xFF))

        #setting min gpu freq to 392  MHz
        echo 4 > /sys/class/kgsl/kgsl-3d0/min_pwrlevel
        if [ $feature_id == 0 ]; then
                echo "feature_id is 0 for SA8195AA"

                #setting max cpu freq to 2.496GHz
                echo 2496000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
                #setting max gpu freq to 530 MHz
                echo 3 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
		echo 1804 > /sys/devices/platform/soc/soc:aop-set-ddr-freq/set_ddr_capped_freq
        elif [ $feature_id == 1 ] || [ $feature_id == 2 ]; then
                echo "feature_id is 1 for external SA8195AB"
                echo "feature_id is 2 for internal SA8195AB"

                #setting max cpu freq to 2.496GHz
                echo 2496000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
                #setting max gpu freq to 670 MHz
                echo 0 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
		echo 2092 > /sys/devices/platform/soc/soc:aop-set-ddr-freq/set_ddr_capped_freq
        elif [ $feature_id == 3 ]; then
                echo "feature_id is 3 for external SA8195AC"
        else
                echo "unknown feature_id value" $feature_id
        fi
}

function configure_sku_parameters() {

#read feature id from nvram
reg_val=`cat /sys/devices/platform/soc/780130.qfprom/qfprom0/nvmem | od -An -t d4`
feature_id=$(((reg_val >> 20) & 0xFF))
log -t BOOT -p i "feature id '$feature_id'"
if [ $feature_id == 6 ]; then
	echo " SKU Configured : SA6145"
	echo 748800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 748800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
	echo 748800 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
	echo 748800 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
	echo 748800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	echo 748800 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
	echo 1017600 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
	echo 1017600 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
	echo 940800000 > /sys/class/devfreq/18321110.qcom,cpu0-cpu-l3-lat/min_freq
	echo 1017600000 > /sys/class/devfreq/18321110.qcom,cpu0-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/18321110.qcom,cpu6-cpu-l3-lat/min_freq
	echo 1017600000 > /sys/class/devfreq/18321110.qcom,cpu6-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/min_freq
	echo 1017600000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/min_freq
	echo 1017600000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/max_freq
	echo 3 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
	echo 1016 > /sys/devices/platform/soc/soc:aop-set-ddr-freq/set_ddr_capped_freq
	setprop vendor.sku_identified 1
	setprop vendor.sku_name "SA6145"
elif [ $feature_id == 5 ]; then
	echo "SKU Configured : SA6150"
	echo 748800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
	echo 998400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 998400 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
	echo 998400 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
	echo 998400 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
	echo 998400 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	echo 998400 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
	echo 1708800 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
	echo 1708800 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
	echo 940800000 > /sys/class/devfreq/18321110.qcom,cpu0-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/18321110.qcom,cpu0-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/18321110.qcom,cpu6-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/18321110.qcom,cpu6-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/max_freq
	echo 2 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
	echo 1333 > /sys/devices/platform/soc/soc:aop-set-ddr-freq/set_ddr_capped_freq
	setprop vendor.sku_identified 1
	setprop vendor.sku_name "SA6150"
elif [ $feature_id == 4 ] || [ $feature_id == 3 ]; then
	echo "SKU Configured : SA6155"
	echo 748800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
	echo 1593600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
	echo 1900800 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
	echo 1900800 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
	echo 940800000 > /sys/class/devfreq/18321110.qcom,cpu0-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/18321110.qcom,cpu0-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/18321110.qcom,cpu6-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/18321110.qcom,cpu6-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/max_freq
	echo 0 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
	echo 1555 > /sys/devices/platform/soc/soc:aop-set-ddr-freq/set_ddr_capped_freq
	setprop vendor.sku_identified 1
	setprop vendor.sku_name "SA6155"
else
	echo "SKU Configured : SA6155"
	echo 748800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
	echo 1593600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
	echo 1900800 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
	echo 1900800 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
	echo 940800000 > /sys/class/devfreq/18321110.qcom,cpu0-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/18321110.qcom,cpu0-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/18321110.qcom,cpu6-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/18321110.qcom,cpu6-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/max_freq
	echo 0 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
	echo 1555 > /sys/devices/platform/soc/soc:aop-set-ddr-freq/set_ddr_capped_freq
        setprop vendor.sku_identified 1
	setprop vendor.sku_name "SA6155"
fi
}

function 8953_sched_dcvs_hmp()
{
    #scheduler settings
    echo 3 > /proc/sys/kernel/sched_window_stats_policy
    echo 3 > /proc/sys/kernel/sched_ravg_hist_size
    #task packing settings
    echo 0 > /sys/devices/system/cpu/cpu0/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu1/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu2/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu3/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu4/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu5/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu6/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu7/sched_static_cpu_pwr_cost
    # spill load is set to 100% by default in the kernel
    echo 3 > /proc/sys/kernel/sched_spill_nr_run
    # Apply inter-cluster load balancer restrictions
    echo 1 > /proc/sys/kernel/sched_restrict_cluster_spill
    # set sync wakee policy tunable
    echo 1 > /proc/sys/kernel/sched_prefer_sync_wakee_to_waker

    #governor settings
    echo 1 > /sys/devices/system/cpu/cpu0/online
    echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "19000 1401600:39000" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
    echo 85 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
    echo 1401600 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
    echo "85 1401600:80" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
    echo 39000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
    echo 40000 > /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
    echo 19 > /proc/sys/kernel/sched_upmigrate_min_nice
    # Enable sched guided freq control
    echo 1 > /sys/devices/system/cpu/cpufreq/interactive/use_sched_load
    echo 1 > /sys/devices/system/cpu/cpufreq/interactive/use_migration_notif
    echo 200000 > /proc/sys/kernel/sched_freq_inc_notify
    echo 200000 > /proc/sys/kernel/sched_freq_dec_notify

}

function 8917_sched_dcvs_hmp()
{
    # HMP scheduler settings
    echo 3 > /proc/sys/kernel/sched_window_stats_policy
    echo 3 > /proc/sys/kernel/sched_ravg_hist_size
    echo 1 > /proc/sys/kernel/sched_restrict_tasks_spread
    # HMP Task packing settings
    echo 20 > /proc/sys/kernel/sched_small_task
    echo 30 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_load

    echo 3 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run

    echo 0 > /sys/devices/system/cpu/cpu0/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu1/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu2/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu3/sched_prefer_idle

    echo 1 > /sys/devices/system/cpu/cpu0/online
    echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "19000 1094400:39000" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
    echo 85 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
    echo 1094400 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
    echo "1 960000:85 1094400:90" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
    echo 40000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
    echo 40000 > /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor

    # Enable sched guided freq control
    echo 1 > /sys/devices/system/cpu/cpufreq/interactive/use_sched_load
    echo 1 > /sys/devices/system/cpu/cpufreq/interactive/use_migration_notif
    echo 50000 > /proc/sys/kernel/sched_freq_inc_notify
    echo 50000 > /proc/sys/kernel/sched_freq_dec_notify
}

function 8937_sched_dcvs_hmp()
{
    # HMP scheduler settings
    echo 3 > /proc/sys/kernel/sched_window_stats_policy
    echo 3 > /proc/sys/kernel/sched_ravg_hist_size
    # HMP Task packing settings
    echo 20 > /proc/sys/kernel/sched_small_task
    echo 30 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu4/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu5/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu6/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu7/sched_mostly_idle_load

    echo 3 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu4/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu5/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu6/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu7/sched_mostly_idle_nr_run

    echo 0 > /sys/devices/system/cpu/cpu0/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu1/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu2/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu3/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu4/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu5/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu6/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu7/sched_prefer_idle
    # enable governor for perf cluster
    echo 1 > /sys/devices/system/cpu/cpu0/online
    echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "19000 1094400:39000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
    echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
    echo 1094400 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
    echo "1 960000:85 1094400:90 1344000:80" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
    echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
    echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/sampling_down_factor

    # enable governor for power cluster
    echo 1 > /sys/devices/system/cpu/cpu4/online
    echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo 39000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
    echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
    echo 768000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
    echo "1 768000:90" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
    echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
    echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/sampling_down_factor

    # Enable sched guided freq control
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
    echo 50000 > /proc/sys/kernel/sched_freq_inc_notify
    echo 50000 > /proc/sys/kernel/sched_freq_dec_notify

}

function sdm660_sched_interactive_dcvs() {

    echo 0 > /proc/sys/kernel/sched_select_prev_cpu_us
    echo 400000 > /proc/sys/kernel/sched_freq_inc_notify
    echo 400000 > /proc/sys/kernel/sched_freq_dec_notify
    echo 5 > /proc/sys/kernel/sched_spill_nr_run
    echo 1 > /proc/sys/kernel/sched_restrict_cluster_spill
    echo 100000 > /proc/sys/kernel/sched_short_burst_ns
    echo 1 > /proc/sys/kernel/sched_prefer_sync_wakee_to_waker
    echo 20 > /proc/sys/kernel/sched_small_wakee_task_load

    # disable thermal bcl hotplug to switch governor
    echo 0 > /sys/module/msm_thermal/core_control/enabled

    # online CPU0
    echo 1 > /sys/devices/system/cpu/cpu0/online
    # configure governor settings for little cluster
    echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
    echo "19000 1401600:39000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
    echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
    echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
    echo "85 1747200:95" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
    echo 39000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
    echo 633600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/fast_ramp_down
    # online CPU4
    echo 1 > /sys/devices/system/cpu/cpu4/online
    # configure governor settings for big cluster
    echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
    echo "19000 1401600:39000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
    echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
    echo 1401600 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
    echo "85 1401600:90 2150400:95" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
    echo 39000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
    echo 59000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
    echo 1113600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/ignore_hispeed_on_notif
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/fast_ramp_down

    # bring all cores online
    echo 1 > /sys/devices/system/cpu/cpu0/online
    echo 1 > /sys/devices/system/cpu/cpu1/online
    echo 1 > /sys/devices/system/cpu/cpu2/online
    echo 1 > /sys/devices/system/cpu/cpu3/online
    echo 1 > /sys/devices/system/cpu/cpu4/online
    echo 1 > /sys/devices/system/cpu/cpu5/online
    echo 1 > /sys/devices/system/cpu/cpu6/online
    echo 1 > /sys/devices/system/cpu/cpu7/online

    # configure LPM
    echo N > /sys/module/lpm_levels/system/pwr/cpu0/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/pwr/cpu1/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/pwr/cpu2/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/pwr/cpu3/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/perf/cpu4/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/perf/cpu5/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/perf/cpu6/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/perf/cpu7/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-dynret/idle_enabled
    echo N > /sys/module/lpm_levels/system/perf/perf-l2-dynret/idle_enabled
    echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/perf/perf-l2-ret/idle_enabled

    # re-enable thermal and BCL hotplug
    echo 1 > /sys/module/msm_thermal/core_control/enabled

    # Enable bus-dcvs
    for cpubw in /sys/class/devfreq/*qcom,cpubw*
        do
            echo "bw_hwmon" > $cpubw/governor
            echo 50 > $cpubw/polling_interval
            echo 762 > $cpubw/min_freq
            echo "1525 3143 5859 7759 9887 10327 11863 13763" > $cpubw/bw_hwmon/mbps_zones
            echo 4 > $cpubw/bw_hwmon/sample_ms
            echo 85 > $cpubw/bw_hwmon/io_percent
            echo 100 > $cpubw/bw_hwmon/decay_rate
            echo 50 > $cpubw/bw_hwmon/bw_step
            echo 20 > $cpubw/bw_hwmon/hist_memory
            echo 0 > $cpubw/bw_hwmon/hyst_length
            echo 80 > $cpubw/bw_hwmon/down_thres
            echo 0 > $cpubw/bw_hwmon/low_power_ceil_mbps
            echo 34 > $cpubw/bw_hwmon/low_power_io_percent
            echo 20 > $cpubw/bw_hwmon/low_power_delay
            echo 0 > $cpubw/bw_hwmon/guard_band_mbps
            echo 250 > $cpubw/bw_hwmon/up_scale
            echo 1600 > $cpubw/bw_hwmon/idle_mbps
        done

    for memlat in /sys/class/devfreq/*qcom,memlat-cpu*
        do
            echo "mem_latency" > $memlat/governor
            echo 10 > $memlat/polling_interval
            echo 400 > $memlat/mem_latency/ratio_ceil
        done
    echo "cpufreq" > /sys/class/devfreq/soc:qcom,mincpubw/governor
}

function sdm660_sched_schedutil_dcvs() {

    if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -ge 19 ]; then
        # configure governor settings for little cluster
        echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
        echo 1401600 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pl
        echo 633600 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
        echo 902400 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq

        # configure governor settings for big cluster
        echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
        echo 1401600 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_freq
        echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/pl
        echo 1113600 > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
        echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/rtg_boost_freq
    else
        # configure governor settings for little cluster
        echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
        echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq

        # configure governor settings for big cluster
        echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
        echo 1401600 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
    fi

    echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

    #if the kernel version >=4.19,set input_boost_freq accordingly
    if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -ge 19 ]; then
        echo "0:1401600" > /sys/devices/system/cpu/cpu_boost/input_boost_freq
        echo 40 > /sys/devices/system/cpu/cpu_boost/input_boost_ms
    else
        echo "0:1401600" > /sys/module/cpu_boost/parameters/input_boost_freq
        echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
    fi

    # sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
    echo -6 >  /sys/devices/system/cpu/cpu0/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu1/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu2/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu3/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu4/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu5/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost
    echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
    echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load

    # Enable bus-dcvs
    for device in /sys/devices/platform/soc
    do
        for cpubw in $device/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw
        do
            echo "bw_hwmon" > $cpubw/governor
            echo 50 > $cpubw/polling_interval
            echo 762 > $cpubw/min_freq
            echo "1525 3143 5859 7759 9887 10327 11863 13763" > $cpubw/bw_hwmon/mbps_zones
            echo 4 > $cpubw/bw_hwmon/sample_ms
            echo 85 > $cpubw/bw_hwmon/io_percent
            echo 100 > $cpubw/bw_hwmon/decay_rate
            echo 50 > $cpubw/bw_hwmon/bw_step
            echo 20 > $cpubw/bw_hwmon/hist_memory
            echo 0 > $cpubw/bw_hwmon/hyst_length
            echo 80 > $cpubw/bw_hwmon/down_thres
            echo 0 > $cpubw/bw_hwmon/guard_band_mbps
            echo 250 > $cpubw/bw_hwmon/up_scale
            echo 1600 > $cpubw/bw_hwmon/idle_mbps
        done

        if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -le 14 ]; then
            for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
            do
                echo "mem_latency" > $memlat/governor
                echo 10 > $memlat/polling_interval
                echo 400 > $memlat/mem_latency/ratio_ceil
            done

            for latfloor in $device/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
            do
                echo "compute" > $latfloor/governor
                echo 10 > $latfloor/polling_interval
            done
        fi
    done

    if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -ge 19 ]; then
        # memlat specific settings are moved to seperate file under
        # device/target specific folder
        setprop vendor.dcvs.prop 1
    fi

}

target=`getprop ro.board.platform`

function configure_zram_parameters() {
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}

    low_ram=`getprop ro.config.low_ram`

    # Zram disk - 75% for Go devices.
    # For 512MB Go device, size = 384MB, set same for Non-Go.
    # For 1GB Go device, size = 768MB, set same for Non-Go.
    # For 2GB Go device, size = 1536MB, set same for Non-Go.
    # For >2GB Non-Go devices, size = 50% of RAM size. Limit the size to 4GB.
    # And enable lz4 zram compression for Go targets.

    let RamSizeGB="( $MemTotal / 1048576 ) + 1"
    diskSizeUnit=M
    if [ $RamSizeGB -le 2 ]; then
        let zRamSizeMB="( $RamSizeGB * 1024 ) * 3 / 4"
    else
        let zRamSizeMB="( $RamSizeGB * 1024 ) / 2"
    fi

    # use MB avoid 32 bit overflow
    if [ $zRamSizeMB -gt 4096 ]; then
        let zRamSizeMB=4096
    fi

    if [ "$low_ram" == "true" ]; then
        echo lz4 > /sys/block/zram0/comp_algorithm
    fi

    if [ -f /sys/block/zram0/disksize ]; then
        if [ -f /sys/block/zram0/use_dedup ]; then
            echo 1 > /sys/block/zram0/use_dedup
        fi
        echo "$zRamSizeMB""$diskSizeUnit" > /sys/block/zram0/disksize

        # ZRAM may use more memory than it saves if SLAB_STORE_USER
        # debug option is enabled.
        if [ -e /sys/kernel/slab/zs_handle ]; then
            echo 0 > /sys/kernel/slab/zs_handle/store_user
        fi
        if [ -e /sys/kernel/slab/zspage ]; then
            echo 0 > /sys/kernel/slab/zspage/store_user
        fi

        mkswap /dev/block/zram0
        swapon /dev/block/zram0 -p 32758
    fi
}

function configure_read_ahead_kb_values() {
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}

    dmpts=$(ls /sys/block/*/queue/read_ahead_kb | grep -e dm -e mmc)

    # Set 128 for <= 3GB &
    # set 512 for >= 4GB targets.
    if [ $MemTotal -le 3145728 ]; then
        echo 128 > /sys/block/mmcblk0/bdi/read_ahead_kb
        echo 128 > /sys/block/mmcblk0rpmb/bdi/read_ahead_kb
        for dm in $dmpts; do
            echo 128 > $dm
        done
    else
        echo 512 > /sys/block/mmcblk0/bdi/read_ahead_kb
        echo 512 > /sys/block/mmcblk0rpmb/bdi/read_ahead_kb
        for dm in $dmpts; do
            echo 512 > $dm
        done
    fi
}

function configure_memory_parameters() {
    # Set Memory parameters.
    #
    # Set per_process_reclaim tuning parameters
    # All targets will use vmpressure range 50-70,
    # All targets will use 512 pages swap size.
    #
    # Set Low memory killer minfree parameters
    # 32 bit Non-Go, all memory configurations will use 15K series
    # 32 bit Go, all memory configurations will use uLMK + Memcg
    # 64 bit will use Google default LMK series.
    #
    # Set ALMK parameters (usually above the highest minfree values)
    # vmpressure_file_min threshold is always set slightly higher
    # than LMK minfree's last bin value for all targets. It is calculated as
    # vmpressure_file_min = (last bin - second last bin ) + last bin
    #
    # Set allocstall_threshold to 0 for all targets.
    #

low_ram=`getprop ro.config.low_ram`

# Enable ZRAM
configure_zram_parameters
configure_read_ahead_kb_values
echo 0 > /proc/sys/vm/page-cluster
echo 100 > /proc/sys/vm/swappiness

# Set parameters for 32-bit Go targets.
if [ "$low_ram" == "true" ]; then
    if [ -f /proc/sys/vm/reap_mem_on_sigkill ]; then
        echo 1 > /proc/sys/vm/reap_mem_on_sigkill
    fi
else
    #Set PPR nomap parameters for bengal targets
    echo 1 > /sys/module/process_reclaim/parameters/enable_process_reclaim
    echo 50 > /sys/module/process_reclaim/parameters/pressure_min
    echo 70 > /sys/module/process_reclaim/parameters/pressure_max
    echo 30 > /sys/module/process_reclaim/parameters/swap_opt_eff
    echo 0 > /sys/module/process_reclaim/parameters/per_swap_size
    echo 7680 > /sys/module/process_reclaim/parameters/tsk_nomap_swap_sz

    # Disable wsf for all targets beacause we are using efk.
    # wsf Range : 1..1000 So set to bare minimum value 1.
    echo 1 > /proc/sys/vm/watermark_scale_factor

    # Disable the feature of watermark boost
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}

    if [ $MemTotal -le 6291456 ]; then
        echo 0 > /proc/sys/vm/watermark_boost_factor
    fi
fi
}

function enable_memory_features()
{
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}

setprop vendor.post_boot.parsed 1

# power/perf tunings for khaje
# Core control parameters on big
echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable
echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
echo 40 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

# Setting b.L scheduler parameters
echo 65 > /proc/sys/kernel/sched_downmigrate
echo 71 > /proc/sys/kernel/sched_upmigrate
echo 85 > /proc/sys/kernel/sched_group_downmigrate
echo 100 > /proc/sys/kernel/sched_group_upmigrate
echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

# cpuset settings
echo 0-2     > /dev/cpuset/background/cpus
echo 0-3     > /dev/cpuset/system-background/cpus
echo 4-7     > /dev/cpuset/foreground/boost/cpus
echo 0-2,4-7 > /dev/cpuset/foreground/cpus
echo 0-7     > /dev/cpuset/top-app/cpus

# configure governor settings for little cluster
echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
echo 1516800 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/rtg_boost_freq

# configure governor settings for big cluster
echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
echo 1344000 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
echo 1056000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/rtg_boost_freq

echo "0:1190000" > /sys/devices/system/cpu/cpu_boost/input_boost_freq
echo 120 > /sys/devices/system/cpu/cpu_boost/input_boost_ms

# sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
echo -6 >  /sys/devices/system/cpu/cpu0/sched_load_boost
echo -6 >  /sys/devices/system/cpu/cpu1/sched_load_boost
echo -6 >  /sys/devices/system/cpu/cpu2/sched_load_boost
echo -6 >  /sys/devices/system/cpu/cpu3/sched_load_boost
echo -6 >  /sys/devices/system/cpu/cpu4/sched_load_boost
echo -6 >  /sys/devices/system/cpu/cpu5/sched_load_boost
echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost
echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load

# Set Memory parameters
configure_memory_parameters

# Enable bus-dcvs
for device in /sys/devices/platform/soc
do
    for cpubw in $device/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw
    do
        echo "bw_hwmon" > $cpubw/governor
        echo 50 > $cpubw/polling_interval
        echo 762 > $cpubw/min_freq
        echo "2288 3440 4173 5195 5859 7759 10322 11863 13763 15960" > $cpubw/bw_hwmon/mbps_zones
        echo 85 > $cpubw/bw_hwmon/io_percent
        echo 4 > $cpubw/bw_hwmon/sample_ms
        echo 90 > $cpubw/bw_hwmon/decay_rate
        echo 190 > $cpubw/bw_hwmon/bw_step
        echo 20 > $cpubw/bw_hwmon/hist_memory
        echo 0 > $cpubw/bw_hwmon/hyst_length
        echo 80 > $cpubw/bw_hwmon/down_thres
        echo 0 > $cpubw/bw_hwmon/guard_band_mbps
        echo 250 > $cpubw/bw_hwmon/up_scale
        echo 1600 > $cpubw/bw_hwmon/idle_mbps
    done
done

# memlat specific settings are moved to seperate file under
# device/target specific folder
for device in /sys/devices/platform/soc
do
    for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
    do
        echo "mem_latency" > $memlat/governor
        echo 10 > $memlat/polling_interval
        echo 400 > $memlat/mem_latency/ratio_ceil
    done

    for latfloor in $device/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
    do
        echo "compute" > $latfloor/governor
        echo 10 > $latfloor/polling_interval
    done
done

# colcoation v3 disabled
echo 0 > /proc/sys/kernel/sched_min_task_util_for_boost
echo 0 > /proc/sys/kernel/sched_min_task_util_for_colocation

# Turn off scheduler boost at the end
echo 0 > /proc/sys/kernel/sched_boost

# Turn on sleep modes
echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
