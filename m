Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 974D4384C004
 for <cygwin-patches@cygwin.com>; Wed,  2 Sep 2020 08:38:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 974D4384C004
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUp8r-1k4HRi1Lnt-00Qgy7 for <cygwin-patches@cygwin.com>; Wed, 02 Sep 2020
 10:38:19 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C92B2A81009; Wed,  2 Sep 2020 10:38:18 +0200 (CEST)
Date: Wed, 2 Sep 2020 10:38:18 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200902083818.GI4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902083014.GH4127@calimero.vinschen.de>
X-Provags-ID: V03:K1:cGVCbXrYVheOtFCytpymJz/kUbqUFTXXQbCjpmdghDln8JYCurl
 jkmbpv3XwXL/BvDscORQqMfnSs6m1rYbYgfSI+Adq1P7k3Ay/AH/RedwYbbDrVmeWPRJJJq
 m7bvLN7y2NO8XxJ+cd3FcVl9Cx3Kfprj/heqL1bMI0s8rAMnShRC0hqjyX42wReTjVvcU8J
 P+r3mhFBXgcQR9kUlaNvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:606LeOwsVt8=:lSsAM6zXg3bTdW+n3NHYYo
 vNYXLV13aJoXT09GDzJ0Lox8JvD+JCTOjYcdR+IFVG0mPVz11ZAPQDNKdHbFislBtDSBLA+rG
 wUsyc1mcpBkrn64sGcmy3FVs9izvGC3mOuUuv+OIBZclIO1XE9S/7XBfvIl3ghBu8jgPLHPY+
 OyxuMwwX3hQGD3a3JYU2igJK+LoD0l23+TGfX+CsrhkUdiU/m9wqXGrDKMIk1Atx9RcDRNoKM
 lyJ5WFtc8h9VZAJbOlKk9hFZVNnUWIq9OOB0CWjwyBXopjbC7CCpfG2KVue0apX2tAlrGLb/l
 v5LDYbM1V62RiljC9yvH8LPVitIzP1YoQgPAtHHdq85FXCUY4oGXU2bI765d13Oqi3VVA8v5U
 oz95qNcwuZyZG8qxxd0ZARiNbssRZ2fXQO6+5h9khYmEztvCTpCzwH0lzjOjRgFVhDfpgGquU
 RIJ0LC4JA4brYf+GD2T0gfWIbMpInl9J92IMmCotONzRxvHvuG/d3UlowR3wUwFMN2KoaNk7v
 Ey68JanNJ80rxrfx+sSnFaUGTogWKfyfKMiAPWFA5ssEeHQzY2vJ3PyJGxAp6rJdwDKCPAEzr
 kXTUpMU91w6JEcEgf9xWcfStzbUcunXjX0UW751ZgImFd5w/nB8P7HZph6L1rogwLD+Y6Z2Fw
 byutgXn3sdQC6PcgHMETE9nJrSEtM4Qr1exKRcjqNwoKeDRGUePvfF4cLZRNDFqv48hd5DnPE
 MbyJn1Dj231ZuHCAC4EuGWWr3yCq4HW0UXcstN9pxZ+1FSjCPstbnOFUdzc0Vf0WIcvJHNC6D
 z9j8yhSgdWrwLsf+jqxF1t3WDsRiLlWvom7/OLdnxJMsydCuXIR//LyaeKbxWq10wHCcN60Y0
 QhZO4pllLWOtXP74ctcQ==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Wed, 02 Sep 2020 08:38:22 -0000

On Sep  2 10:30, Corinna Vinschen wrote:
> On Sep  1 18:19, Johannes Schindelin wrote:
> > When `LANG=en_US.UTF-8`, the detected `LCID` is 0x0409, which is
> > correct, but after that (at least if Pseudo Console support is enabled),
> > we try to find the default code page for that `LCID`, which is ASCII
> > (437). Subsequently, we set the Console output code page to that value,
> > completely ignoring that we wanted to use UTF-8.
> > 
> > Let's not ignore the specifically asked-for UTF-8 character set.
> > 
> > While at it, let's also set the Console output code page even if Pseudo
> > Console support is disabled; contrary to the behavior of v3.0.7, the
> > Console output code page is not ignored in that case.
> > 
> > The most common symptom would be that console applications which do not
> > specifically call `SetConsoleOutputCP()` but output UTF-8-encoded text
> > seem to be broken with v3.1.x when they worked plenty fine with v3.0.x.
> > 
> > This fixes https://github.com/msys2/MSYS2-packages/issues/1974,
> > https://github.com/msys2/MSYS2-packages/issues/2012,
> > https://github.com/rust-lang/cargo/issues/8369,
> > https://github.com/git-for-windows/git/issues/2734,
> > https://github.com/git-for-windows/git/issues/2793,
> > https://github.com/git-for-windows/git/issues/2792, and possibly quite a
> > few others.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  winsup/cygwin/fhandler_tty.cc | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> Ok guys, I'm not opposed to this change in terms of its result,
> but I'm starting to wonder why all this locale code in fhandler_tty
> is necessary at all.
> 
> I see that get_langinfo() calls __loadlocale and performs a lot of stuff
> on the charsets which looks like duplicates of the initial_setlocale()
> call performed at DLL startup.
> 
> If there's anything missing in the initial_setlocale() call which would
> be required by the pseudo tty code?  What exactly is it?  The codepage?
> And why can't we just add the info to cygheap->locale at initial_setlocale()
> time so it's available at exec time without going through all this hassle
> every time?
> 
> Apart from that, all this locale/charset/lcid stuff should be concentrated
> in nlsfunc.cc ideally.

get_locale_from_env() and get_langinfo() should go away.  If we just
need a codepage for get_ttyp ()->term_code_page, we should really find a
way to do this from within internal_setlocale().


Corinna
