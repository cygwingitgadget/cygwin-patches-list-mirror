Return-Path: <cygwin-patches-return-4127-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18096 invoked by alias); 20 Aug 2003 01:32:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18080 invoked from network); 20 Aug 2003 01:32:36 -0000
Date: Wed, 20 Aug 2003 01:32:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030820013236.GA26448@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <3.0.5.32.20030819193152.00817750@incoming.verizon.net> <20030820004135.GA25456@redhat.com> <3.0.5.32.20030819212357.0081eb30@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030819212357.0081eb30@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00143.txt.bz2

On Tue, Aug 19, 2003 at 09:23:57PM -0400, Pierre A. Humblet wrote:
>At 08:50 PM 8/19/2003 -0400, Christopher Faylor wrote:
>>On Tue, Aug 19, 2003 at 08:41:35PM -0400, Christopher Faylor wrote:
>>>However, it has been bothering me for a long time that all of this
>>>signal mask stuff is in the pinfo structure.  This is a holdover from
>>>early cygwin that doesn't make any sense.  So, sometime soon, I'm
>>>going to rip much of the signal handling out of pinfo and put it
>>>into local arrays.
>
>OK.

FWIW, I probably wasted a full day trying to get myself-> information
into the asm.  Who knows?  Maybe it works now.  I don't know if I've
tried this with gcc 3.2 or if it stopped working with 3.2.

>>Actually, just to clarify, you do have to save siga's mask away
>>somewhere since there could be a race otherwise.
>
>Good point. But siga = myself->getsig (sig) so it can be calculated
>on the fly.
>Or do you mean that the program could change the sigaction mask
>in midstream? That would be unsafe programming.

I'm saying that you want to use the signal's mask when the program gets
the signal, not the signal's mask from when the program finally gets
around to calling the signal handler.

Although, hmm.  My brain hurts.  Maybe the latter behavior is more
correct since if something is in the middle of changing the mask it will
be guaranteed to be correct when the signal handler is finally called.
