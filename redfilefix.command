#!/usr/bin/env python3
import os
from tkinter import Tk, filedialog
import glob

def move_files():
  root = Tk()
  root.withdraw()
  dir_path = filedialog.askdirectory(
    initialdir=os.path.dirname(os.path.realpath(__file__))
  )
  if not dir_path:
    return

  target_dir = os.path.join(dir_path, 'Just Vids')
  os.makedirs(target_dir, exist_ok=True)
  print(f"Will transfer .mov files to {target_dir}")

  num_transferred = 0
  num_skipped = 0
  for mov_file_path in glob.iglob(os.path.join(dir_path, '**/*.RDC/*.mov'), recursive=True):
    mov_file_name = os.path.basename(mov_file_path)
    mov_file_target_path = os.path.join(target_dir, mov_file_name)
    if os.path.exists(mov_file_target_path):
      num_skipped += 1
      print(f"{mov_file_target_path} already exists, will not overwrite")
      continue
    os.rename(mov_file_path, mov_file_target_path)
    num_transferred += 1
    print(f"Moved {mov_file_name} to {mov_file_target_path}")

  print(f"\nSummary: {num_transferred} files transferred, {num_skipped} skipped")

if __name__ == "__main__":
  print("\n--------")
  move_files()
  print("--------\n")
