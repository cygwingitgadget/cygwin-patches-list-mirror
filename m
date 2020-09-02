Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 618E6384A40A
 for <cygwin-patches@cygwin.com>; Wed,  2 Sep 2020 16:09:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 618E6384A40A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MPGBR-1jwgrz45ID-00PcZ3 for <cygwin-patches@cygwin.com>; Wed, 02 Sep 2020
 18:09:43 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 628BAA80D14; Wed,  2 Sep 2020 18:09:41 +0200 (CEST)
Date: Wed, 2 Sep 2020 18:09:41 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200902160941.GK4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902083818.GI4127@calimero.vinschen.de>
 <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902152450.GJ4127@calimero.vinschen.de>
X-Provags-ID: V03:K1:cGv3sE9Pe95JmrczDi20mY8EFbH0WuWaApOWwDtxYJU+QA3NcEI
 6vAXV30pEOuWKGnSWOqtKsy9VwFOq+EVcd+wQtvQEQMl9is6R5tn4prcJ1C5b8MYO++Xi8t
 2rfwlXU19mZfIVhk5zGSxeBBjm48kMeTeTNtWFZXc/8OB+41JocDTgVIWAeiYupgfexEFaa
 nWibMbczLv0UIWioNjT5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I1utxGPpiN0=:r17W77CGJ6tHxI16jB6RYt
 A8ju+MUuFgKNjdp+TNjF2ZLn0T4Zhj5XA/ERcAah4UkQOlkAh4xwollSVWr4uBsKm4jwvNeGF
 NWBSPIIGJ4Sz6UWuWIrO2xBfgtHiu4oCTLg/oPnwP1EXxVmtTWoFpHsAZLDiA9mjO4ZXwtaWt
 GIgAZRHF4HlQyAju7oAzgwwYaYRBEMEtWLJtkYEnkyK5F31rnEhKlh7KIIqPoJvNTPYerRMsq
 aqD5dRBbZ4yQYAK13LY/O5F7SBz6yCzhNBcgw5jSTBOBKJ5PjZSpjWHayJ/KlgoIbaiokYtdJ
 2Y5YkKwqATnMr4ykntBz1RMHOBteKohzASNSda7wXZxhUilMI6stlNAvt8rn19EWkqKFmZodI
 z+mW05/plTRNrzvVNhq0GeSgkmgekzFOSRjRdd8DIKIzsxwahf4RfvYw2onn8TKJ7i73OPJfz
 k7nT47qJ644rcEBMRgRTvOKgv0H47ILxs0Zu6BCvUzpibvohZ2BWNMkygLamUtq8MTeN8GsII
 3bP0MFf+22QaSJ+Y2vFzNWgUCzQP7KslC/Ik1JHFLbu1m0KUtkHPTq/KAj8OxvS4rES43w8L7
 02lXSpoBs4O/WPCMLDexlFeqtHImV8D1GDfikCEPm+2WnWDQEHm86dCMEHITZ/EQ5Mv+5oMzo
 plnRHSYTEtfPxUwMEkLQcjkMl61wdzLPIJlHwMGvB9dSjR6wsEOIhMGcpjrSu73h4nEpjSBuA
 I2BDWSjTdS3TsuxrTGYJA21mDOs6uWlhTLL6q2C1hQjNu95PNEJdfuuavOKZRmIZUn0LGMgCl
 p8l0Q8xK6vYITYkmwHtpUUrkPVWWXrNMkCUSeZh50N0k2LpFNv5k6PaBY/00vlwlpvp2tabry
 IdQGyIWFpueEkxLm5ajw==
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
X-List-Received-Date: Wed, 02 Sep 2020 16:09:46 -0000

On Sep  2 17:24, Corinna Vinschen wrote:
> On Sep  2 19:54, Takashi Yano via Cygwin-patches wrote:
> > Hi Corinna,
> > 
> > On Wed, 2 Sep 2020 10:38:18 +0200
> > Corinna Vinschen wrote:
> > > On Sep  2 10:30, Corinna Vinschen wrote:
> > > > Ok guys, I'm not opposed to this change in terms of its result,
> > > > but I'm starting to wonder why all this locale code in fhandler_tty
> > > > is necessary at all.
> > > > 
> > > > I see that get_langinfo() calls __loadlocale and performs a lot of stuff
> > > > on the charsets which looks like duplicates of the initial_setlocale()
> > > > call performed at DLL startup.
> > > > 
> > > > If there's anything missing in the initial_setlocale() call which would
> > > > be required by the pseudo tty code?  What exactly is it?  The codepage?
> > > > And why can't we just add the info to cygheap->locale at initial_setlocale()
> > > > time so it's available at exec time without going through all this hassle
> > > > every time?
> > > > 
> > > > Apart from that, all this locale/charset/lcid stuff should be concentrated
> > > > in nlsfunc.cc ideally.
> > > 
> > > get_locale_from_env() and get_langinfo() should go away.  If we just
> > > need a codepage for get_ttyp ()->term_code_page, we should really find a
> > > way to do this from within internal_setlocale().
> > 
> > I looked into internal_setlocale() code, but I could not found
> > the code which handles thecode page. I found the code handling
> > the code page in __set_charset_from_locale() function in nlsfuncs.cc,
> > but it does not return code page itself. Could you please explain
> > more detail of your idea?
> 
> I had none yet :)  I was just musing, without actually thinking about a
> solution.  But I think this isn't very complicated.  Given this is
> inside Cygwin, nothing keeps the function to have a well-defined
> side-effect, as in setting a (not yet existing) member "term_code_page"
> of cygheap->locale.
> 
> Kind of like this:

Actually, this is a bit too simple, but you get the idea.  We need to
align the terminal codepage with the actual Cygwin charset, along the
lines of what your setup_locale is doing standalone yet.  Except in case
of ASCII, where we default to UTF-8 internally.  The important part here
is that we do this once, and that we don't have unnecessary code
duplication.


Corinna
