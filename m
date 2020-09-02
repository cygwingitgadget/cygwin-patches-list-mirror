Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id C4156384A40A
 for <cygwin-patches@cygwin.com>; Wed,  2 Sep 2020 15:24:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C4156384A40A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MZCSt-1k8pn81QGn-00V8kh for <cygwin-patches@cygwin.com>; Wed, 02 Sep 2020
 17:24:51 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id BD777A80D14; Wed,  2 Sep 2020 17:24:50 +0200 (CEST)
Date: Wed, 2 Sep 2020 17:24:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200902152450.GJ4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902083818.GI4127@calimero.vinschen.de>
 <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
X-Provags-ID: V03:K1:2OyCmmUZifjgtC+maGqsjaid9zEjRnFxDz6XAxeD86noFfgZFoD
 a2sJYGpCQyGpGQVomjd55hGBqGhhTasCq+A/0B+Zh3ll1QJV661qFAnh14ZSxqixJedRZ/O
 X2Z9KWUarRIRh1XpeRMPPN31rbyDUJtKvqhyP9mxxqNhRtoXXRKiqa3x6EpDHCpFiSxdn3i
 ilZZ6NqUNwJrHiYT8FivA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eAaw+Rbucsg=:aD/dosyIpx3jNGL0kgC6Yb
 fLdaFYAiBLn6Q9g3t6IYxEkkDCjvIgrszY1iTXrwSLNqg9NKBedy5hgpujRTajyAc0hnBX3rv
 BMxMPG9/KxcUys3YynTZzGsXvsf00UuuSq6vVbE1C+JqpaACkAcSDvAVZkUQvdgn7/jP/LMF2
 CryZAQfWp9XgrpezaV7vErdv8oaD6V+B4et/kqJdQ0YMU/tww1lQa28eeNIRJyHwu5Ufsfc6M
 jpRUvlIyWnlUmM5nbQGuUYVP6g6lBby+/UNvtIVoHncqZc9M8N96W4V89ZL3Kd3IZMQ6nQzXt
 3qWAVtXSuEbet6PaL+KQ92ZSNhnqxIUd6FsxZ19WWRHzgAtdBVBqGRmyoD2eQQLbGmX5x0hop
 JLtyR/NPUYjlQ6dV0rs7s9rXD7lQIr2J+GdqMcw6NEwuYzaP48eOWWL2+biCQjAEW2Gifjos1
 JEPeeJIZSFYoQaw4KjMNvSQvawqRJA7FBrrlSPZw73r/7CH4dMZzFhwwBiu43tRmQeIfEr5nm
 X6qhCf9c+dCmv6cyG5zFruBWiH7g9shAwZmAiI2eztSgvCT/CK/NkDykmsUqb20ygDxUQ1Pmt
 n9RO2dxNQJt0vZqf0nJKrFKImsAVfuwK398qzaf4guWUGD2Sc8R82y5Sj3jyy8nBzNB8fFrSZ
 kMJVV5iDx8XB+ApTfOKJXfZtEsXiYZZpm5msGYkQWW462e6Fpjp/lO/OcHF1KkYS2bLex/DMK
 u9uBpbeeZ6rabh2h6lj2odfQWozNJlZh/xuHvE6PiUWwObrUcXqGGJfT9ro+kUWzUdAvYHN5L
 l/ef6G1uYIzQNfyzfHCWZtRZxNc9/b4xfwgHSJ65ZNfnmPWZIinDAjpfAJa2HvtE+YdFgL46q
 0Zt0qV0RPGK72Hlx/PYw==
X-Spam-Status: No, score=-105.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Wed, 02 Sep 2020 15:24:54 -0000

On Sep  2 19:54, Takashi Yano via Cygwin-patches wrote:
> Hi Corinna,
> 
> On Wed, 2 Sep 2020 10:38:18 +0200
> Corinna Vinschen wrote:
> > On Sep  2 10:30, Corinna Vinschen wrote:
> > > Ok guys, I'm not opposed to this change in terms of its result,
> > > but I'm starting to wonder why all this locale code in fhandler_tty
> > > is necessary at all.
> > > 
> > > I see that get_langinfo() calls __loadlocale and performs a lot of stuff
> > > on the charsets which looks like duplicates of the initial_setlocale()
> > > call performed at DLL startup.
> > > 
> > > If there's anything missing in the initial_setlocale() call which would
> > > be required by the pseudo tty code?  What exactly is it?  The codepage?
> > > And why can't we just add the info to cygheap->locale at initial_setlocale()
> > > time so it's available at exec time without going through all this hassle
> > > every time?
> > > 
> > > Apart from that, all this locale/charset/lcid stuff should be concentrated
> > > in nlsfunc.cc ideally.
> > 
> > get_locale_from_env() and get_langinfo() should go away.  If we just
> > need a codepage for get_ttyp ()->term_code_page, we should really find a
> > way to do this from within internal_setlocale().
> 
> I looked into internal_setlocale() code, but I could not found
> the code which handles thecode page. I found the code handling
> the code page in __set_charset_from_locale() function in nlsfuncs.cc,
> but it does not return code page itself. Could you please explain
> more detail of your idea?

I had none yet :)  I was just musing, without actually thinking about a
solution.  But I think this isn't very complicated.  Given this is
inside Cygwin, nothing keeps the function to have a well-defined
side-effect, as in setting a (not yet existing) member "term_code_page"
of cygheap->locale.

Kind of like this:

diff --git a/winsup/cygwin/cygheap.h b/winsup/cygwin/cygheap.h
index 8877cc358c39..2b84f4252071 100644
--- a/winsup/cygwin/cygheap.h
+++ b/winsup/cygwin/cygheap.h
@@ -341,6 +341,7 @@ struct cygheap_debug
 struct cygheap_locale
 {
   mbtowc_p mbtowc;
+  UINT term_code_page;
 };
 
 struct user_heap_info
diff --git a/winsup/cygwin/nlsfuncs.cc b/winsup/cygwin/nlsfuncs.cc
index 668d7eb9e778..752f4239d911 100644
--- a/winsup/cygwin/nlsfuncs.cc
+++ b/winsup/cygwin/nlsfuncs.cc
@@ -1298,6 +1298,9 @@ __set_charset_from_locale (const char *locale, char *charset)
 			    LOCALE_IDEFAULTANSICODEPAGE | LOCALE_RETURN_NUMBER,
 			    (PWCHAR) &cp, sizeof cp))
     cp = 0;
+  /* Store codepage in cygheap->locale so fhandler_tty can switch the
+     pseudo console to the correct codepage. */
+  cygheap->locale.term_code_page = cp ?: CP_UTF8;
   /* Translate codepage and lcid to a charset closely aligned with the default
      charsets defined in Glibc. */
   const char *cs;

Make sense?


Thanks,
Corinna
