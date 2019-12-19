# print("poweroff.py in execution")
import os

welcomemsg = "\nSpecify the desired action:\n\n"
shoutdown = "s - shoutdown\n"
reboot = "r - reboot\n"
logout = "e - end user session\n"
lock = "l - lock the screen\n"
quit = "q - quit\n"
yourinp= "\nYour input: "
msg = welcomemsg + shoutdown + reboot + logout + lock + quit + yourinp

def title():
    print("  ____                              __  __                                ")
    print(" |  _ \ _____      _____ _ __ ___  / _|/ _|    _ __ ___   ___ _ __  _   _ ")
    print(" | |_) / _ \ \ /\ / / _ \ '__/ _ \| |_| |_    | '_ \`_ \/  _ \ '_ \| | | |")
    print(" |  __/ (_) \ V  V /  __/ | | (_) |  _|  _|   | | | | | |  __/ | | | |_| |")
    print(" |_|   \___/ \_/\_/ \___|_|  \___/|_| |_|     |_| |_| |_|\___|_| |_|_____|")
    print("                                                           by saulpierotti")


def check_not_running():
    if os.path.exists("poweroff_menu.running"):
        return False
    else:
        open("poweroff_menu.running","w")
        return True


def cmd_s():
    os.system("systemctl poweroff")
    return


def cmd_r():
    os.system("systemctl reboot")
    return


def cmd_e():
    os.system("i3-msg exit")
    return


def cmd_l():
    os.system("xscreensaver-command -lock")
    return

def p_menu():   # create an infinite loop that exits via return
    while True:
        global inp
        inp = input(msg) # ask for user input printing allowed values
        try:    # try statement
            assert (inp == "s") or (inp == "r") or (inp == "l") or (inp =="e") or (inp == "q") # check input
            if inp == "s":  # test different imput values and take actions
                if confirm() == True:
                    cmd_s()
                    return
            elif inp == "r":
                if confirm() == True:
                    cmd_r()
                    return
            elif inp == "e":
                if confirm() == True:
                    cmd_e()
                    return
            elif inp == "l":
                cmd_l()
                return
            elif inp == "q":
                # print("Menu closed")
                return # escape the loop via return
            else:
                print("\nReached p_menu() else statement, this should not happen") # control statement for debugging
                return
        except AssertionError:  # handle non-allowed input
            print("\nNot a valid command")    #  return an error message
            # run the loop again


def confirm():  # customise dialog for user input
    if inp == "s":
        msg = "shutdown the system"
    elif inp == "r":
        msg = "reboot the system"
    elif inp == "e":
        msg = "end user session"
    else:
        print("\nReached confirm() else statement 1, this should not happen") # control statement for debugging
        return False
    conf_inp = input("\nDo you really want to "+ msg +"? (y/n)\nYour input: ") 
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
try:
    not_running = check_not_running()
    if not_running:
        title()
        p_menu()
finally:
    if not_running != False: #removes the running file if this istance created it
        os.remove("poweroff_menu.running")

# print("poweroff.py ended")
