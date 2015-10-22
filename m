Return-Path: <cygwin-patches-return-8258-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95272 invoked by alias); 22 Oct 2015 15:31:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 94463 invoked by uid 89); 22 Oct 2015 15:31:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.7 required=5.0 tests=AWL,BAYES_40,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=no version=3.3.2
X-Spam-User: qpsmtpd, 2 recipients
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.15.19) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 22 Oct 2015 15:31:10 +0000
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0LdHqj-1aFa5i1JM9-00iSz2; Thu, 22 Oct 2015 17:31:07 +0200
Date: Thu, 22 Oct 2015 15:31:00 -0000
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Introduce the 'usertemp' filesystem type
In-Reply-To: <20151021182346.GE17374@calimero.vinschen.de>
Message-ID: <alpine.DEB.1.00.1510221709400.31610@s15462909.onlinehome-server.info>
References: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com> <20151020093741.GA17374@calimero.vinschen.de> <alpine.DEB.1.00.1510201251140.31610@s15462909.onlinehome-server.info> <20151021182346.GE17374@calimero.vinschen.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:jHt8YMfwxIw=:E9mP5lRHm+VdpW4wdlWl/m jE77R+8QnWvaLV9W9TahOWlJtJ0kYZsPs0KfFcyo2OKk5yNFEOkzS/DUwdMrQTMB+aAnwGTdV 8qnc6SpvW/CZv0O8jAJl6FoZB+5GJVurP1qkwty4722l30PMm9LpOdCX4cuUJdFqDwSUSa5zk JWn+9Mdge+q+fJk45c2anDviXMMAXhe0ZzDGHxtxjNGd851iGiTTLh3gEuOflYuAcnTeMJuxd P/Dga6MymudjsMl0T4OAzJ4voGUNOauuxYo3EOsJKYs31HvJ58wYekahCF3m0D51JymPut5r/ tWfLn4f2DW4jjbRnDYGuClCY1+Dmhcd5HlzI1dWaDpGeUuth0H+b7HlDBOxwKZ+DS7YiCQJT2 OpsgN++6fkYdcrQjJBp+wLhOnf3fdPgxC+6egfCc7HNJ3+opTHVSRDIP2lsc5CIWV36lxwjMj W1vRd6LfwmCafvZgzjQiEHB45HSX4bmqWq7N47tLTYek2fbvv+1BRmDpyPKQSRldE1ov2xCRX Zq9PPFlSPBzKOmkKSJ2RBwX3d7c2YtY5/5pZbWpsD+jyBfz/mplBYM25p0L8GkQKTvK9LdKmP 5AWavUBvdjldgh1p1lZVNH8MtDBwEuz5TZb6IzjIQHhVse2STOO1te+E2CpBl2UetGGEvEBQR BVHzALqZsaKBAMB5ZjC1JgBTmC6r4X2meF1iCONfl0ymd4lIjnyJAMU/zDlqQuuPA5SSYCodq 7o3qTMK105N4NkQOxlUiOzWG8YAH9VYTrhsGXTY31k4t4IYkvyhwIwaQ4jPsjzc7gyI/4otqH bUm9Ntg
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00011.txt.bz2

Hi Corinna,

On Wed, 21 Oct 2015, Corinna Vinschen wrote:

> On Oct 20 13:47, Johannes Schindelin wrote:
> > On Tue, 20 Oct 2015, Corinna Vinschen wrote:
> > > On Sep 16 09:35, Johannes Schindelin wrote:
> > >
> > > > By specifying
> > > > 
> > > > 	none /tmp usertemp binary,posix=0 0 0
> > > > 
> > > > in /etc/fstab, the /tmp/ directory gets auto-mounted to the
> > > > directory specified by the %TEMP% variable.
> > > 
> > > In theory you could also utilize /etc/fstab.d/$USER, without the
> > > need to implement a usertemp mount type.
> > 
> > This is unfortunately not possible. The use case that triggered this
> > patch is Git for Windows (which does not use Cygwin directly, but the
> > MSys2 runtime which is derived from Cygwin).
> 
> Editorial note: 
> 
> It's a bit hard to understand why we need Git for Windows while there's
> a full fledged git available as part of the Cygwin distro.  It's also
> very frustrating that a Git for Windows standalone tool gets a lot of
> press coverage while nobody seems to care that Git for Windows under
> Cygwin exists for ages.  Sigh.

I actually used Cygwin Git myself. However, I had to work with a large
project and the POSIX emulation just put a serious dent into my
productivity.

Don't get me wrong: I love what Cygwin does. It is just that for using Git
efficiently, we needed to go directly to the Win32 API. So Git for Windows
is substantially faster, and takes less resources, than Cygwin Git.

Take for example the good old stat() call. If you need to run `git
status`, you require the modified time of every tracked file, so you call
stat() on it, right? There is an equivalent call in the Win32 API, but it
does not quite get as much information as the stat() call. So to emulate
the stat() call on Windows, we need to call additional Win32 API functions
to fill in those data. The really stupidly annoying thing about this is
that quite often, Git does not even care about those data and just throws
them away!

Another thing is that Git often calls external processes. The POSIX call
is `fork()`. But `fork()` does so much more than spawn a process: it
emulates the copy-on-write feature and also copies the file descriptors
and all that, but Git does not care and ignores all that and all the
effort was spent for naught.

That is why Git for Windows is so much faster than Cygwin Git.

It will get even faster in the future, when we convert more scripts into
builtins, because the shell we use is of course the venerable Bash, using
Cygwin's excellent fork() emulation.

So please understand that I am very, very thankful that Cygwin exists and
is maintained and developed further. At the same time, I think it is
important to develop Git for Windows further, to improve the user
experience.

> > Indeed. In Git for Windows' case, this is actually a feature. That way,
> > different users' files are encapsulated from each other.
> > [...]
> > As I said, in a multi-user setting, or even worse: in a portable
> > application, this is simply not possible other than via the strategy
> > implemented by this patch.
> 
> Here's a question.  If it's really only about git, why do you need
> to redirect /tmp, rather than having git use $TMP directly?

Ah, if it only was that easy! Then I would not bother you at all and do
exactly what you suggested.

The truth, however, is that Git expects quite a few utilities to be
available, utilities that are usually present in any Unix-like system. But
not on Windows. So we need to rely on tools that are shipped with MSys2 to
perform those tasks. One such tool is ssh-agent which *does* want to write
into `/tmp/` (see https://github.com/git-for-windows/git/issues/86).

At the same time, we really have to install our pseudo root file system
into `C:\Program Files` because this is the way things work on Windows. So
we *have* to mount `/tmp/`, and what better way than the Windows way: use
the dedicated per-user temporary directory? That is the way things work on
Windows.

> That would be much less intrusive than having to change the underlying
> POSIX layer, isn't it?

It would be less intrusive, I agree. But it would also not solve the
problem, so it is not a solution ;-)

> > [...]
> > > > +          char mb_tmp[len = sys_wcstombs (NULL, 0, tmp)];
> > > 
> > > - len = sys_wcstombs() + 1
> > 
> > Whoops. I always get that wrong.
> > 
> > But... actually... Did you know that `sys_wcstombs()` returns something
> > different than advertised? The documentation says:
> > 
> > 	- dst == NULL; len is ignored, the return value is the number
> > 	  of bytes required for the string without the trailing NUL, just
> > 	  like the return value of the wcstombs function.
> > 
> > But when I call
> > 
> > 	small_printf("len of 1: %d\n", sys_wcstombs(NULL, 0, L"1"));
> > 
> > it prints "len of 1: 2", i.e. the number of bytes requires for the string
> > *with* the trailing NUL, disagreeing with the comment in strfuncs.cc.
> 
> Drat.  You're right.  As usual I wonder why nobody ever noticed this.
> As soon as the nwc parameter is larger than the number of non-0 wchars
> in the source string, sys_cp_wcstombs returns the length including the
> trailing NUL.
> 
> And looking through the Cygwin sources the usage is rather erratic,
> sometimes with, sometimes without + 1 :(

Thanks for confirming!

> > How do you want to proceed from here? Should I fix sys_wcstombs() when
> > the fourth parameter is -1? Or is this not a fix, but I would rather
> > break things?
> 
> No, this needs fixing, but it also would break things.  I have to take a
> stab at fixing this throughout Cygwin first.

I saw your patch and will try to rework my patch as soon as possible so
that I can resubmit once the paperwork re: copyright is done.

Thank you,
Johannes
