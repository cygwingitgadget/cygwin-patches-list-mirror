Return-Path: <cygwin-patches-return-5270-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11682 invoked by alias); 22 Dec 2004 16:14:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10371 invoked from network); 22 Dec 2004 16:13:33 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 22 Dec 2004 16:13:33 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I94T2I-0000IE-KE
	for cygwin-patches@cygwin.com; Wed, 22 Dec 2004 11:13:30 -0500
Message-ID: <41C99D2A.B5C4C418@phumblet.no-ip.org>
Date: Wed, 22 Dec 2004 16:14:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
References: <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx> <20041120062339.GA31757@trixie.casa.cgf.cx> <3.0.5.32.20041202211311.00820770@incoming.verizon.net> <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net> <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net> <20041205010020.GA20101@trixie.casa.cgf.cx> <20041213202505.GB27768@trixie.casa.cgf.cx> <41BEFBA5.97CA687B@phumblet.no-ip.org> <20041214154214.GE498@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00271.txt.bz2

I tried my spawn(P_DETACH) example (updated since yesterday)
with the latest snapshot, this time on NT. 

#include <stdio.h>
#include <unistd.h>
#include <process.h>

main()
{
    spawnl(_P_DETACH, "/c/WINNT/system32/notepad", "notepad", 0);
    printf("Spawn done\n");
    /* Keep working */
    sleep(10);
    printf("Exiting\n");
}

New problem is with gcc (gcc version 3.3.3 (cygwin special))
~/try> uname -a
CYGWIN_NT-4.0 usched40576 1.5.12(0.116/4/2) 2004-11-10 08:34 i686 unknown unknown Cygwin
~/try> gcc -o try_spawn try_spawn.c
~/try> 

~/try> uname -a
CYGWIN_NT-4.0 usched40576 1.5.13s(0.117/4/2) 20041221 16:19:37 i686 unknown unknown Cygwin
~/try> gcc -o xxx try_spawn.c
In file included from /usr/include/stdio.h:45,
                 from try_spawn.c:1:
/usr/include/sys/reent.h:810: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://gcc.gnu.org/bugs.html> for instructions.


When running try_spawn with the snapshot, during the sleep period
ps reports  

      690     443     690        232    0 11054 10:32:21 <defunct>
      464     690     690        464    0 11054 10:32:21 /c/WINNT/system32/notepad

Similarly when running try_spawn in the background,
bash reports "Done" before the job has terminated:
 
~/try> ./try_spawn.exe &
[1] 740
~/try> Spawn done

[1]+  Done                    ./try_spawn.exe
~/try> Exiting
