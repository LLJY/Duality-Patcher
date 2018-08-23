#! /vendor/bin/sh

# Copyright (c) 2012-2013, 2016, The Linux Foundation. All rights reserved.
# Copyright (C) 2017 Sony Mobile Communications Inc.
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
# NOTE: This file has been modified by Sony Mobile Communications Inc.
# Modifications are licensed under the License.
#

# disable thermal bcl hotplug to switch governor
echo 0 > /sys/module/msm_thermal/core_control/enabled
echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
bcl_hotplug_mask=`cat /sys/devices/soc/soc:qcom,bcl/hotplug_mask`
echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_mask
bcl_soc_hotplug_mask=`cat /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask`
echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
echo -n enable > /sys/devices/soc/soc:qcom,bcl/mode
# set sync wakee policy tunable
echo 1 > /proc/sys/kernel/sched_prefer_sync_wakee_to_waker
# configure governor settings for little cluster
echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
echo 80 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo 79000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
echo 307200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/enable_prediction
# online CPU2
echo 1 > /sys/devices/system/cpu/cpu2/online
# configure governor settings for big cluster
echo "interactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_sched_load
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_migration_notif
echo "19000 1400000:39000 1700000:19000 2100000:79000" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/above_hispeed_delay
echo 90 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/go_hispeed_load
echo 20000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/timer_rate
echo 1248000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/hispeed_freq
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/io_is_busy
echo "85 1500000:90 1800000:70 2100000:95" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/target_loads
echo 19000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/min_sample_time
echo 79000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/max_freq_hysteresis
echo 307200 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/ignore_hispeed_on_notif
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/enable_prediction
# re-enable thermal and BCL hotplug
echo 1 > /sys/module/msm_thermal/core_control/enabled
echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
echo $bcl_hotplug_mask > /sys/devices/soc/soc:qcom,bcl/hotplug_mask
echo $bcl_soc_hotplug_mask > /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
echo -n enable > /sys/devices/soc/soc:qcom,bcl/mode
# input boost configuration
echo "0:1228800 2:1324800" > /sys/module/cpu_boost/parameters/input_boost_freq
echo 90 > /sys/module/cpu_boost/parameters/input_boost_ms
echo "0:1113600 2:1248000" > /sys/module/cpu_boost/parameters/input_boost_freq_s2
echo 150 > /sys/module/cpu_boost/parameters/input_boost_ms_s2
# Setting b.L scheduler parameters
echo 0 > /proc/sys/kernel/sched_boost
echo 1 > /proc/sys/kernel/sched_migration_fixup
echo 95 > /proc/sys/kernel/sched_upmigrate
echo 90 > /proc/sys/kernel/sched_downmigrate
echo 400000 > /proc/sys/kernel/sched_freq_inc_notify
echo 400000 > /proc/sys/kernel/sched_freq_dec_notify
echo 3 > /proc/sys/kernel/sched_spill_nr_run
echo 100 > /proc/sys/kernel/sched_init_task_load
echo 9 > /proc/sys/kernel/sched_upmigrate_min_nice
# Enable bus-dcvs
for cpubw in /sys/class/devfreq/*qcom,cpubw*
do
    echo "bw_hwmon" > $cpubw/governor
    echo 50 > $cpubw/polling_interval
    echo 1525 > $cpubw/min_freq
    echo "1525 5195 11863 13763" > $cpubw/bw_hwmon/mbps_zones
    echo 4 > $cpubw/bw_hwmon/sample_ms
    echo 34 > $cpubw/bw_hwmon/io_percent
    echo 20 > $cpubw/bw_hwmon/hist_memory
    echo 10 > $cpubw/bw_hwmon/hyst_length
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
done
echo "cpufreq" > /sys/class/devfreq/soc:qcom,mincpubw/governor
echo N > /sys/module/lpm_levels/parameters/sleep_disabled

# Post-setup services
setprop sys.post_boot.parsed 1

# Let kernel know our image version/variant/crm_version
image_version="10:"
image_version+=`getprop ro.build.id`
image_version+=":"
image_version+=`getprop ro.build.version.incremental`
image_variant=`getprop ro.product.name`
image_variant+="-"
image_variant+=`getprop ro.build.type`
oem_version=`getprop ro.build.version.codename`
echo 10 > /sys/devices/soc0/select_image
echo $image_version > /sys/devices/soc0/image_version
echo $image_variant > /sys/devices/soc0/image_variant
echo $oem_version > /sys/devices/soc0/image_crm_version

# Change console log level as per console config property
console_config=`getprop persist.console.silent.config`
case "$console_config" in
    "1")
        echo "Enable console config to $console_config"
        echo 0 > /proc/sys/kernel/printk
        ;;
    *)
        echo "Enable console config to $console_config"
        ;;
esac
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 1593600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq      
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo 70 480000:58 556800:75 729600:82 960000:86 1036800:2 1113600:1 1228800:96 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads 
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/*
echo 80000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
echo 307200 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
echo 80000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo 0 729600:66000 960000:72000 1228800:90000 1478400:100000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo 155 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo 22000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/fast_ramp_down
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/align_windows
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/enable_prediction
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/enable_prediction
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo interactive > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor         
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo 2265000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq            
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/interactive/target_loads
echo 65 307200:69 940800:80 1036800:2 1113600:1 1248000:82 1401600:84 1824000:86 2150400:85 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/target_loads 
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/interactive/target_loads
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/interactive/*
#Tweak Interactive Governor
echo 90000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/timer_slack
echo 1401600 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/hispeed_freq
echo 90000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/timer_rate
echo 32000 940800:75000 1248000:60000 1401600:80000 1632000:80000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/above_hispeed_delay
echo 400 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/go_hispeed_load
echo 9000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/min_sample_time
echo 0 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/max_freq_hysteresis
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/ignore_hispeed_on_notif
echo 0 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/boost
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/fast_ramp_down
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/align_windows
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_migration_notif
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_sched_load
echo 0 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/boostpulse_duration
echo 0 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/io_is_busy
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/interactive/enable_prediction
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/enable_prediction
chmod 644 /sys/module/cpu_boost/parameters/input_boost_freq
echo 0:729600 1:0 2:940800 3:0 > /sys/module/cpu_boost/parameters/input_boost_freq
echo "0:1228800 2:1324800" > /sys/module/cpu_boost/parameters/input_boost_freq_s2
echo 50 > /sys/module/cpu_boost/parameters/input_boost_ms
echo 150 > /sys/module/cpu_boost/parameters/input_boost_ms_s2
#Disable BCL
echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
#echo Tweaking HMP Scheduler for correcting BIG Cluster utilization
echo 2 > /proc/sys/kernel/sched_window_stats_policy
echo 85 > /proc/sys/kernel/sched_upmigrate
echo 62 > /proc/sys/kernel/sched_downmigrate
echo 5 > /proc/sys/kernel/sched_spill_nr_run
echo 100 > /proc/sys/kernel/sched_spill_load
echo 30 > /proc/sys/kernel/sched_init_task_load
echo 10 > /proc/sys/kernel/sched_upmigrate_min_nice
echo 4 > /proc/sys/kernel/sched_ravg_hist_size
echo 7 > /proc/sys/kernel/sched_small_wakee_task_load
echo 110 > /proc/sys/kernel/sched_wakeup_load_threshold
echo 35 > /proc/sys/kernel/sched_big_waker_task_load
echo 950000 > /proc/sys/kernel/sched_rt_runtime_us
echo 1000000 > /proc/sys/kernel/sched_rt_period_us
echo 410000 > /proc/sys/kernel/sched_freq_dec_notify
echo 600000 > /proc/sys/kernel/sched_freq_inc_notify
echo 0 > /proc/sys/kernel/sched_boost
#Tweaks for other various Settings
echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo westwood > /proc/sys/net/ipv4/tcp_congestion_control
chmod 666 /sys/module/snd_soc_wcd9xxx/parameters/impedance_detect_en
echo 1 > /sys/module/snd_soc_wcd9xxx/parameters/impedance_detect_en
chmod 444 /sys/module/snd_soc_wcd9xxx/parameters/impedance_detect_en
chmod 666 /sys/module/snd_soc_wcd9330/parameters/high_perf_mode
echo 1 > /sys/module/snd_soc_wcd9330/parameters/high_perf_mode
chmod 444 /sys/module/snd_soc_wcd9330/parameters/high_perf_mode
chmod 666 /sys/module/snd_soc_wcd9335/parameters/sido_buck_svs_voltage
echo 965 > /sys/module/snd_soc_wcd9335/parameters/sido_buck_svs_voltage
chmod 444 /sys/module/snd_soc_wcd9335/parameters/sido_buck_svs_voltage
echo 'maple' > /sys/block/mmcblk0/queue/scheduler
echo 'maple' > /sys/block/mmcblk1/queue/scheduler
echo '128' > /proc/sys/kernel/random/write_wakeup_threshold
echo '64' > /proc/sys/kernel/random/read_wakeup_threshold
echo '0' > /dev/cpuset/background/cpus
echo '0-2' > /dev/cpuset/system-background/cpus
echo '2-3' > /dev/cpuset/foreground/boost/cpus
echo '0-3' > /dev/cpuset/top-app/cpus
echo '0' > /proc/sys/vm/page-cluster
start vendor.msm_irqbalance
busybox run-parts /system/etc/init.d/

