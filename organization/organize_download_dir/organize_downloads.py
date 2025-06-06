#!/usr/bin/env python

from pathlib import Path
from datetime import datetime

TIMENOW = datetime.now().strftime("%d/%m %H:%M")


def message(filename, target_dir):
    print(f"{TIMENOW} {filename} was moved to {target_dir}")


def make_dir(path_obj):
    path_obj.mkdir(parents=True, exist_ok=True)


home = Path.home()
downloads = home.joinpath("Downloads")

for archive in downloads.iterdir():
    if archive.is_file():
        extension = archive.suffix
        if extension == ".part":
            continue

        match extension:
            case ".pdf" | ".txt" | ".md":
                target_dir = downloads / "texts"
                make_dir(target_dir)
                archive.rename(target_dir / archive.name)
                message(archive.name, target_dir)

            case ".deb" | ".appimage" | "":
                target_dir = downloads / "binaries"
                make_dir(target_dir)
                archive.rename(target_dir / archive.name)
                message(archive.name, target_dir)

            case ".mp4" | ".wav" | ".mkv":
                target_dir = downloads / "videos"
                make_dir(target_dir)
                archive.rename(target_dir / archive.name)
                message(archive.name, target_dir)

            case ".mp3":
                target_dir = downloads / "audio"
                make_dir(target_dir)
                archive.rename(target_dir / archive.name)
                message(archive.name, target_dir)

            case ".jpeg" | ".jpg" | ".png" | ".gif":
                target_dir = downloads / "images"
                make_dir(target_dir)
                archive.rename(target_dir / archive.name)
                message(archive.name, target_dir)

            case _:
                target_dir = downloads / "special"
                make_dir(target_dir)
                archive.rename(target_dir / archive.name)
                message(archive.name, target_dir)

    else:
        continue
