import pathlib
import ranger.api


HOOK_READY_OLD = ranger.api.hook_ready
MRU_SIZE = 25


def hook_ready(fm):

    def cdmru_add():
        visit = pathlib.Path(fm.thistab.thisdir.path)
        conf = pathlib.Path(fm.confpath('mru.txt'))
        mru = []
        if conf.is_file():
            with conf.open(mode="r") as f:
                mru = [pathlib.Path(directory.strip()) for directory in f.readlines()]
        mru = [directory for directory in mru if directory.is_dir()][:MRU_SIZE]

        try:
            visitIndex = mru.index(visit)
        except ValueError:
            visitIndex = None

        if visitIndex is None:
            mru.insert(0, visit)
        else:
            mru.insert(0, mru.pop(visitIndex))

        with conf.open(mode="w") as f:
            for directory in mru:
                f.write(str(directory))
                f.write("\n")

    cdmru_add()
    fm.signal_bind('cd', cdmru_add)
    return HOOK_READY_OLD(fm)


ranger.api.hook_ready = hook_ready
