Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 026C03857C56
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 08:40:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 026C03857C56
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M60HD-1kCZ2s2zkJ-007YbB for <cygwin-patches@cygwin.com>; Tue, 08 Sep 2020
 10:40:37 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CC245A83A97; Tue,  8 Sep 2020 10:40:34 +0200 (CEST)
Date: Tue, 8 Sep 2020 10:40:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200908084034.GO4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200904124400.GQ4127@calimero.vinschen.de>
 <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
 <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
 <20200905201506.8bbca09f51a2b2b06135affa@nifty.ne.jp>
 <20200905231516.c799225e61b2b96bf05f65a6@nifty.ne.jp>
 <20200906175703.5875d4dd6140d9f6812cf2a9@nifty.ne.jp>
 <20200906191530.32230a99bf23d3c6f21beb41@nifty.ne.jp>
 <20200907010413.53ef9a9b727e8f971ca6b2ea@nifty.ne.jp>
 <20200907134558.3e1cd8bd4070991b856f58bb@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907134558.3e1cd8bd4070991b856f58bb@nifty.ne.jp>
X-Provags-ID: V03:K1:ZZpIXAFV1pyevXEGctDaRqEPdB2emv5e3G0kgDgtq3leYND8ZV/
 /BBMiy2yvLBhyuorq1H5IhSFhyXUNfgJs0GT7ZgZBam7/VExPjRAqrXprhwf03flUrfa4fg
 EUqb3zUKCfQSwwKAUtDQSrPNgoqmXaXNnIbSvUfiPIH+EmAkfK3SB7Z5U5zJyIf5H6FFwDz
 LODFRCuC3cMpBxfVNCmMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rRE8DNJcvqA=:NqRuzCMA4Ovoja/psrbatX
 xqU0f5hEL4TbSMOLaJhAbVJqUfBzdxo8JtGXNXndxL26cSxP3tk+dAhI9jez8NM8FcQ/vXt8L
 aLZclGmA1FsJ6y3HM40Gm3gNcZwQhb8KqXFIGkq7u9PHtwEOenra4C88QzJsTQXuYAXNXUlRV
 SPFFQ8ICT/SfgyIts6jJ3i8riEaE7vHfk+/Hk1u/2uUYMCLuYAlA2cY+rZZTWoKw0jlr+T9cJ
 Je5FQGX5JtHSQ7AcWDqWlrxVzeZbMzrZi3jh84uZKv+ZN6aSd90XcuTTrqYFL1N3Hybu9yYbi
 BmkHjI7xBmwumNaoCwoL8E1DoZ+4nYX7SdBHeUaGMxGa05in5rA++q7YxhAr5rup00WtZePSG
 rLUTO41vlGCzJKU182BH+qOzKfanO9cAoKxWODUoPKjmVbJ0cgkOKVhEM+uShgpuxIga7rZG/
 s+xrLaI4xKXKBAJW8HKM36KVuSRPPOEQy2MHoQqsGQIgyEVhUW2eLUbUUuWz4H2HfefKksYfD
 vG461pukknpz7CXbZt/Xoj61SnBTAq3FLL1e8VVDyvsAnAQsZKLRcIbyali4rzlZnXtMRwGkn
 MkcGabGWlgPz/JKcmn11V16MX5JJa5/TNBYKqQYU1/2Rh3M3Bahx/INy3DrM2P1/WZ/acD4yV
 DzByLDZ3dBjR3SRGKzQZaSFrxu3v98CbJPu/ehyH356bAa0vWIfzKbGgnt2MOOW7eafiSgasi
 lPmIpu9NN+un2Nt5Z6tGa1nR2+SZhSPN61HuewcWAY6hoG2DJpLathWsn/7aXDGDDXvk9sxOJ
 dSJsePxwgh8r0eBBK+revM5h6maOzgIZijnspwYbpwAfatDObq56AjX0j+IDZX9M2GgaCF1ur
 tARfNt8T5VtnctRIohjw==
X-Spam-Status: No, score=-100.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 08 Sep 2020 08:40:40 -0000

On Sep  7 13:45, Takashi Yano via Cygwin-patches wrote:
> On Mon, 7 Sep 2020 01:04:13 +0900
> > > Chages:
> > > - If global locale is set, it takes precedence.
> > 
> > Changes:
> > - Use __get_current_locale() instead of __get_global_locale().
> > - Fix a bug for ISO-8859-* charset.
> 
> Changes:
> - Use envblock if it is passed to CreateProcess in spawn.cc.

For the time being and to make at least *some* progress and with my
upcoming "away from keyboard"-time , I pushed the gist of my patch,
replacing the locale evaluating code in fhandler_tty with the function
__eval_codepage_from_internal_charset in its most simple form.
I didn't touch anything else, given that this discussion is still
ongoing.


Corinna
