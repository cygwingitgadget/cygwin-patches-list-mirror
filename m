Return-Path: <cygwin-patches-return-1971-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15457 invoked by alias); 11 Mar 2002 15:48:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15421 invoked from network); 11 Mar 2002 15:48:09 -0000
Message-ID: <20020311154807.71749.qmail@web20001.mail.yahoo.com>
Date: Mon, 11 Mar 2002 07:57:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: big kill patch (adds list/help/version)
To: cygwin-patches@cygwin.com
In-Reply-To: <20020311151227.GA15831@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00328.txt.bz2


--- Christopher Faylor <cgf@redhat.com> wrote:
> >> How does the linux kill program handle this?
> >RedHat's prints a list like
> > 1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL
> > 5) SIGTRAP      6) SIGABRT      7) SIGBUS       8) SIGFPE
> >...
> >Looks hard-coded to me, but I didn't look at the sources. I'll hard-code 
> >the list in the print_list () function.
> 
> You're looking at the bash built-in.  /bin/kill just does this:
> 
> HUP INT QUIT ILL ABRT FPE KILL SEGV PIPE ALRM TERM USR1 USR2 CHLD CONT
> STOP TSTP TTIN TTOU TRAP IOT BUS SYS STKFLT URG IO POLL CLD XCPU XFSZ
> VTALRM PROF PWR WINCH UNUSED
> 
Indeed. Now, am I correct in thinking that I cannot look at the util-linux
sources to see how it works?

__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
