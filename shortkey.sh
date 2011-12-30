#!/bin/bash

echo "
DEVICE=\$T/device/*/\$(get_build_var TARGET_DEVICE)
HARDWARE=\$T/hardware/libhardware
HARDWARE_LEGACY=\$T/hardware/libhardware_legacy

function chw()
{
    cd \$HARDWARE
}

function cdevice()
{
    cd \$DEVICE
}

function chwl()
{
    cd \$HARDWARE_LEGACY
}

function cout()
{
    cd \$OUT
}
" >> device/softwinner/crane-common/vendorsetup.sh
