Return-Path: <cygwin-patches-return-4926-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25939 invoked by alias); 31 Aug 2004 03:18:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25929 invoked from network); 31 Aug 2004 03:18:43 -0000
Date: Tue, 31 Aug 2004 03:18:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: broken pipe
Message-ID: <20040831031929.GE24132@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040830192440.0081b1c0@incoming.verizon.net> <3.0.5.32.20040829125154.00810900@incoming.verizon.net> <3.0.5.32.20040829125154.00810900@incoming.verizon.net> <3.0.5.32.20040830192440.0081b1c0@incoming.verizon.net> <3.0.5.32.20040830211409.008097e0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040830211409.008097e0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00078.txt.bz2

On Mon, Aug 30, 2004 at 09:14:09PM -0400, Pierre A. Humblet wrote:
>At 08:53 PM 8/30/2004 -0400, Christopher Faylor wrote:
>>On Mon, Aug 30, 2004 at 07:24:40PM -0400, Pierre A. Humblet wrote:
>>>At 12:22 AM 8/30/2004 -0400, Christopher Faylor wrote:
>>>>On Sun, Aug 29, 2004 at 12:51:54PM -0400, Pierre A. Humblet wrote:
>>>>
>>>>>
>>>>>My solution is for the parent fork to return the cygpid calculated
>>>>>from the winpid.
>>>>>The test program is still running after 100,000 fork/exec/pipe,
>>>>>a longevity record. 
>>>>
>>>>Wouldn't the below solve this problem more minimally?  It moves the
>>>>setting of forked_pid to after it is known that the pinfo structure
>>>>has been filled out.
>>>
>>>That will work just fine as well.
>>>
>>>Having spent time understanding the program flow, I thought it would
>>>help others to see unambiguously that the forked cygpid is the already
>>>known winpid (on NT).  Waiting to read the pinfo suggests that the
>>>child may have put something different in there.
>>
>>Which is what I wanted to achieve, actually.  I wanted to make it clear
>>that the setting of the pid was under the child's control.  If you
>>assume that the pid is always going to be X in two places then, at some
>>point in the future, when you change the pid to be Y you have to
>>remember to change two places.
>
>Except it can't work that way. For two reasons:
>1) If the parent gets to create the pinfo, IT will set the pid in the pinfo
>and the child won't. They have to agree. 

Actually, on inspection, either the parent or the child will set it, not
both.  If this was really an issue then moving the pinfo declaration
later in fork_parent would eliminate the problem of deciding which sets
it.

>2) The pid needs to be in the name of the mapping for the parent and the
>child to open it (by name) independently of each other.

Ok, that's true.  The fact is that the parent has to know the child's
pid in order to access the child's pinfo structure.

>So you have to change it in both places, or invent a new interprocess
>comm mechanism.
>It's to avoid that kind of research/head-scratching to the next guy that
>I wanted to clarify the logic. It's complicated enough.  

Ok.  I understand now.  I'll check in your original patch.

My reason for using forked->pid originally was that I thought that the
definitive location for the pid should come from here but it doesn't
make sense to be so rigid since the parent really needs to know the
child's pid right away.

>>I wouldn't be surprised that there is not much difference between
>>CreateFileMapping and OpenFileMapping.  It's possible that
>>OpenFileMapping is more expensive than CreateFileMapping, given
>>Microsoft.
>
>That's not the point.  One guy does the Create, the other does the
>Open.  Total CPU time doesn't change, only who does what.  But given
>that both run at the same time, one is likely to be blocked by the
>other, generating process switchover overhead.  If the parent waits
>until the child is done (something it does eventually, so it's free),
>then there is never any conflict.

Or, alternatively, the parent creates the structure while the child is
still chugging through its initialization code, prior to calling
"set_myself", allowing two separate things to be happening on a
(shudder) hyperthreaded system.  That's why I have some of the pid
initialization happening prior to a "sync point" with the child.

This actually would imply that when possible the parent should create
the pid and that it is silly to insist that somehow the child is
creating its pid so it's another argument for just doing things the way
you wanted to originally.

cgf
