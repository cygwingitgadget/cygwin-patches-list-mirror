From: "Jason Gouger" <cygwin@jason-gouger.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH] fixes incorrect exit status to windows process
Date: Sun, 04 Mar 2001 20:21:00 -0000
Message-id: <001101c0a52c$6f506e20$250ddb18@fision>
X-SW-Source: 2001-q1/msg00145.html

Patch to fix the problem described below...

-----Original Message-----
From: Jason Gouger [ mailto:cygwin@jason-gouger.com ]
Sent: Tuesday, February 27, 2001 11:18 PM
To: cygwin-developers@cygwin.com
Subject: incorrect exit status from cygwin exec to windows process

There appears to be some error when a cygwin process exec's another cygwin
process, and returns the exit status to a windows process. The windows
process receives a return code of '131072'.

To reproduce the error, try the following:
1. Compile the "x.c" program below with a windows compiler, e.g. MSVC or
similar.
cl x.c
#include <stdio.h>
#include <process.h>
int main(int argc, char **argv) {
   const char *cmdline = argv[1];
   int ret_code;
   printf("COMMAND LINE: (%s)\n", cmdline);
   fflush(stdout); fflush(stderr);
   ret_code = system(cmdline);
   fflush(stdout); fflush(stderr);
   printf("RETURN CODE: %d\n", ret_code);
   fflush(stdout); fflush(stderr);
   exit(ret_code);
}

2. From a cygwin shell (bash), type the following command:
   ./x.exe 'C:\cygwin\bin\bash -c /bin/date'
   Results:
      COMMAND LINE: (C:\cygwin\bin\bash.exe -c /bin/date)
      Tue Feb 27 22:55:39 2001
      RETURN CODE: 131072

3. Create a script, e.g.
   echo /bin/date > x.sh
   Run the command:
      ./x.exe 'C:\cygwin\bin\bash x.sh'
   Results:
      COMMAND LINE: (C:\cygwin\bin\bash.exe x.sh)
      Tue Feb 27 22:58:34 2001
      RETURN CODE: 0
4. Change the script to have an exec, e.g.
   echo exec /bin/date > x.sh
   Run the command:
      ./x.exe 'C:\cygwin\bin\bash x.sh'
   Results:
      COMMAND LINE: (C:\cygwin\bin\bash.exe x.sh)
      Tue Feb 27 22:59:47 2001
      RETURN CODE: 131072
