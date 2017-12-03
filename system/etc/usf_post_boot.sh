#!/system/bin/sh
# Copyright (c) 2011-2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#

dir0=/data/usf
pcm_ind_file=$dir0/pcm_inds.txt
pcm_file=/proc/asound/pcm

tx_rx_patterns=(tx2- rx2-)
dev_ids=("0" "0")
cards=("0" "0")
found_num=0

# Run usf_settings script
if [ -f /system/etc/usf_settings.sh ]; then
  /system/bin/sh /system/etc/usf_settings.sh
fi

while read pcm_entry; do
    for i in 0 1; do
        echo $pcm_entry
        id="${pcm_entry##*"${tx_rx_patterns[$i]}"}"
        case "$pcm_entry" in
            "$id")
            ;;

            *)
            cards[$i]=${pcm_entry:0:2}
            dev_ids[$i]=${pcm_entry:3:2}
            found_num=$(( $found_num + 1))
            i=2
            ;;
        esac

        case $i in
            2)
            break
            ;;
        esac
    done

    case $found_num in
        2)
        break
        ;;
    esac

done < $pcm_file

echo ${dev_ids[0]}" "${dev_ids[1]}" "${cards[0]}" "${cards[1]}>$pcm_ind_file
chmod 0644 $pcm_ind_file

# Post-boot start of selected USF based calculators
for i in $(cat $dir0/auto_start.txt); do
   start $i
done
swapoff /dev/block/zram0 > /dev/null 2>&1
echo '1' > /sys/block/zram0/reset
echo '0' > /sys/block/zram0/disksize
echo '4' > /sys/block/zram0/max_comp_streams
echo '576716800' > /sys/block/zram0/disksize
mkswap /dev/block/zram0 > /dev/null 2>&1
swapon /dev/block/zram0 > /dev/null 2>&1
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
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/align_windows
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/enable_prediction
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/enable_prediction
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
echo 0 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/align_windows
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_migration_notif
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_sched_load
echo 0 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/boostpulse_duration
echo 0 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/io_is_busy
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/interactive/enable_prediction
echo 0 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/enable_prediction
chmod 644 /sys/module/cpu_boost/parameters/input_boost_freq
echo 0:729600 1:0 2:940800 3:0 > /sys/module/cpu_boost/parameters/input_boost_freq
chmod 644 /sys/module/cpu_boost/parameters/input_boost_ms
echo 50 > /sys/module/cpu_boost/parameters/input_boost_ms
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
echo '2048' > /sys/block/mmcblk0/queue/read_ahead_kb
echo '2048' > /sys/block/mmcblk1/queue/read_ahead_kb
busybox run-parts /system/etc/init.d/

