Return-Path: <cygwin-patches-return-5123-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9209 invoked by alias); 12 Nov 2004 04:47:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9156 invoked from network); 12 Nov 2004 04:47:51 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 12 Nov 2004 04:47:51 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id C30431B3E5; Thu, 11 Nov 2004 23:47:58 -0500 (EST)
Date: Fri, 12 Nov 2004 04:47:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041112044758.GE21129@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111233632.00811470@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041111233632.00811470@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00124.txt.bz2

On Thu, Nov 11, 2004 at 11:36:32PM -0500, Pierre A. Humblet wrote:
>At 11:24 PM 11/11/2004 -0500, Christopher Faylor wrote:
>>On Thu, Nov 11, 2004 at 10:48:57PM -0500, Pierre A. Humblet wrote:
>>>P.S.: I have no news about the recent patch to /bin/kill -f
>>
>>That is because I was sure that I'd used 'kill -f' to kill windows pids
>>in the past and wanted to check your patch.  I haven't been near a
>>WinMe system in a while, though.  My vmware version isn't working
>>currently.
>
>Funny, I had the same feeling. But this is what happens now:
>
>~: ps
>      PID    PPID    PGID     WINPID  TTY  UID    STIME COMMAND
>   606855       1  606855 4294360441  con  740 23:06:35 /c/PROGRAM
>FILES/CYGWIN/BIN/RXVT
>   537691  606855  537691 4294504569    0  740 23:06:36 /c/PROGRAM
>FILES/CYGWIN/BIN/BASH
>   460171  537691  460171 4294214685    0  740 23:24:07 /c/PROGRAM
>FILES/CYGWIN/BIN/PS
>~: /bin/kill -f 4294504569
>couldn't open pid 2147483647
>
>2147483647 = 0x7FFFFFFF, due to strtol saturating.

That's right.  I have seen that from time to time.

>I just researched the ChangeLog and found a possible cause:
>2003-09-20  Christopher Faylor  <cgf@redhat.com>
>
>        * kill.cc (main): Allow negative pids (indicates process groups).

If that is the cause then bypassing that code when -f is specified should
work.

But, nevertheless, go ahead and check in your patch.

Thanks.

cgf
