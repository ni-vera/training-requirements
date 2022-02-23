Q1: What is your home directory?

A: /home/ubuntu

Q2: What is the output of this command?

A:hello_world.txt

Q3: What is the output of each ls command?

A:1st ls command: empty output.
2nd ls command: hello_world.txt.

A: Q4: What is the output of each?
1st ls command: empty output.
2nd ls command: empty output.
3rd ls command: hello_world.txt

Q5: What editor did you use and what was the command to save your file changes?

A: I used Nano and I didn't use the specific saving command, since if you have unsaved changes, using the exit command (Ctrl X) prompts you to decide whether you want to save changes.

Q6: What is the error?

A: Permission denied (publickey)

Q7: What was the solution?

A: The reason for the error is that the new user was not configured for remote SSH access. The solution was to configure a new remote access key pair for the new user.

Q8: what does the sudo docker run part of the command do? and what does the salmon swim part of the command do?

A: "sudo" makes whatever command it's followed by to run with superuser permissions. The command "run" of docker creates and starts a new container following the specified image (salmon) by running the command it is followed by (swim). The swim command opens a sort of "About" page.

Q9: What is the output of this command?

A: "serveruser is not in the sudoers file.  This incident will be reported." as we are trying to act with superuser privileges with a user which is absent from the sudo grup.

Q10: What is the output of flask --version

A: Python 3.9.7
   Flask 1.1.2
   Werkzeug 1.0.1

Q11: What is the output of mamba -V?

A: conda 4.11.0

Q12: What is the output of which python?

A: /home/serveruser/miniconda3/envs/py27/bin/python

Q13: What is the output of which python now?

A: /home/serveruser/miniconda3/bin/python

Q14: What is the output of salmon -h?

A: The output is the help sheet of salmon.

Q15: What does the -o athal.fa.gz part of the command do?

A: "-o" indicates that output should be saved into a file as opposed of being echoed into the shell, followed by the name of that output file.

Q16: What is a .gz file?

A: A .gz file is the format of the files compressed used gzip. Despite its name's similarity to ZIP files, they are not even conceptually the same, as ZIP files are both compressed and archived while .gz files are just compressed.

Q17: What does the zcat command do?

A: Zcat is the equivalent of "cat" for compressed files, and as such it shows their content without need for prior decompression.

Q18: What does the head command do?

A: It shows the first lines of a file.

Q19: What does the number 100 signify in the command?

A: The number 100 indicates the number of lines to be shown (counting from the beginning) by the head command.

Q20: What is | doing? -- Hint using | in Linux is called "piping"

A: "|" makes the output of the command that precedes it the input of the command that succedes it, thus allowing us to apply a sequence of commands at once and  avoid dealing with intermediate output files.

Q21: What is a .fa file? What is this file format used for?

A: A .fa or FASTA is a file format containing nucleotidic or aminoacidic sequences. It is used for storing reads or otherwise representing genetic sequences or their proteic translations.

Q22: What format are the downloaded sequencing reads in?

A: The reads are in the .sra format.

Q23: What is the total size of the disk?

A: 7.7Gb.

Q24: How much space is remaining on the disk?

A: 5.5Gb.

Q25: What went wrong?
A: There was not enough free space to store the output of fastq-dump.

Q26: What was your solution?

My solution was to use the --gzip modifier, which compresses the output.
