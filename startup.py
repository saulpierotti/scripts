#!/usr/bin/python

import os

welcomemsg = "\nSpecify the desired action:\n\n"
startx = "x - start the graphic environment\n"
startxgnome = "xg - start the graphic environment with gnome\n"
shutdown = "s - shutdown\n"
reboot = "r - reboot\n"
yourinp = "\nYour input: "
msg = welcomemsg + startx + startxgnome + shutdown + reboot + yourinp


def title():
    print("   _____ _             _ ")
    print("  / ____| |           | |")
    print(" | (___ | |_ __ _ _ __| |_ _   _ _ __    _ __ ___   ___ _ __  _   _")
    print("  \___ \| __/ _` | '__| __| | | | '_ \  | '_ ` _ \ / _ \ '_ \| | | |")
    print("  ____) | || (_| | |  | |_| |_| | |_) | | | | | | |  __/ | | | |_| |")
    print(" |_____/ \__\__,_|_|   \__|\__,_| .__/  |_| |_| |_|\___|_| |_|\__,_|")
    print("                                | |                  by saulpierotti")
    print("                                |_|")


def cmd_s():
    #    reset()
    os.system("systemctl poweroff")
    return


def cmd_r():
    #    reset()
    os.system("systemctl reboot")
    return


def cmd_x():
    #    reset()
    os.system("startx")
    return


def cmd_xg():
    #    reset()
    os.system('export WM="gnome-session";startx')
    return


def p_menu():  # create an infinite loop that exits via return
    while True:
        global inp
        inp = input(msg)  # ask for user input printing allowed values
        try:  # try statement
            assert (
                (inp == "x") or (inp == "xg") or (inp == "r") or (inp == "s")
            )  # check input
            if inp == "x":  # test different input values and take actions
                cmd_x()
                return
            if inp == "xg":  # test different input values and take actions
                cmd_xg()
                return
            elif inp == "r":
                if confirm() == True:
                    cmd_r()
                    return
            elif inp == "s":
                if confirm() == True:
                    cmd_s()
                    return
            else:
                print(
                    "\nReached p_menu() else statement, this should not happen"
                )  # control statement for debugging
                return
        except AssertionError:  # handle non-allowed input
            print("\nNot a valid command")  #  return an error message
            # run the loop again


def confirm():  # customise dialog for user input
    if inp == "s":
        msg = "shutdown the system"
    elif inp == "r":
        msg = "reboot the system"
    elif inp == "x":
        msg = "starting the graphic environment"
    elif inp == "xg":
        msg = "starting the graphic environment with gnome"
    else:
        print(
            "\nReached confirm() else statement 1, this should not happen"
        )  # control statement for debugging
        return False
    conf_inp = input("\nDo you really want to " + msg + "? (y/n)\nYour input: ")
    assert conf_inp == "y" or conf_inp == "n"
    if conf_inp == "y":
        print("\nOperation confirmed")
        return True
    elif conf_inp == "n":
        print("\nOperation aborted by the user")
        return False
    else:
        print("\nReached confirm() else statement 2, this should not happen")
        return False


title()
p_menu()
