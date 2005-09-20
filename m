Return-Path: <cygwin-patches-return-5652-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16696 invoked by alias); 20 Sep 2005 16:05:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16659 invoked by uid 22791); 20 Sep 2005 16:05:44 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 20 Sep 2005 16:05:44 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 92C0E3B0001; Tue, 20 Sep 2005 16:05:42 +0000 (UTC)
Date: Tue, 20 Sep 2005 16:05:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: PING: fix ARG_MAX
Message-ID: <20050920160542.GA6720@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20050906T172937-420@post.gmane.org> <loom.20050910T164247-175@post.gmane.org> <20050912152245.GB29379@calimero.vinschen.de> <43265113.3000207@byu.net> <20050919143101.GA16760@trixie.casa.cgf.cx> <433003E8.90701@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433003E8.90701@byu.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00107.txt.bz2

On Tue, Sep 20, 2005 at 06:43:20AM -0600, Eric Blake wrote:
>According to Christopher Faylor on 9/19/2005 8:31 AM:
>>If this is really true, then the findutils configury should be
>>attempting some kind of timing which finds that magic point where it
>>should be ignoring _SC_ARG_MAX.  It shouldn't be vaguely assuming that
>>it is in its best interests to ignore it because someone thinks that
>>the cost of processing each argument outweighs the benefits of forking
>>fewer tests.
>
>POSIX allows xargs to have a default size (currently, xargs defaults to
>128k unless otherwise constrained by _SC_ARG_MAX), and that -s can
>change that size to anything within the range permitted by _SC_ARG_MAX.

AFAICT, we're not talking about defaults.  We're talking about the
optimum setting.

Your change to xargs doesn't permit me to go beyond 32K.  Personally,
I'd like to be able to override that.

>>Given that cost of forking is much more expensive on cygwin than on
>>other systems I really don't see how you can use this argument anyway
>>and, IMO, it doesn't make much sense on standard UNIX either.  If you
>>create more processes via fork you are invoking the OS and incurring
>>context switches.  You're still processing the same number of arguments
>>but you're just going to the OS to handle them more often.  I don't see
>>how that's ever a win.
>
>In isolation, no.  But it is what else you are doing with the arguments
>- the text processing of xargs to parse it into chunks, and the invoked
>utility's processing of its argv, that also consumes time.  Also, lots
>of data tends to imply more page faults, which can be as expensive as
>context switches anyways.

Context switches also imply page faults.

>> I'm willing to be proven wrong by hard data but I think that you and the
>> findutils mailing list shouldn't be making assumptions without data to
>> back them up.
>
>Did you not read the thread on bug-findutils?  Bob Proulx proposed a test
>that shows that there is NO MEASURABLE DIFFERENCE between a simple xargs
>beyond a certain -s:
>http://lists.gnu.org/archive/html/bug-findutils/2005-09/msg00038.html

No, I didn't read a thread in another mailing list.  Thank you for
providing references.

>Then I repeated the test on cygwin, and found similar results:
>http://lists.gnu.org/archive/html/bug-findutils/2005-09/msg00039.html
>
>There comes a point, where even when all xargs is doing is invoking echo,
>that the cost of passing that much information through pipes does overtake
>the cost of forks.

I have a similar test which shows noticeable improvement when going from
32K to 64K and miniscule-but-still-there improvements after that:

#!/bin/sh
export TIMEFORMAT='real %3lR  user %3lU  sys %3lS'
for i in 20480 32768 65536 131072 262144 524288 1048576 2097152 4194304; do
 time /bin/bash -c "/bin/head -n150000 /tmp/files | /bin/xargs -s$i echo >/dev/null"
done

timing 20480: real 0m12.448s  user 0m18.408s  sys 0m7.223s
timing 32768: real 0m8.448s  user 0m12.811s  sys 0m4.890s
timing 65536: real 0m5.191s  user 0m8.472s  sys 0m3.085s
timing 131072: real 0m4.318s  user 0m5.908s  sys 0m1.665s
timing 262144: real 0m3.833s  user 0m4.841s  sys 0m1.213s
timing 524288: real 0m3.566s  user 0m3.900s  sys 0m1.078s
timing 1048576: real 0m3.478s  user 0m3.564s  sys 0m0.665s
timing 2097152: real 0m3.417s  user 0m3.039s  sys 0m0.821s
timing 4194304: real 0m3.395s  user 0m3.370s  sys 0m0.823s

/tmp/files is the output of 'find /' on my system.

I prefer my test because it measures the clock time of the entire
operation rather than just the amount of time taken by xargs. YMMV.

What I think you can take away from this is that you can't make
assumptions about an optimal size that will work for every system.

>However, I am also keen on providing a more reasonable -s behavior in
>xargs.  If cygwin were to have pathconf(filename, _PC_ARG_MAX), where a
>PATH search were done when filename does not contain '/', then pathconf
>could return 32k on Windows processes, and unlimited (or an actual known
>limit) for cygwin processes, so that xargs can then allow unlimited -s
>sizes for cygwin processes but cap windows processes at 32k and never
>encounter the E2BIG.

I am not really interested in providing a non-standard interface which
would ultimately end up being used just by xargs.  That would mean that
we're adding an interface to cygwin so that a UNIX program could work
better with non-cygwin programs.  I think I've been pretty consistent in
stating that I want to encumber cygwin as little as possible when it
comes to accommodating non-cygwin programs.

If you want to keep the 32K limit, that's ok with me.  I'd just ask that
you make it possible to override it.

But, then, I suspect that this wasn't overrideable when I was providing
xargs either so you can feel free to ignore my request.

cgf
