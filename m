Return-Path: <cygwin-patches-return-4080-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1876 invoked by alias); 13 Aug 2003 15:44:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1851 invoked from network); 13 Aug 2003 15:44:46 -0000
Message-ID: <3F3A5CE4.10004@netscape.net>
Date: Wed, 13 Aug 2003 15:44:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Questions and a RFC [was Re: Assignment from Nicholas Wourms
 arrived]
References: <20030812191411.GH17051@cygbert.vinschen.de> <3F39704F.6030001@netscape.net> <20030813113509.GA24855@cygbert.vinschen.de>
In-Reply-To: <20030813113509.GA24855@cygbert.vinschen.de>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q3/txt/msg00096.txt.bz2

cygwin-patches@cygwin.com wrote:

> On Tue, Aug 12, 2003 at 06:55:11PM -0400, Nicholas Wourms wrote:
> 
>>1)Did my MUA strip the tabs from the patch?  The only reason I ask is 
> 
> 
> Yes.  The patch already contained spaces.  I see you're using Mozilla/NS7
> so I'm wondering how this happened.  AFAIK, Mozilla doesn't touch
> attachments.

Alas, I fear that NS7.1(aka Moz 1.4) is having the same problem folks 
were having on the LKML with 1.4...  I think the work around was to send 
formatted attachments as .txt so that Moz would get the mime-type right. 
  I'll send a clean up patch with a clarifying comment for NBBY to test 
this theory.

> 
> No :-)
> 
> Long answer:  You don't need any assignment for newlib due to the relaxed
> licensing of newlib.

Excellent.

> 
>>3)I'm still trying to figure out how to use lstat in newlib source code, 
> 
> 
> What are you trying to implement?  If you need lstat, you're perhaps better
> off implementing this in Cygwin instead of newlib.

ftw/nftw.  Per Gerrit's suggestion on the list, I looked at OpenBSD's 
version of ftw/nftw they did for the US DOD.  IMHO, it looks the be the 
most robust compared to the other Non-GPL'ed versions floating around. 
I suppose one could write it from scratch, but if a reasonable 
implementation exists, why bother?  Of course to the next point...

Perhaps it doesn't belong in newlib, as it isn't terribly portable in 
it's current state.  I basically had to disgorge a bunch of extra code 
code which was targeted at platforms with a more robust(mature?) 
opendir().  However, I suppose I could just #if 0 it, and leave it to 
the linux/ELIX people to fix up the parts which apply to them [1].

> 
>> since apparently the function declaration is hidden when building 
>>newlib/cygwin.  So far, any attempt to use it results in undefined 
>>references to _lstat when linking the dll.  I tried adding a definition 
>>to _syslist.h, but that didn't work.  I hate to sound clueless, but if 
>>someone could nudge me toward the right header or magic, that would be 
>>great.
> 
> 
> cd winsup/cygwin
> ctags -R .
> vi -t cygwin_lstat
> 
> However, thinking about this situation, I'm sure it wasn't really clever
> to rename lstat to cygwin_lstat.  Your problem to link against it stems
> from that fact and other declaration problems has been easilier solved by
> just adding a bunch of defines at the top of syscalls.cc.

*Doh*  I didn't connect the dots on that one, thanks for the 
clarification :-).  Speaking of aliases, about this time last year, 
Conrad and I were debating the reasoning behind the underscore aliases 
in cygwin.din.  I speculated that they might be a work around for 
elf-centric configuration programs which look for weak versions of the 
symbols (which indeed seems to be the case for argz & the configure 
found in binutils/gcc/gdb).  He thought that it had something to do with 
MSVC compatibility.  However, it seems that people have since stopped 
doing this.  Out of curiosity, what was the history behind doing this? 
For future contributions, what is the official policy on doing it now?

> [...time passes...]
> 
> Ok, I've tested to revert the function name from cygwin_lstat to lstat
> in syscalls.cc and applied the appropriate patch.  This is transparent
> to all applications and should allow to use lstat from newlib as in
> libc/sys/linux.
> 

Thank you, I will submit some code later on for review.  At that time, I 
suppose you can be the judge of where it belongs :-D.  I think, though, 
that I'll wait until post-1.5.x to do this, as it seems to be the 
consensus that we are in a feature "freeze".

>>4)Corinna, I've been working on porting some of the missing 
>>SUSv3/c99/bsd functions from the *bsd libc.  I noticed that the libutil 
>>which you distribute with inetutils contains some of the functions I 
>>thought belonged in libc, or at least the headers of newlib would have 
>>me believe this.  Specifically, I was wanted to work on adding instances of:
>>endusershell()
>>setusershell()
>>getusershell()
>>ruserok()
>>iruserok()
> 
> 
> Don't do this(TM).  The reason is that, first, I have already code for
> this in the loop and, second, I have to coordinate this with changing
> my inetutils package not to contain the libutil.a anymore at one point.
> I appreciate your effort but I'd like to keep these functions in my
> hand, even though it might take a bit longer.

No problem, I didn't know what the story was, which is why I was testing 
the waters before investing any more effort/time.  By all means, I'll 
look at other things to work on, no worries.

Speaking of things in the loop, has any further thought been given to 
David Euresti's patch from last year which enables passing of file 
descriptors between processes via Unix Domain Sockets?  It'd be a shame 
not to use it but, alas, David has expressed no further interest in 
working on it and Conrad (who had intended to pick up the torch) seems 
to have fallen off the face of the earth.  At one point you said you'd 
like to see it go in, but it was dependent on David's cooperation.  Is 
this in the loop or has it been dropped altogether?

> Especially I will not do this for 1.5.2 (or 3, whatever will be the first
> gold version).  At this point, we should only apply bug fixes and very
> obvious stuff.  New functionality should wait for later Cygwin versions.
> 

Right, I think this is sound advice, so I'll hold off on any new stuff 
until post-1.5.

>>5)This is meant as a general RFC based on something I noticed while 
>>researching the freebsd libc.
> 
> 
> Sorry, but I agree with Charles and I'm pretty sure Chris will have the
> same opinion.

Yes, I regret having even suggested it at this point in time.  Sorry for 
the noise.

Cheers,
Nicholas

<OFF-TOPIC>
[1] My opinion on this:
To be clear, when I started on fts, I really had no intention of trying 
to make it work on any other platform besides Cygwin.  Perhaps I'm still 
a bit bitter from the embedded linux people "cheating" by importing big 
chunks of glibc, which effectively stymies their contributions to the 
global newlib.  However, instead of just being angry, I'm going to try 
to do something about it.  My hope is that, in a small way, I can help 
bring some parity between ELIX IV and Cygwin.  The current state of 
newlib just seems terribly unfair, but then again, life is unfair and 
people are mean :-D.
</OFF-TOPIC>
