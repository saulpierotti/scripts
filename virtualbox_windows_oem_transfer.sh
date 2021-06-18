#!/bin/bash
# Takes the Windows OEM license of the host and transfers it to the VM
acpi_dest_file="$(eval echo ~"${SUDO_USER}")/Virtualbox VMs/win_oem_acpi_table"
host_acpt_table="/sys/firmware/acpi/tables/MSDM"
echo "This scripts transfers the OEM license from the host to a VirtualBox guest"
echo "This is the host acpi table:"
sudo cat "$host_acpt_table" | tee "$acpi_dest_file"
echo
echo "These are the guests available on the PC:"
VBoxManage list vms
echo "Write the name of the guest that should receive the OEM license:"
read -r vm_name
echo "Setting acpi table to machine: $vm_name"
VBoxManage setextradata "$vm_name" \
    "VBoxInternal/Devices/acpi/0/Config/CustomTable" \
    "$acpi_dest_file"
echo "Process completed. $vm_name acpi table set to:"
cat "$(VBoxManage getextradata "$vm_name" |
    grep "VBoxInternal/Devices/acpi/0/Config/CustomTable" |
    cut -d, -f2 | cut -d: -f2 | xargs)"
exit 0
