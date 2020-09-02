Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 513F5384C004
 for <cygwin-patches@cygwin.com>; Wed,  2 Sep 2020 08:30:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 513F5384C004
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M3lgJ-1kCZD23OVv-000skR for <cygwin-patches@cygwin.com>; Wed, 02 Sep 2020
 10:30:15 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 0ABEFA81009; Wed,  2 Sep 2020 10:30:14 +0200 (CEST)
Date: Wed, 2 Sep 2020 10:30:14 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200902083014.GH4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:lDioc3rcBJTFU/Wo3/oPtK0XvPJeCW/D5r2LvdINUs+Wn7U/mgV
 aRqAS3duEebVkxVooh/OD8xmKakdA5guUwkygurqyAkxaeo9/vyefG7P3p9lQyVpb8mXrPJ
 sGT9WU+ZozjjfwEHqywOvnqvMPryhi8woe+LemHau0R9KOxntXbXHy+e0e+AjyFmsXpF8Lk
 c5s9t00lcPKRpbA08q1Uw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BiZ4MTZNGZg=:m9pQ/FuM4JLzlXoNfEGaHF
 5T59BL2hqoz2q5vbHEeKsG2OckFf8tIXvUvmlGKQ7o+RIXJKB/UcHdGt1MMvG7E7QJmux9fPx
 wnF5vXS/oEutjeKv2XNxcjmHJ5l7t9n701Qlf8t8YqtqTD9SnNob7cIFmVMU+hbVR7iGYz/le
 ukY/HoqGvHu+t7ps197dZxhMbFVG7eugoQhAPmpHeiSbZs4G8Oj5Izmd2nhwp3KcxAI+W2bsW
 gDoil/XvnnIYtiuD1GbYRBC+m36BSloboMLKWKKblzHFZMsZPcZ5kxEsvlApxC0kuWxS+dDDq
 D+9KQqz7SnIUSWY+kZu21Go7D729RYv9f28ju/CZo2mKN2XQQBNVuUaTmZfubLe+SD12wJ5lk
 CWGIByH6ohyLaDtIBpZKgZSPHf5dvdJIhjtsBnXqzATUEp53ngMmRQ9B8lHZgiN2WQ9s0zyC3
 OWA4aailjK7AoUZs0f+ClzgIZo0ZCt90i4DeC7asDvw6pW2lqyNR/4rkogrXOg1OcisTRxc22
 SijEn+vI5YNQer+2b+yBNHZb2MkU69kES3adu16Xjd1ingEvZ8dNnwOcnYCH/6C/lxQGwME74
 V/EpS84NNTxdLWQcLma7AVfmxxtJcJE1v79VFl0ec8OvqH7UQX4Q1B9w7z1iF0dWlLRSViP8H
 6DYT1q1gCse4o7uK/xAy6lSs/ZqSN85i1mnOcxY0UR7hMtUzJF+q1UDauJfHmjJuTdUyoR/ts
 nQ3Fk0JdtGv9lv3FhNCUX2S7XBXo66R0/S0CM30DkZ0XKu2gEpttLPNAOcPrw+6GDZeox2lNs
 bEpKVjbqEKnS/S51EZHBEL4954ZG5QpLTJwvBQVMTaCJN1zoSlxu5htJIIdENbfRiyDIcag5t
 79mQ1PjjXuqA7OiG5Eaw==
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
X-List-Received-Date: Wed, 02 Sep 2020 08:30:19 -0000

On Sep  1 18:19, Johannes Schindelin wrote:
> When `LANG=en_US.UTF-8`, the detected `LCID` is 0x0409, which is
> correct, but after that (at least if Pseudo Console support is enabled),
> we try to find the default code page for that `LCID`, which is ASCII
> (437). Subsequently, we set the Console output code page to that value,
> completely ignoring that we wanted to use UTF-8.
> 
> Let's not ignore the specifically asked-for UTF-8 character set.
> 
> While at it, let's also set the Console output code page even if Pseudo
> Console support is disabled; contrary to the behavior of v3.0.7, the
> Console output code page is not ignored in that case.
> 
> The most common symptom would be that console applications which do not
> specifically call `SetConsoleOutputCP()` but output UTF-8-encoded text
> seem to be broken with v3.1.x when they worked plenty fine with v3.0.x.
> 
> This fixes https://github.com/msys2/MSYS2-packages/issues/1974,
> https://github.com/msys2/MSYS2-packages/issues/2012,
> https://github.com/rust-lang/cargo/issues/8369,
> https://github.com/git-for-windows/git/issues/2734,
> https://github.com/git-for-windows/git/issues/2793,
> https://github.com/git-for-windows/git/issues/2792, and possibly quite a
> few others.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler_tty.cc | 9 +++++++++
>  1 file changed, 9 insertions(+)

Ok guys, I'm not opposed to this change in terms of its result,
but I'm starting to wonder why all this locale code in fhandler_tty
is necessary at all.

I see that get_langinfo() calls __loadlocale and performs a lot of stuff
on the charsets which looks like duplicates of the initial_setlocale()
call performed at DLL startup.

If there's anything missing in the initial_setlocale() call which would
be required by the pseudo tty code?  What exactly is it?  The codepage?
And why can't we just add the info to cygheap->locale at initial_setlocale()
time so it's available at exec time without going through all this hassle
every time?

Apart from that, all this locale/charset/lcid stuff should be concentrated
in nlsfunc.cc ideally.


Thanks,
Corinna
