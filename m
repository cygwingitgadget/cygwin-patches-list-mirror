Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id CBA5A397303B
 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021 20:19:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CBA5A397303B
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mf0uq-1lGZCl1WTS-00gbVh for <cygwin-patches@cygwin.com>; Thu, 20 May 2021
 22:19:53 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 43FCAA82BFD; Thu, 20 May 2021 22:19:52 +0200 (CEST)
Date: Thu, 20 May 2021 22:19:52 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: utils: chattr: Improve option parsing.
Message-ID: <YKbEaE8jPiIBbt7c@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <d515bfba-ce77-40c0-0c3e-67895675f753@t-online.de>
 <YKVPOaBrb0a9lV54@calimero.vinschen.de>
 <e78257d8-bd2a-3ea0-0cea-48114ec017a0@t-online.de>
 <YKajIZm3F4OpX5sx@calimero.vinschen.de>
 <f4bff7ef-17c1-357e-0630-0d7d587e467f@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4bff7ef-17c1-357e-0630-0d7d587e467f@t-online.de>
X-Provags-ID: V03:K1:RAbClbc5gQyqIFwO3v0s9fosvwGTPVY9A+JZhkDMEATwKyF5kRd
 nLekG9sMosV7u6P2USBPEeuiw3Lmt1WF6DHv2emRyJTEoRXc94sj6K1utoF0CHs3mD0sSt8
 Yt7o+L4p5tdXHWZ5T1cwZjhV22A8mc9UwBCljhZ9sVOLL0iPUHDkQBGCLylQXvDvUoW9C+N
 Geg018aikJgCdhDXSPA+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GwXwCcr7hCg=:kHhGCT06fGxpBd/Le4cFTu
 /4eWPlGgMCD6pSwToybWpD1hGWg5YzLEn1Y/Ye+M4HzoPiNjK0q1/OWkp2B3TzC4S+MHzE58x
 WmNM7YBrrlnt+YvDO1GUtB+tIOhu20wByS6KfGvmuAiETUJ4AEqpkevfxK3pc2d47rCPh7CBz
 oJWQAMD6LYo9joyqVrp39FGHmR5tRHUoPUAvBfBSs0OpwN4hxy//MCb1Rw1BvuCLHlHckowPm
 tGJ2hmwtDjILJMaNFIRSwIqXaq/E7UtBJ1bIy4mnEAHfL7FHjx74zj8ctjaUZu9iFKiR8AuLO
 L/3znIc7ZROn6mf7NIJklOODzAl6+62Glfui1irc4OYVePwAmbSioto9RZqmfBe8ewt0RZeGE
 UR/ZXWvjcJ/VpfKmo+22SI9AcjEE/FMvAjtD7nuAncE1fAV/mVURI2JldmN05ssJbu1OK7ZKF
 zHCpK9v1x5SvHvnke1ffTSbHy2d8Vn548Flg7upL0UoybFmqJp/WHqx7nZ0qCJkn8yXccBmsz
 Fi+VyCgy2s2X9kuPbRE/gA=
X-Spam-Status: No, score=-98.6 required=5.0 tests=BAYES_00, BODY_8BITS,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 20 May 2021 20:19:56 -0000

On May 20 21:48, Christian Franke wrote:
> Hi Corinna,
> 
> Corinna Vinschen wrote:
> > Hi Christian,
> > 
> > On May 20 12:01, Christian Franke wrote:
> > > Corinna Vinschen wrote:
> > > > On May 19 17:46, Christian Franke wrote:
> > > > > ...
> > > > > $ egrep 'ACL|--r' chattr.c
> > > > >             "Get POSIX ACL information\n"
> > > > >         "  -R, --recursive     recursively list attributes of directories and
> > > > > their \n"
> > > > Oops.  Please patch while you're at it...
> > > > ...
> > > > >   From 865a5a50501f3fd0cf5ed28500d3e6e45a6456de Mon Sep 17 00:00:00 2001
> > > > > From: Christian Franke<...>
> > > > > Date: Wed, 19 May 2021 16:24:47 +0200
> > > > > Subject: [PATCH] Cygwin: utils: chattr: Improve option parsing.
> > > > > 
> > > > > Interpret '-h' as '--help' only if last argument.
> > > > Who was the idiot using -h for help *and* the hidden flag? *blush*
> > > > 
> > > > I'd vote for --help to be changed to -H for the single character
> > > > option.  The help output is very unlikely to be used in scripts,
> > > > so that shouldn't be a backward compat problem.
> > > New patch attached.
> > > 
> > > Note that there is now the possibly unexpected (& hidden) behavior that
> > > 'chattr -h' without file argument clears the hidden attribute of cwd.
> > Uhm... why?
> 
> Because chattr uses '.' as default if no FILE argument is specified. The
> same applies to all other '+-=MODE' arguments. The patch does not change
> this behavior but of course enables it for '-h'.

Oh, right.  I can't reproduce this behaviour with the most recent chattr
from e2fsprogs in F33.  Sorry, I'm not sure anymore why I did that.  But
given the entire behaviour is rather unexpected, and it's not even
documented, maybe we should drop it, too?  Not sure if backward compat
counts in this case...

> Another behavior (possibly inherited from lsattr) is also not very useful:
> 'chattr +-=MODE DIRECTORY' also changes the attributes of all elements in
> the directory (not recursively). It is not possible to solely change the
> attributes of a directory except if it is the current directory and no FILE
> argument is passed. Fixing this would again break backward compatibility.

Ouch, no!  That's a bug.  The expression in line 354 should have been

    if (S_ISDIR (st.st_mode) && Ropt && chattr_dir (argv[optind]))
		ret = 1;

the Ropt check is just missing.


Corinna
