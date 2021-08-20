echo Start boot.scr booting.

if test "${devnum}" = 0 ; then
	setenv media emmc
	setenv boot_device fe310000.sdhci,fe330000.nandc
else
	setenv media sd
	setenv boot_device fe2b0000.dwmmc,fe330000.nandc
fi

setenv pre_args storagemedia=$media androidboot.storagemedia=$media androidboot.mode=normal androidboot.dtb_idx=0 androidboot.dtbo_idx=0

setenv bootargs ${pre_args} androidboot.slot_suffix= androidboot.serialno=${serial#} androidboot.boot_devices=$boot_device androidboot.selinux=permissive

setenv fdt_addr_r 0x0a100000
setenv kernel_addr_c 0x4080000
setenv kernel_addr_r 0x00280000
setenv ramdisk_addr_r 0x0a200000
setenv loadaddr 0x10000000

if bcb load $devnum misc; then
	# valid BCB found
	if bcb test command = bootonce-bootloader; then
		# Bootloader boot
		bcb clear command; bcb store;
		fastboot usb 0
	elif bcb test command = boot-recovery; then
		# Recovery boot
		setenv partnum 8
	else
		# Normal boot
		setenv partnum 7
	fi

	setbootdev $devtype $devnum

	part start $devtype $devnum $partnum boot_start
	part size $devtype $devnum $partnum boot_size

	mmc dev $devnum

	mmc read $loadaddr $boot_start $boot_size

	bootm $loadaddr
else
	echo Media corrupted.
fi
