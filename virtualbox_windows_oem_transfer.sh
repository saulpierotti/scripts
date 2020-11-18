#!/bin/bash
# Takes the Windows OEM license of the host and transfers it to the VM

echo "Setting acpi table to machine: $1"
sudo cat /sys/firmware/acpi/tables/MSDM /sys/firmware/acpi/tables/SLIC > ~/custom_acpi
VBoxManage setextradata $1 "VBoxInternal/Devices/acpi/0/Config/CustomTable" ~/custom_acpi
