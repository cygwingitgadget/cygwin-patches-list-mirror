Return-Path: <cygwin-patches-return-5271-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19933 invoked by alias); 22 Dec 2004 16:21:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19252 invoked from network); 22 Dec 2004 16:21:22 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 22 Dec 2004 16:21:22 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 0867A1B401; Wed, 22 Dec 2004 11:22:50 -0500 (EST)
Date: Wed, 22 Dec 2004 16:21:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041222162249.GI3748@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041116155640.GA22397@trixie.casa.cgf.cx> <20041120062339.GA31757@trixie.casa.cgf.cx> <3.0.5.32.20041202211311.00820770@incoming.verizon.net> <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net> <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net> <20041205010020.GA20101@trixie.casa.cgf.cx> <20041213202505.GB27768@trixie.casa.cgf.cx> <41BEFBA5.97CA687B@phumblet.no-ip.org> <20041214154214.GE498@trixie.casa.cgf.cx> <41C99D2A.B5C4C418@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C99D2A.B5C4C418@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00272.txt.bz2

On Wed, Dec 22, 2004 at 11:13:30AM -0500, Pierre A. Humblet wrote:
>I tried my spawn(P_DETACH) example (updated since yesterday)
>with the latest snapshot, this time on NT. 
>
>#include <stdio.h>
>#include <unistd.h>
>#include <process.h>
>
>main()
>{
>    spawnl(_P_DETACH, "/c/WINNT/system32/notepad", "notepad", 0);
>    printf("Spawn done\n");
>    /* Keep working */
>    sleep(10);
>    printf("Exiting\n");
>}
>
>New problem is with gcc (gcc version 3.3.3 (cygwin special))
>~/try> uname -a
>CYGWIN_NT-4.0 usched40576 1.5.12(0.116/4/2) 2004-11-10 08:34 i686 unknown unknown Cygwin
>~/try> gcc -o try_spawn try_spawn.c

This is unrelated to the process changes.  Corinna checked in a patch
for this at 11:31 GMT.

cgf
