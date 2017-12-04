#!/vendor/bin/sh
# *********************************************************************
# * Copyright 2016 (C) Sony Mobile Communications Inc.                *
# * All rights, including trade secret rights, reserved.              *
# *********************************************************************
#

# set cpu_boost parameters
echo "80" > /sys/module/cpu_boost/parameters/input_boost_ms
echo 9 > /proc/sys/kernel/sched_upmigrate_min_nice
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
echo cubic > /proc/sys/net/ipv4/tcp_congestion_control
#chmod 666 /sys/module/snd_soc_wcd9xxx/parameters/impedance_detect_en
#echo 1 > /sys/module/snd_soc_wcd9xxx/parameters/impedance_detect_en
#chmod 444 /sys/module/snd_soc_wcd9xxx/parameters/impedance_detect_en
chmod 666 /sys/module/snd_soc_wcd9330/parameters/high_perf_mode
echo 1 > /sys/module/snd_soc_wcd9330/parameters/high_perf_mode
chmod 444 /sys/module/snd_soc_wcd9330/parameters/high_perf_mode
#chmod 666 /sys/module/snd_soc_wcd9335/parameters/sido_buck_svs_voltage
#echo 965 > /sys/module/snd_soc_wcd9335/parameters/sido_buck_svs_voltage
#chmod 444 /sys/module/snd_soc_wcd9335/parameters/sido_buck_svs_voltage
echo 'cfq' > /sys/block/mmcblk0/queue/scheduler
echo 'cfq' > /sys/block/mmcblk1/queue/scheduler
echo '128' > /proc/sys/kernel/random/write_wakeup_threshold
echo '64' > /proc/sys/kernel/random/read_wakeup_threshold
exit 0
