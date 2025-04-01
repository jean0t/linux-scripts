#!/usr/bin/env python

from pathlib import Path, PosixPath
from typing import List

def get_files(path: PosixPath):
	"""
	Return the files from the directory
	only normal files, directories arent returned
	"""
	return [file for file in path.iterdir() if file.is_file()]


def sort_by_time(files: List[PosixPath]) -> List[PosixPath]:
	"""
	Return the list of PosixPath objects sorted by time
	"""
	return sorted(files, key= lambda file: file.stat().st_mtime)


def order_files(files: List[PosixPath]) -> None:
	"""
	Rename files with numbers to order them
	used together with sort_by_time to order them by time of creation
	"""
	ordering = 1
	for file in files:
		new_name = file.with_stem(str(ordering))
		file.rename(new_name)
		ordering += 1


if __name__ == "__main__":
	dir = Path() # set your Path here
	all_files = get_files(dir)
	all_files_sorted = sort_by_time(all_files)
	order_files(all_files_sorted)
