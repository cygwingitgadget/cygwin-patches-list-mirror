Return-Path: <cygwin-patches-return-5732-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24939 invoked by alias); 2 Feb 2006 17:06:01 -0000
Received: (qmail 24866 invoked by uid 22791); 2 Feb 2006 17:06:01 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 02 Feb 2006 17:06:00 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id BE1A313C0F8; Thu,  2 Feb 2006 12:05:58 -0500 (EST)
Date: Thu, 02 Feb 2006 17:06:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com, gdb-patches@sourceware.org
Subject: Re: [patch] fix spurious SIGSEGV faults under Cygwin
Message-ID: <20060202170558.GD22365@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, gdb-patches@sourceware.org
References: <43E1FA66.216E236C@dessent.net> <43E22C81.1C4600BA@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E22C81.1C4600BA@dessent.net>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00041.txt.bz2

On Thu, Feb 02, 2006 at 08:00:01AM -0800, Brian Dessent wrote:
>Brian Dessent wrote:
>
>>  #define _CYGWIN_SIGNAL_STRING "cYgSiGw00f"
>> +#define _CYGWIN_FAULT_IGNORE_STRING "cYgfAuLtIg"
>> +#define _CYGWIN_FAULT_NOIGNORE_STRING "cYgNofAuLtIg"
>
>Sigh, this breaks strace under Cygwin, I should have tested more.  Sorry
>about that.  Apparently strace expects anything starting with the 'cYg'
>prefix to be followed by a hex number.  I thought that since
>_CYGWIN_SIGNAL_STRING already existed and didn't follow that format it
>was safe to add more, but that's not the case.
>
>So, should I pick another prefix that's not 'cYg'?  Or instead use
>something like "cYg0 ..." since strace seems to just ignore the string
>if its value is 0?  Or something else?

Brian,
Thanks for the patch but I've been working on this too and, so far, I think
it is possible to have a very minimal way of dealing with this problem.  I
haven't had time to delve into it too deeply but I have been exploring this
problem on and off for a couple of weeks.  If the situation at work calms
down a little I may be able to finish up what I've been working on.

OTOH, if what I have is really not working then I'll take a look at what
you've done.

Again, thanks for the patch.  I probably should have sent a heads up that
I was working on this.

cgf
