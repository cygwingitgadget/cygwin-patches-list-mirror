Return-Path: <cygwin-patches-return-5185-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19805 invoked by alias); 5 Dec 2004 00:59:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19794 invoked from network); 5 Dec 2004 00:59:51 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 5 Dec 2004 00:59:51 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 27EDD1B491; Sat,  4 Dec 2004 20:00:20 -0500 (EST)
Date: Sun, 05 Dec 2004 00:59:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041205010020.GA20101@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx> <20041120062339.GA31757@trixie.casa.cgf.cx> <3.0.5.32.20041202211311.00820770@incoming.verizon.net> <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net> <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00186.txt.bz2

On Sat, Dec 04, 2004 at 01:01:11PM -0500, Pierre A. Humblet wrote:
>At 12:33 PM 12/4/2004 -0500, Christopher Faylor wrote:
>>On Sat, Dec 04, 2004 at 11:45:28AM -0500, Pierre A. Humblet wrote:
>>>At 12:43 AM 12/4/2004 -0500, Christopher Faylor wrote:
>>>>I wrote a simple test case to check this and I don't see it -- on XP.  I
>>>>can't easily run Me anymore.  Does the attached program demonstrate this
>>>>behavior when you run it?  It should re-exec itself every time you hit
>>>>CTRL-C.
>>>
>>>That test case has no problem, but the attached one does. 
>>>Use kill -30 pid
>>
>>Sigh.  Works fine on XP, AFAICT.
>
>More details
>CYGWIN_ME-4.90 hpn5170 1.5.13s(0.116/4/2) 20041125 23:34:52 i686 unknown
>unknown Cygwin
>
>I added a printf at the top, showing the current pid and ppid
>(attached)
>
>~: ./a
>pid 556021 ppid 890585
>~: ps | fgrep /A
>  36793321       1  556021 4258173975    0  740 12:47:22 /c/HOME/PIERRE/A
>~: kill -30 36793321
>got signal 30
>execing myself
>~: pid 36793321 ppid 36793321
>~: ps | fgrep /A
>  36765717       1  556021 4258201579    0  740 12:47:44 /c/HOME/PIERRE/A
>
>The problem is that the execed process has itself as ppid.
>So it forks again.
>
>That must be history by now, but I think it's coming from
> if (!myself->wr_proc_pipe)
> 	         {
> 	           myself.hProcess = pi.hProcess;
> 	           myself.remember ();
> 	           wait_for_myself = true;
> 	         }
>with wr_proc_pipe having been reset to NULL.

Yes, myself.remember() should not have been resetting the parent pid.
Fixing this made me realize that I'd made mychild() in sigproc.cc more
expensive than it should have been.  I reverted it to its old behavior
and eliminated the need for ppid to be set.

This did exhibit the same behavior on XP as on Me (I finally got Me
running).  I don't know what I was hallucinating before.

cgf
