Return-Path: <cygwin-patches-return-4923-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25201 invoked by alias); 30 Aug 2004 23:28:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25192 invoked from network); 30 Aug 2004 23:28:53 -0000
Message-Id: <3.0.5.32.20040830192440.0081b1c0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Mon, 30 Aug 2004 23:28:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [PATCH]: broken pipe
In-Reply-To: <20040830042249.GA8900@trixie.casa.cgf.cx>
References: <3.0.5.32.20040829125154.00810900@incoming.verizon.net>
 <3.0.5.32.20040829125154.00810900@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00075.txt.bz2

At 12:22 AM 8/30/2004 -0400, Christopher Faylor wrote:
>On Sun, Aug 29, 2004 at 12:51:54PM -0400, Pierre A. Humblet wrote:
>
>>
>>My solution is for the parent fork to return the cygpid calculated
>>from the winpid.
>>The test program is still running after 100,000 fork/exec/pipe,
>>a longevity record. 
>
>Wouldn't the below solve this problem more minimally?  It moves the
>setting of forked_pid to after it is known that the pinfo structure
>has been filled out.

That will work just fine as well.

Having spent time understanding the program flow,
I thought it would help others to see unambiguously
that the forked cygpid is the already known winpid (on NT).
Waiting to read the pinfo suggests that the child may have
put something different in there.

>>Two other comments:
>>- there is still a race to create the pinfo. Hopefully all versions
>>of Windows handle it properly. To be on the safe side, the parent could
>>open (not create) the pinfo after the child's longjmp.
>>- the parent copies myself->progname into the child. This seems
>>duplicative, given that the child always sets progname from 
>>GetModuleFileName in set_myself.
>
>I'm not clear on why you think the race is a problem.  The end result
>should be that the correct info is in the pinfo regardless.  It shouldn't
>matter if CreateFileMapping or OpenFileMapping is called.

Terminal paranoia. I am just worried that doing so on every fork may
end up exposing an MS bug (you rightly wrote "shouldn't", not "doesn't").
Also, there must be a critical section in the kernel. Letting Windows 
decide in what order things are done may lead to more process switching
than having Cygwin avoid the conflict. 

Pierre

