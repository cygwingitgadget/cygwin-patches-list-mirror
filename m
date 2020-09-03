Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 32065385043D
 for <cygwin-patches@cygwin.com>; Thu,  3 Sep 2020 17:59:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 32065385043D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N3Kc8-1kf0lu2OZO-010KfV for <cygwin-patches@cygwin.com>; Thu, 03 Sep 2020
 19:59:12 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1BACFA83A7D; Thu,  3 Sep 2020 19:59:12 +0200 (CEST)
Date: Thu, 3 Sep 2020 19:59:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200903175912.GP4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902083818.GI4127@calimero.vinschen.de>
 <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902163836.GL4127@calimero.vinschen.de>
X-Provags-ID: V03:K1:xtyKf+ljLkr6ZJOebEBdZ8bqjeXfnEAkbn7u+/otviYK9LhGZ7L
 SwZrJON2xdLJcKVQFaTiKrmyaiQziKG9Xr2wNtRymKeIp+neRmQ4uLJ9Kbrv6OS2uWZucB9
 r2CI/eW6pGiYPOMCBxrpozHkQawum5ROQ2QOjhmYzNxIyM1fs6wXUuXvkUH1u32Q6yY+jnR
 VikAH1wD9gZceL4paQiaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SxdhjPelzWA=:W4LdlAUw7g83rm6n4GQa9P
 S0P0tk63pUoEe29efeR7a9TTmBIRYEfdc3Z9DN6BlZG2e1CpwtQ6Lz4gJjvqzAC3SK9+amwpk
 J7eMvM2/gWCX4syD1dAlvYoSMbP+VMVz6uqpGnx6YDWfnk8LaDiZbJ1DrJWzit2wVQ5dRi6t8
 E5KuvNIHbrzXjGkwnqP7JoBwFSyjbvIlOXkh1onRLf8E+6EAg7KEPokKHTNfb1R4rDA5KNkKY
 BcO2gqhCkvOfOf+6NowcMs6Cv+qNKrmmKNUzdwdXfMLRuM5309YWAhqjYC9d9HhRjZKSadcmq
 5HUk3djEJmEuA/2iNBrmGphRs3pQFF5heCoK7kDyunuKF8bW39VD7TVX7f0vgNb203Mgz8NPf
 dRSbn1lV8a2xWve4iJdIpBstuXoJ2HCijkG2SU7AiWZmah6z+pHIufjsMHxD/z2NZj2M1djQW
 9Nl2foQwEuBOfmBpUm34k8WAlea60uuaUxnjtUZh9Xk7tLD2MsWtHTpQPaq0NPpZPycsyqSXM
 VKYWpGQ8Py/EdHrwdypTRcFWkqt8feU1RsUDoZYtFvopuEG4mnSdSIIcrsoyCE1hpbPtY5TnO
 zXeiY276BMmVz8bsSrA3eGhA2oPvPAv9Sa775nbHYkeiqBY/EGBG5U4D1Zf//BlNDBLArO18U
 jWinqz1YZBCz4jkUWV1d5Egb3KfOxxBU+GQB6W0RDDbw6c41Rr1i3FpVbcT4ff0QYhFcL34Xi
 JmHkonxJHgQV3aFtQbJ1Y6moxOHTjp3wkF+Pk8KK/9VPgUpliu15tSYTUTNdTjKCQIWwzscND
 Cn9G+xahGoDVke41EFOQF12TdjDrWUbEBnqaiG49klgD3t/SJLTviqesAd+nSZPbnDieq8ZWv
 8dledj2IuwRimtbswgzw==
X-Spam-Status: No, score=-100.2 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Thu, 03 Sep 2020 17:59:15 -0000

On Sep  2 18:38, Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Sep  3 01:25, Takashi Yano via Cygwin-patches wrote:
> > Hi Corinna,
> > 
> > On Wed, 2 Sep 2020 17:24:50 +0200
> > Corinna Vinschen  wrote:
> > > > > get_locale_from_env() and get_langinfo() should go away.  If we just
> > > > > need a codepage for get_ttyp ()->term_code_page, we should really find a
> > > > > way to do this from within internal_setlocale().
> > > > 
> > > > I looked into internal_setlocale() code, but I could not found
> > > > the code which handles thecode page. I found the code handling
> > > > the code page in __set_charset_from_locale() function in nlsfuncs.cc,
> > > > but it does not return code page itself. Could you please explain
> > > > more detail of your idea?
> > > 
> > > I had none yet :)  I was just musing, without actually thinking about a
> > > solution.  But I think this isn't very complicated.  Given this is
> > > inside Cygwin, nothing keeps the function to have a well-defined
> > > side-effect, as in setting a (not yet existing) member "term_code_page"
> > > of cygheap->locale.
> > > 
> > > Kind of like this:
> > > [...]
> > I have tried your code, however, it does not work as expected.
> > It seems that __set_charset_from_locale() is not called.
> > cygheap->locale.term_code_page is always 0.
> 
> Ah, right!  Take a look into newlib/libc/locale/locale.c, function
> __loadlocale().  This function is called from _setlocale_r().  However,
> it calls __set_charset_from_locale() *only* if the charset isn't already
> given explicitely in the LC_* or LANG string, because otherwise we
> already know the charset, after all.
> 
> Darn!  That foils my plans for world domination...
> 
> > Let me consider a while.
> 
> Thanks, I'll do the same.  I'd really like to simplify this stuff
> and doing the locale shuffle in two entirely different locations
> at different times is prone to getting out of sync.

The only idea I had so far was, changing the way __set_charset_from_locale
works from within _setlocale_r:

We could add a Cygwin-specific function only fetching the codepage and
call it unconditionally from _setlocale_r.  __set_charset_from_locale is
called with a new parameter "codepage", so it doesn't have to fetch the
CP by itself, but it's still only called from _setlocale_r if necessary.

Would that be sufficient?  The CP conversion from 20127/ASCII to 65001/UTF8
could be done at the point the codepage is actually required.


Corinna
