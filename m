Return-Path: <cygwin-patches-return-4925-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14865 invoked by alias); 31 Aug 2004 01:18:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14848 invoked from network); 31 Aug 2004 01:18:26 -0000
Message-Id: <3.0.5.32.20040830211409.008097e0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 31 Aug 2004 01:18:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [PATCH]: broken pipe
In-Reply-To: <20040831005305.GB24132@trixie.casa.cgf.cx>
References: <3.0.5.32.20040830192440.0081b1c0@incoming.verizon.net>
 <3.0.5.32.20040829125154.00810900@incoming.verizon.net>
 <3.0.5.32.20040829125154.00810900@incoming.verizon.net>
 <3.0.5.32.20040830192440.0081b1c0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00077.txt.bz2

At 08:53 PM 8/30/2004 -0400, Christopher Faylor wrote:
>On Mon, Aug 30, 2004 at 07:24:40PM -0400, Pierre A. Humblet wrote:
>>At 12:22 AM 8/30/2004 -0400, Christopher Faylor wrote:
>>>On Sun, Aug 29, 2004 at 12:51:54PM -0400, Pierre A. Humblet wrote:
>>>
>>>>
>>>>My solution is for the parent fork to return the cygpid calculated
>>>>from the winpid.
>>>>The test program is still running after 100,000 fork/exec/pipe,
>>>>a longevity record. 
>>>
>>>Wouldn't the below solve this problem more minimally?  It moves the
>>>setting of forked_pid to after it is known that the pinfo structure
>>>has been filled out.
>>
>>That will work just fine as well.
>>
>>Having spent time understanding the program flow, I thought it would
>>help others to see unambiguously that the forked cygpid is the already
>>known winpid (on NT).  Waiting to read the pinfo suggests that the
>>child may have put something different in there.
>
>Which is what I wanted to achieve, actually.  I wanted to make it clear
>that the setting of the pid was under the child's control.  If you
>assume that the pid is always going to be X in two places then, at some
>point in the future, when you change the pid to be Y you have to
>remember to change two places.

Except it can't work that way. For two reasons:
1) If the parent gets to create the pinfo, IT will set the pid in the pinfo
and the child won't. They have to agree. 
2) The pid needs to be in the name of the mapping for the parent and the
child to open it (by name) independently of each other.
So you have to change it in both places, or invent a new interprocess
comm mechanism.
It's to avoid that kind of research/head-scratching to the next guy that
I wanted to clarify the logic. It's complicated enough.  

>>>>Two other comments:
>>>>- there is still a race to create the pinfo. Hopefully all versions
>>>>of Windows handle it properly. To be on the safe side, the parent could
>>>>open (not create) the pinfo after the child's longjmp.
>>>>- the parent copies myself->progname into the child. This seems
>>>>duplicative, given that the child always sets progname from 
>>>>GetModuleFileName in set_myself.
>>>
>>>I'm not clear on why you think the race is a problem.  The end result
>>>should be that the correct info is in the pinfo regardless.  It shouldn't
>>>matter if CreateFileMapping or OpenFileMapping is called.
>>
>>Terminal paranoia. I am just worried that doing so on every fork may
>>end up exposing an MS bug (you rightly wrote "shouldn't", not "doesn't").
>>Also, there must be a critical section in the kernel. Letting Windows 
>>decide in what order things are done may lead to more process switching
>>than having Cygwin avoid the conflict. 
>
>I wouldn't be surprised that there is not much difference between
>CreateFileMapping and OpenFileMapping.  It's possible that OpenFileMapping
>is more expensive than CreateFileMapping, given Microsoft.

That's not the point. One guy does the Create, the other does the Open.
Total CPU time doesn't change, only who does what. 
But given that both run at the same time, one is likely to be blocked by the
other, generating process switchover overhead. If the parent waits until the
child is done (something it does eventually, so it's free), then there is
never any conflict.

>More importantly, unlike the above "forked_pid" code, which is recent,
>the logic flow for the rest of this stuff hasn't changed in a while so
>I'm inclined not to rock the boat.

That's reasonable. 

Pierre
