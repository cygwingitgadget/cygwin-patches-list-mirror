Return-Path: <cygwin-patches-return-1972-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1606 invoked by alias); 11 Mar 2002 15:57:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1519 invoked from network); 11 Mar 2002 15:57:26 -0000
Date: Mon, 11 Mar 2002 10:04:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: big kill patch (adds list/help/version)
Message-ID: <20020311155731.GB16030@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020311151227.GA15831@redhat.com> <20020311154807.71749.qmail@web20001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311154807.71749.qmail@web20001.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00329.txt.bz2

On Mon, Mar 11, 2002 at 07:48:07AM -0800, Joshua Daniel Franklin wrote:
>
>--- Christopher Faylor <cgf@redhat.com> wrote:
>> >> How does the linux kill program handle this?
>> >RedHat's prints a list like
>> > 1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL
>> > 5) SIGTRAP      6) SIGABRT      7) SIGBUS       8) SIGFPE
>> >...
>> >Looks hard-coded to me, but I didn't look at the sources. I'll hard-code 
>> >the list in the print_list () function.
>> 
>> You're looking at the bash built-in.  /bin/kill just does this:
>> 
>> HUP INT QUIT ILL ABRT FPE KILL SEGV PIPE ALRM TERM USR1 USR2 CHLD CONT
>> STOP TSTP TTIN TTOU TRAP IOT BUS SYS STKFLT URG IO POLL CLD XCPU XFSZ
>> VTALRM PROF PWR WINCH UNUSED
>> 
>Indeed. Now, am I correct in thinking that I cannot look at the util-linux
>sources to see how it works?

I don't see any reason why not.  Just don't copy code wholesale from the
sources.  But you knew that...

cgf
