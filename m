Return-Path: <cygwin-patches-return-2133-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26662 invoked by alias); 2 May 2002 02:13:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26647 invoked from network); 2 May 2002 02:13:08 -0000
Message-Id: <3.0.5.32.20020501221106.007ff100@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 01 May 2002 19:13:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Linger on close hack (was Re: SSH -R problem)
In-Reply-To: <3.0.5.32.20020430215517.007f13e0@mail.attbi.com>
References: <3CCEA638.E357EFE2@ieee.org>
 <3.0.5.32.20020429205809.007f2920@mail.attbi.com>
 <3.0.5.32.20020429205809.007f2920@mail.attbi.com>
 <3.0.5.32.20020430073223.007e3e00@mail.attbi.com>
 <20020430142039.D1214@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00117.txt.bz2

At 10:12 AM 4/30/2002 -0400, Pierre A. Humblet wrote:
>Now I have never observed this myself, and don't have a strong opinion.
>Do we have a reproducible case to understand exactly what's going on?

This time I looked on NT at the example provided by Jonathan Kamens
http://cygwin.com/ml/cygwin/2001-07/msg00758.html

It quickly became evident that there was a race between parent and child.
The following conclusions were obtained by adding sleep()'s. They hold
for the current Cygwin dll and a special version without the linger hack.

A) The read() returns "Connection reset by peer" if and only if:
A1) The parent close() its (useless) copy of writefd before the child exit()
and
A2) The parent read() after the child has exited

B) If a read() is added to the parent (should return on EOF), it returns
"Connection reset by peer" when the child exits, not when it closes
the socket. It returns 0 if the example is modified and the parent closes 
its copy of writefd after the child exits. 

Things are fine if the child shutdown(), as recommended by MS.

So NT exhibits a variant of the CLOSE_WAIT bug seen on Win98/ME, where
closing a duplicated socket misbehaves when the original socket (in the
parent) is closed before the child exits. I see three differences 
1) NT releases the system buffers.
2) The read() in B above returns. On Win98 it hangs.
3) On Win98, the read() in A returns correctly. It is possible
   that Microsoft introduced a bug in NT when fixing buffer release. 

It is likely that the fix proposed by Corinna and Chris for the CLOSE_WAIT
bug on Win98 will also fix this one,
http://cygwin.com/ml/cygwin-patches/2002-q2/msg00051.html

Don't trust me, please try to duplicate. Also I have only looked at 
Jonathan's example, the full story may be more complicated. 

The bug occurs even if the child sleeps for 5 minutes between
close() and exit(), as long as the parent sleeps as much before read().
So, why does the linger hack help? 
In the example, it simply delays the child so that A2) above does not hold. 
This is demonstrated below in the output from Jonathan's program with 
a few more printf() and times in microseconds.
In addition the same conclusions can be observed by adding waitpid().

Pierre

/* Modified dll without linger hack
   Times in microseconds. */
CHILD: close(readfd) 140105
CHILD: writing 143825
CHILD: closing 144123     <==
CHILD: closed 144374      <== close() is fast
CHILD: exiting 144432
PARENT: close(writefd) 148872
PARENT: selecting 157151
PARENT: read is set 185121
PARENT: reading 185228
PARENT: read: Connection reset by peer

/* Official Cygwin dll, including linger hack */
CHILD: close(readfd) 185213
CHILD: writing 186010
CHILD: closing 186290          <=== close is slow
PARENT: close(writefd) 186481  <= Parent can do some work
CHILD: closed 514437           <=== DELAY
CHILD: exiting 514534
PARENT: selecting 519690
PARENT: read is set 529642
PARENT: reading 529738         <== occurs before NT cleanup of child ?
PARENT: foo (exiting)          

I know, the above doesn't look conclusive. It depends on 
the timing of the child process cleanup that NT is doing.
Adding waitpid() makes every clearer.
 
/* Official dll, waitpid() before parent close() the useless socket */
  if (waitpid(pid, 0, 0) != pid) perror("PARENT: waitpid");  <== NEW
  fprintf(stderr, "PARENT: close(writefd) %ld\n", gettime());
  close(writefd);

CHILD: close(readfd) 185707
CHILD: writing 186497
CHILD: closing 186776
CHILD: closed 514492
CHILD: exiting 514599
PARENT: close(writefd) 607297
PARENT: selecting 607829
PARENT: read is set 611156
PARENT: reading 611249
PARENT: foo (exiting)

/* Official dll, waitpid after parent close */
  fprintf(stderr, "PARENT: close(writefd) %ld\n", gettime());
  close(writefd);
  if (waitpid(pid, 0, 0) != pid) perror("PARENT: waitpid");  <== NEW

CHILD: close(readfd) 181640
CHILD: writing 182365
CHILD: closing 182639       <===
PARENT: close(writefd) 183814
CHILD: closed 511020        <=== DELAY as with linger hack
CHILD: exiting 511115
PARENT: selecting 596840
PARENT: read is set 600175
PARENT: reading 600348
PARENT: read: Connection reset by peer    <== BUT ...

