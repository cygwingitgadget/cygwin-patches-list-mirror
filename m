From: "Jason Gouger" <cygwin@jason-gouger.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH] fixes incorrect exit status to windows process
Date: Thu, 08 Mar 2001 22:49:00 -0000
Message-id: <001101c0a865$ce21f8b0$250ddb18@fision>
References: <001101c0a52c$6f506e20$250ddb18@fision> <20010304235848.D8103@redhat.com>
X-SW-Source: 2001-q1/msg00160.html

Here's another patch which fixes the problem in spawn_guts...

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Sunday, March 04, 2001 8:58 PM
Subject: Re: [PATCH] fixes incorrect exit status to windows process


> It looks like you're on the right track, but I think it would
> make sense to put this in spawn_guts somewhere where EXIT_REPARENTING
> is being set.  Possibly you can avoid setting the EXIT_REPARENTING
> bit entirely when !myself->ppid_handle (this is the best way to
> find out if a cygwin application has been invoked from a non-cygwin
> application).
>
> Thanks for tracking down what is going on.
>
> cgf
>
> On Sun, Mar 04, 2001 at 08:26:22PM -0800, Jason Gouger wrote:
> >Patch to fix the problem described below...
> >
> >-----Original Message-----
> >From: Jason Gouger [ mailto:cygwin@jason-gouger.com ]
> >Sent: Tuesday, February 27, 2001 11:18 PM
> >To: cygwin-developers@cygwin.com
> >Subject: incorrect exit status from cygwin exec to windows process
> >
> >There appears to be some error when a cygwin process exec's another
cygwin
> >process, and returns the exit status to a windows process. The windows
> >process receives a return code of '131072'.
> >
> >To reproduce the error, try the following:
> >1. Compile the "x.c" program below with a windows compiler, e.g. MSVC or
> >similar.
> >cl x.c
> >#include <stdio.h>
> >#include <process.h>
> >int main(int argc, char **argv) {
> >   const char *cmdline = argv[1];
> >   int ret_code;
> >   printf("COMMAND LINE: (%s)\n", cmdline);
> >   fflush(stdout); fflush(stderr);
> >   ret_code = system(cmdline);
> >   fflush(stdout); fflush(stderr);
> >   printf("RETURN CODE: %d\n", ret_code);
> >   fflush(stdout); fflush(stderr);
> >   exit(ret_code);
> >}
> >
> >2. From a cygwin shell (bash), type the following command:
> >   ./x.exe 'C:\cygwin\bin\bash -c /bin/date'
> >   Results:
> >      COMMAND LINE: (C:\cygwin\bin\bash.exe -c /bin/date)
> >      Tue Feb 27 22:55:39 2001
> >      RETURN CODE: 131072
> >
> >3. Create a script, e.g.
> >   echo /bin/date > x.sh
> >   Run the command:
> >      ./x.exe 'C:\cygwin\bin\bash x.sh'
> >   Results:
> >      COMMAND LINE: (C:\cygwin\bin\bash.exe x.sh)
> >      Tue Feb 27 22:58:34 2001
> >      RETURN CODE: 0
> >4. Change the script to have an exec, e.g.
> >   echo exec /bin/date > x.sh
> >   Run the command:
> >      ./x.exe 'C:\cygwin\bin\bash x.sh'
> >   Results:
> >      COMMAND LINE: (C:\cygwin\bin\bash.exe x.sh)
> >      Tue Feb 27 22:59:47 2001
> >      RETURN CODE: 131072
> >
>
> >2001-03-04  Jason Gouger  <cygwin@jason-gouger.com>
> > * pinfo.cc (_pinfo::exit): Clear EXIT_REPARENTING if there is no parent
process.
>
> >Index: pinfo.cc
> >===================================================================
> >RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
> >retrieving revision 1.41
> >diff -u -r1.41 pinfo.cc
> >--- pinfo.cc 2001/01/30 08:10:04 1.41
> >+++ pinfo.cc 2001/03/05 04:10:16
> >@@ -126,6 +126,12 @@
> >   fill_rusage (&r, hMainProc);
> >   add_rusage (&rusage_self, &r);
> >
> >+  if (ppid == 1 && n & EXIT_REPARENTING)
> >+    {
> >+      sigproc_printf ("Clearing EXIT_REPARENTING on res, ppid == 1\n");
> >+      n &= ~EXIT_REPARENTING;
> >+    }
> >+
> >   sigproc_printf ("Calling ExitProcess %d", n);
> >   ExitProcess (n);
> > }
>
>
> --
> cgf@cygnus.com                        Red Hat, Inc.
> http://sources.redhat.com/            http://www.redhat.com/
>
