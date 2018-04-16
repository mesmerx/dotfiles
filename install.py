import os
import curses
from curses import panel
from sys import executable
from subprocess import Popen, PIPE

class Menu(object):

    def __init__(self, items, stdscreen):
        self.window = stdscreen.subwin(0,0)
        self.window.keypad(1)
        self.panel = panel.new_panel(self.window)
        self.panel.hide()
        panel.update_panels()

        self.position = 0
        self.items = items
        self.items.append(('exit','exit'))

    def navigate(self, n):
       self.position += n
       if self.position < 0:
           self.position = 0
       elif self.position >= len(self.items):
           self.position = len(self.items)-1

    def display(self):
        self.panel.top()
        self.panel.show()
        self.window.clear()

        while True:
            self.window.refresh()
            curses.doupdate()
            for index, item in enumerate(self.items):
                if index == self.position:
                    mode = curses.A_REVERSE
                else:
                    mode = curses.A_NORMAL

                msg = '%d. %s' % (index, item[0])
                self.window.addstr(1+index, 1, msg, mode)

            key = self.window.getch()

            if key in [curses.KEY_ENTER, ord('\n')]:
                if self.position == len(self.items)-1:
                    break
                else:
                    self.items[self.position][1]()

            elif key == curses.KEY_UP:
                self.navigate(-1)

            elif key == curses.KEY_DOWN:
                self.navigate(1)

        self.window.clear()
        self.panel.hide()
        panel.update_panels()
        curses.doupdate()

class MyApp(object):

    def __init__(self, stdscreen):
        self.screen = stdscreen
        curses.curs_set(0)

        pre_items = [
            ('oh-my-zsh-powerline-theme', self.omzp),
            ('oh-my-zsh', self.omz),
            ('zsh-history-substring-search', self.zh),
            ('command-not-found', self.cnf),
            ('vim', self.vim),
            ('vim-runtime', self.vimr),
            ('vundle', self.vund),
            ('zsh', self.zsh),
            ('sway', self.sway),
            ('qtile', self.qtile),
            ('i3', self.i3),
            ('xmonad', self.xmo),
            ('xorg', self.xor),
         ]
        
        
        pre = Menu(pre_items, self.screen)

        conf_items = [
            ('vim', self.vimc),
            ('zsh', self.zshc),
            ('sway', self.swayc),
            ('qtile', self.qtilec),
            ('i3', self.i3c),
            ('xmonad', self.xmoc),
            ('xorg', self.xorc),

        ]
        conf = Menu(conf_items, self.screen)


        main_menu_items = [
            ('selet pre requisites', pre.display),
            ('select configurations', conf.display),
            ('install all', self.all),
        ]
        main_menu = Menu(main_menu_items, self.screen)
        main_menu.display()

    def all(self):
            
            lista=[
            ('oh-my-zsh-powerline-theme', self.omzp),
            ('oh-my-zsh', self.omz),
            ('zsh-history-substring-search', self.zh),
            ('command-not-found', self.cnf),
            ('vim', self.vim),
            ('vim-runtime', self.vimr),
            ('vundle', self.vund),
            ('zsh', self.zsh),
            ('sway', self.sway),
            ('qtile', self.qtile),
            ('i3', self.i3),
            ('xmonad', self.xmo),
            ('xorg', self.xor),
            ('vim', self.vimc),
            ('zsh', self.zshc),
            ('sway', self.swayc),
            ('qtile', self.qtilec),
            ('i3', self.i3c),
            ('xmonad', self.xmoc),
            ('xorg', self.xorc)
            ]

            [ a[1] for a in lista]


    def omz(self):
        os.system("gnome-terminal -e 'pacaur -Sy oh-my-zsh-git' &> /dev/null")
    def omzp(self):
        os.system("gnome-terminal -e 'pacaur -Sy oh-my-zsh-powerline-theme-git' &> /dev/null")
    def zh(self):
        os.system("gnome-terminal -e 'pacaur -Sy zsh-history-substring-search' &> /dev/null")
    def cnf(self):
        os.system("gnome-terminal -e 'pacaur -Sy command-not-found' &> /dev/null")
    def vimr(self):
        os.system("gnome-terminal -e 'pacaur -Sy vim-runtime' &> /dev/null")
    def vim(self):
        os.system("gnome-terminal -e 'pacaur -Sy vim' &> /dev/null")
    def vund(self):
        os.system("gnome-terminal -e 'pacaur -Sy vundle-git' &> /dev/null")
    def zsh(self):
        os.system("gnome-terminal -e 'pacaur -Sy zsh' &> /dev/null")
    def sway(self):
        os.system("gnome-terminal -e 'pacaur -Sy sway' &> /dev/null")
    def qtile(self):
        os.system("gnome-terminal -e 'pacaur -Sy qtile' &> /dev/null")
    def i3(self):
        os.system("gnome-terminal -e 'pacaur -Sy i3' &> /dev/null")
    def xmo(self):
        os.system("gnome-terminal -e 'pacaur -Sy xmonad' &> /dev/null")
    def xor(self):
        os.system("gnome-terminal -e 'pacaur -Sy xorg xorg-xinit' &> /dev/null")
    def xorc(self):
        os.system("gnome-terminal -e 'cp xorg/.* ~/ -Rv' &> /dev/null")
    def zshc(self):
        os.system("gnome-terminal -e 'cp zsh/.* ~/ -Rv' &> /dev/null")
    def swayc(self):
        os.system("gnome-terminal -e 'cp sway/.* ~/ -Rvi' &> /dev/null")
    def qtilec(self):
        os.system("gnome-terminal -e 'cp qtile/.* ~/ -Rvi' ' &> /dev/null")
    def i3c(self):
        os.system("gnome-terminal -e 'cp i3/.* ~/ -Rvi' ' &> /dev/null")
    def vimc(self):
        os.system("gnome-terminal -e 'cp vim/.* ~/ -Rvi' ' &> /dev/null")
    def xmoc(self):
        os.system("gnome-terminal -e 'cp xmonad/.* ~/ -Rvi' ' &> /dev/null")

if __name__ == '__main__':
    curses.wrapper(MyApp)
