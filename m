Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 30A933857C62
 for <cygwin-patches@cygwin.com>; Wed,  2 Sep 2020 16:38:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 30A933857C62
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MIdaF-1kPOQN2ae5-00EfVJ for <cygwin-patches@cygwin.com>; Wed, 02 Sep 2020
 18:38:38 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CC4A0A80D14; Wed,  2 Sep 2020 18:38:36 +0200 (CEST)
Date: Wed, 2 Sep 2020 18:38:36 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200902163836.GL4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902083818.GI4127@calimero.vinschen.de>
 <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
X-Provags-ID: V03:K1:tMr7L5z+bEhfwhlcgtutm4d74++tKjwcn2k8kG3Ag+5RFTRxwYf
 fflUnVGih+14dxfaO65bkgFbOARKsyZL494zsB2/MUP5i1R6ouJ6ZdPAqgAsryt9HmxRR+z
 jQBt/dFMjn34RWTgdFZXJWWFa37rn1j7B52v7HKzNZzb79ADYjFO7qiUMu6/1heSYbfkNAx
 Add7m1XJd9EraSXykGpcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ou++CAIqutM=:JmmsLGAVrgGKvu+PDrSGu4
 C8s6QlZnintJKQtO1bmi+DRx9feh3oXMKjPE+nuywBUG3JwUPFZOx0l7hYIyUwPyCS60hpUm9
 C0egRphLN11QudCJ8/WRc6VijmBwzBfC9iIQwyFNxWXfar+oDVoHO+QaXkoetm82+b7hx7S2y
 XwD1LPCILstBm4RzotTaIiMiU7LjXSByyovltxx9JrVvt1RHANJkQ+UJlEAP47dE+/b/pHPKE
 vRCaa4DoeBMheN8TjzzUA3N67jzX/8w6soIWB4zLL7ugzL0tmGogH6KL1O2p0CZgONrk1ymx6
 99yRoy9mBGqIPYwfpQTsngyM6hWdpkLzxFRH9QX9KQI2mvgTIAEllb0oWYmS+7GnBb2fiV1jf
 GXiiW+nBAw2mTwU/RHni3Fmbo69y9rawp05MyzpBNjI7SDyDXrHq4NhzqkDaKwf8fXcCmRO8A
 Zvoljj/y6qiU2SWzI6cm3wCgsijkroGf7Ck2gCOitQv+ZNIgbE53rcqarLy1TqfTfYE17NMkz
 ououoq9ZOUfIzkFgHe6aSndvfJZvA++oEnzhoMIue4Uof0O/J/0QU8df7CvkAhrqEai3fnjrJ
 J71LP8dAgBdjq2YrXa/GNJOXQpPoCETvbWKwOz2Rb2qHPCfDEek90rA4klXBpHIJfksVdbCse
 X4VZgSw82KT/OfXrKAESzchO+2V/OE3mpNl27IMnLq4ZIQa0mYAkVwX6QV235Air9uXTUz7Vu
 x0+mJ/6HkQwP0UNJOSLN9zz7iTergfIsRi84eSUBHI+V9SIg2cYOmtGvYmgfYCQk58ke1jCAY
 sNbR/TzuWoK8siUpkAyrTDB+0yiaQkokMhaQbGYeHQSSLY93NnBPnnmIpFboUfRCHBcfu+T8T
 ZBot2jDzDirZOqWxVP2w==
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
X-List-Received-Date: Wed, 02 Sep 2020 16:38:42 -0000

Hi Takashi,

On Sep  3 01:25, Takashi Yano via Cygwin-patches wrote:
> Hi Corinna,
> 
> On Wed, 2 Sep 2020 17:24:50 +0200
> Corinna Vinschen  wrote:
> > > > get_locale_from_env() and get_langinfo() should go away.  If we just
> > > > need a codepage for get_ttyp ()->term_code_page, we should really find a
> > > > way to do this from within internal_setlocale().
> > > 
> > > I looked into internal_setlocale() code, but I could not found
> > > the code which handles thecode page. I found the code handling
> > > the code page in __set_charset_from_locale() function in nlsfuncs.cc,
> > > but it does not return code page itself. Could you please explain
> > > more detail of your idea?
> > 
> > I had none yet :)  I was just musing, without actually thinking about a
> > solution.  But I think this isn't very complicated.  Given this is
> > inside Cygwin, nothing keeps the function to have a well-defined
> > side-effect, as in setting a (not yet existing) member "term_code_page"
> > of cygheap->locale.
> > 
> > Kind of like this:
> > [...]
> I have tried your code, however, it does not work as expected.
> It seems that __set_charset_from_locale() is not called.
> cygheap->locale.term_code_page is always 0.

Ah, right!  Take a look into newlib/libc/locale/locale.c, function
__loadlocale().  This function is called from _setlocale_r().  However,
it calls __set_charset_from_locale() *only* if the charset isn't already
given explicitely in the LC_* or LANG string, because otherwise we
already know the charset, after all.

Darn!  That foils my plans for world domination...

> Let me consider a while.

Thanks, I'll do the same.  I'd really like to simplify this stuff
and doing the locale shuffle in two entirely different locations
at different times is prone to getting out of sync.


Corinna
