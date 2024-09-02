#!/bin/bash

new_host_line="${host_name} ansible_host=${host_ip} ansible_user=${host_user} ansible_ssh_private_key_file=${host_ssh}"

for x in "${ansible_inventory}" "${host_name}"; do
    echo "$x"
    if [ -z "$x" ]; then
        echo "variable is empty"
        exit 1
    fi
done

if [ -e "${ansible_inventory}" ]; then
    echo "File exists"
    case $(grep -cw "${host_name}" "${ansible_inventory}") in
    0)
        # If there are no host in inventory file
        if [ "$1" != destroy ]; then
            echo -e "\n$new_host_line" >>"${ansible_inventory}"
        fi
        ;;
    1)
        # If host already exists in inventory file
        if [ "$1" == "destroy" ]; then
            grep -vw ${host_name} $ansible_inventory > inv.tmp
            mv inv.tmp $ansible_inventory
            sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' $ansible_inventory
        else
            sed -i "s|*${host_name}*|${new_host_line}|g" "${ansible_inventory}"
        fi
        ;;
    *)
        echo "Inventory file contains more than 1 record about $host_name. Please, fix it manually."
        exit 1
        ;;
    esac
else
    echo "File does not exist"
fi
