#!/bin/bash

# Auto-detect the Modem Index (0 or 1)
MODEM_INDEX=$(mmcli -L | grep -o 'Modem/[0-9]*' | cut -d'/' -f2 | head -n 1)

if [ -z "$MODEM_INDEX" ]; then
    echo "[-] Error: No active HSPA modem detected. Please check your USB dongle."
    exit 1
fi

# Function to format Algerian numbers (e.g., 07... to +2137...)
format_number() {
    local num=$(echo "$1" | tr -d ' ')
    if [[ "$num" =~ ^0[567] ]]; then
        echo "+213${num:1}"
    else
        echo "$num"
    fi
}

clear
echo "================================================="
echo "   HSPA Modem Interactive Tools (Modem: $MODEM_INDEX)"
echo "================================================="
echo "1) Send an SMS Message"
echo "2) Make a Voice Call"
echo "3) Exit"
echo "================================================="
read -p "Select an option [1-3]: " OPTION

case $OPTION in
    1)
        read -p "Enter phone number (e.g., 07XXXXXXXX): " RAW_NUM
        read -p "Enter your message: " MESSAGE
        
        if [ -z "$RAW_NUM" ] || [ -z "$MESSAGE" ]; then
            echo "[-] Error: Number and message fields cannot be empty."
            exit 1
        fi
        
        TARGET_NUM=$(format_number "$RAW_NUM")
        echo "[+] Creating SMS payload for $TARGET_NUM..."
        
        SMS_PATH=$(sudo mmcli -m "$MODEM_INDEX" --messaging-create-sms="text='$MESSAGE',number='$TARGET_NUM'")
        SMS_ID=$(echo "$SMS_PATH" | grep -o 'SMS/[0-9]*' | cut -d'/' -f2)
        
        if [ -n "$SMS_ID" ]; then
            echo "[+] Dispatching message..."
            sudo mmcli -s "$SMS_ID" --send
            echo "[+] Done!"
        else
            echo "[-] Error: Failed to generate SMS instance."
        fi
        ;;

    2)
        read -p "Enter phone number to call (e.g., 07XXXXXXXX): " RAW_NUM
        if [ -z "$RAW_NUM" ]; then
            echo "[-] Error: Phone number cannot be empty."
            exit 1
        fi
        
        TARGET_NUM=$(format_number "$RAW_NUM")
        echo "[+] Initiating voice channel instance for $TARGET_NUM..."
        
        CALL_PATH=$(sudo mmcli -m "$MODEM_INDEX" --voice-create-call="number='$TARGET_NUM'")
        CALL_ID=$(echo "$CALL_PATH" | grep -o 'Call/[0-9]*' | cut -d'/' -f2)
        
        if [ -n "$CALL_ID" ]; then
            sudo mmcli -o "$CALL_ID" --start
            echo "[+] Call started successfully."
            echo "-------------------------------------------------"
            echo "Press [ENTER] at any time to hang up the line."
            echo "-------------------------------------------------"
            read -p ""
            
            sudo mmcli -o "$CALL_ID" --hangup
            echo "[+] Call disconnected."
        else
            echo "[-] Error: Failed to generate call instance."
        fi
        ;;

    3)
        echo "Exiting."
        exit 0
        ;;

    *)
        echo "[-] Invalid choice."
        exit 1
        ;;
esac
