[No content]
# Exercise 3: Backup Script and Temporary Files

## Overview
This exercise demonstrates a simple backup workflow using a shell script and temporary files.

## Contents

- `backup.sh`: Shell script to create backups of files or directories. It compresses specified files into a zip archive and stores them in the `.backups/` folder.
- `.backups/`: Directory containing backup zip files. Each backup is named with a timestamp for easy identification.
- `tempfiles/`: Directory for temporary files. Example: `file1.txt`.

## Usage

1. **Run the Backup Script**
	- Execute `backup.sh` to create a backup. The script will compress files (such as those in `tempfiles/`) and save the archive in `.backups/`.
	- Example command:
	  ```zsh
	  ./backup.sh
	  ```

2. **View Backups**
	- Check the `.backups/` directory for generated zip files. Each file is named with the date and time of creation.

3. **Temporary Files**
	- Place any files you want to back up in the `tempfiles/` directory or modify the script to include other files.

## Notes

- Ensure you have execute permissions for `backup.sh`:
  ```zsh
  chmod +x backup.sh
  ```
- Modify `backup.sh` as needed to customize which files are backed up.

## Example

To back up `tempfiles/file1.txt`, simply run the script. A new zip file will appear in `.backups/`.
