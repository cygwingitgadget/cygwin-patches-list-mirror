Return-Path: <cygwin-patches-return-4242-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9202 invoked by alias); 26 Sep 2003 03:20:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9050 invoked from network); 26 Sep 2003 03:20:30 -0000
Date: Fri, 26 Sep 2003 03:20:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: {Patch]: Giving access to pinfo after seteuid and exec
Message-ID: <20030926032026.GA32450@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030926021722.GA30575@redhat.com> <3.0.5.32.20030925214748.0081f330@incoming.verizon.net> <20030926021722.GA30575@redhat.com> <3.0.5.32.20030925225641.00820820@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030925225641.00820820@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00258.txt.bz2

On Thu, Sep 25, 2003 at 10:56:41PM -0400, Pierre A. Humblet wrote:
>At 10:23 PM 9/25/2003 -0400, you wrote:
>>On Thu, Sep 25, 2003 at 10:17:22PM -0400, Christopher Faylor wrote:
>>>I'll check in the rest of the spawn.cc stuff with some modifications.  I see
>>>I missed some cases with the addition of _P_SYSTEM.
>>
>>I'm sorry.  Long day.  I'm checking in the non-acl related stuff.  I'll leave
>>the rest for Corinna's review.
>>
>OK.
>
>By the way, in the case      
>if (!child)
>	{
>	  syscall_printf ("pinfo failed");
>	  set_errno (EAGAIN);
>
>the EAGAIN is masking the true reason that should have been set by the
>pinfo code. That may be Posix, but it's not helpful from a debugging
>point of view.

If it's a cygwin problem there should be enough clues in strace or
whatever.  SUSv3 says that there should be two possible errnos on error
-- EAGAIN or ENOMEM.  If we were strictly correct we could check for the
ENOMEM case and not overwrite it.

cgf
