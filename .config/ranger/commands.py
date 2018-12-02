import pathlib
import subprocess

from ranger.api.commands import Command


class cdmru(Command):

    def execute(self):
        arg = self.rest(1)
        conf = pathlib.Path(self.fm.confpath('mru.txt'))
        wd = self.fm.thistab.thisdir.path
        if not conf.is_file():
            return

        if arg:
            command = f"sh -c 'tail -n +2 {conf} | fzf --preview-window=hidden -1 -0 --query=\"{arg}\"'"
        else:
            command = f"sh -c 'tail -n +2 {conf} | fzf --preview-window=hidden -1 -0'"

        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = pathlib.Path(stdout.strip()).resolve()
            if fzf_file.is_dir():
                self.fm.cd(str(fzf_file))

