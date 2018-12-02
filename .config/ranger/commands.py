import os
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
            query = '--query="{arg}"'
        else:
            query = ''

        if 'TMUX_PANE' in os.environ:
            fzf_cmd = 'fzf-tmux'
        else:
            fzf_cmd = 'fzf'

        command = f"tail -n +2 {conf} | {fzf_cmd} --preview-window=hidden -1 -0 {query}"
        command = command.strip()

        proc = subprocess.run(['sh', '-c', command], stdout=subprocess.PIPE, encoding='utf-8')

        fzf_file = pathlib.Path(proc.stdout.strip()).resolve()
        if fzf_file.is_dir():
            self.fm.cd(str(fzf_file))

