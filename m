Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id CEC00384640E
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 09:23:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CEC00384640E
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mc0Aj-1ko5Xs1Nwl-00dZ4V for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020
 11:23:03 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D3402A804E5; Fri, 11 Sep 2020 11:23:02 +0200 (CEST)
Date: Fri, 11 Sep 2020 11:23:02 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200911092302.GF4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200904190337.cde290e4b690793ef6a0f496@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009040822000.56@tvgsbejvaqbjf.bet>
 <20200905000302.9c777e3d2df4f49f3a641e42@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009072309070.56@tvgsbejvaqbjf.bet>
 <20200908171648.e65665caebb643ce99910fa3@nifty.ne.jp>
 <20200909072123.GX4127@calimero.vinschen.de>
 <20200910091500.388ab2f6796a4abce57a3cd2@nifty.ne.jp>
 <20200910213403.0e876be50bc2d1bbd2da0979@nifty.ne.jp>
 <20200911090547.GE4127@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911090547.GE4127@calimero.vinschen.de>
X-Provags-ID: V03:K1:o28q1wNM+/7L1aPyMndkx1bJn1N4CUo4nFzKG09BkhBVajXWub1
 libHuys9pNhyYo33iCZDsgs/XQZuGIxtJGtLUCboLauyKOoCYT/Z94TujcyZ3n+4ea2teHE
 5hpwu54ksK69pLp3xrZjkGdk0VCMO1RjIP7eVO4fAfhWeKdiyYLfE+DAiz8u+qfoG2CqsG5
 VLbscd1aVRHjXhjhLKv1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zv2Rfg0+lOk=:XWexhLAD1Q/JvnYlL2XaKC
 hQ6M2GgoFz8RFv0ssNMAFEHwJ3+8v6n+jUvrakbEDGmTSjUp3gSrOqDmafoPzBb9Ma7jZWYJV
 edAophHC73iAzOzlimzpEwTxYeXbFgmsiJG/vf2MQoBl2gFWMyvDqXZZouJ1Nr6vfvTYKmbJn
 BOhf5prZWslWrViTTtu66ENHsTE6zyz5Mz36xFLzq9miOGGC5qbf1lRbJKjaGfH8LCkYUP2Tn
 LpQhN5qfm268L/bqYkTzje8JnYdKPS9sxvDJ85utowHs7/iRES0sy5MwnRNUIDELh8B+ZzoHd
 lcuAl8afhv2tKbOLG5/xIO3XOUmw+aTk6yBj2w3j8W/4JxkHS40wTxS+/gWRuHIi21lLEMm8w
 lIJI2p7ae+hnQRS+mJ78iD+Mp9YOhhd5vcnNLwF20TfwFqR0tZTwRzNQPrzAuRqAYFajcMCJF
 46dzUPhe4Un9e81BBveNcxkMkGStCwVc9oS7gGUKy931lWuTMJyMfpVvJRMpPetsmB0oj3csE
 h6QjWRf0iutqV+jFIHjsmY4kLqBwYmoiAeOA0jo1jd0TSVlTYHDyF39lth5C8XzjtWPc8ryhk
 9J3Mwwxko+MMEOBnC1AcCiVJBAVt+M678ohDhy7m+BFm9k8fTlqUmXBaJdrNd0Snww5yTsDcb
 tV8mNS51C1WQzmtND6wg/EaxGs1FgCm/qAIggDK+k1NrRuFSdtMkM9ZBzhorOPWBUtgJaTJov
 ZnNM16af+hN5FEpARGWWpG2wYvJ1Xz2/F9EvklsIlC307rZkyLfQ8QgLwj/lTHtRI44kAD7ax
 Jbum0iQ6bHGFTtxVe+Z1PhOD6tgnQeP37n6bBu58BvUhspULpEYKsNDuTzR+nmRuY+40lZ7F3
 3G24pwOeTWcd5KNyc4Jw==
X-Spam-Status: No, score=-105.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 11 Sep 2020 09:23:06 -0000

On Sep 11 11:05, Corinna Vinschen wrote:
> On Sep 10 21:34, Takashi Yano via Cygwin-patches wrote:
> > On Thu, 10 Sep 2020 09:15:00 +0900
> > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > > I'd propose the patch:
> > > 
> > > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > > index 37d033bbe..95b28c3da 100644
> > > --- a/winsup/cygwin/fhandler_tty.cc
> > > +++ b/winsup/cygwin/fhandler_tty.cc
> > > @@ -1830,7 +1830,11 @@ fhandler_pty_slave::setup_locale (void)
> > >    extern UINT __eval_codepage_from_internal_charset ();
> > > 
> > >    if (!get_ttyp ()->term_code_page)
> > > -    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
> > > +    {
> > > +      get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
> > > +      SetConsoleCP (get_ttyp ()->term_code_page);
> > > +      SetConsoleOutputCP (get_ttyp ()->term_code_page);
> > > +    }
> > >  }
> > > 
> > >  void
> > > 
> > > However, Johannes insists setting codepage for non-cygwin apps
> > > even when pseudo console is enabled, which I cannot agree.
> > > 
> > > Actually, I hesitate even the patch above, however, it seems to
> > > be necessary for msys apps in terms of backward compatibility.
> > 
> > I found that output of Oracle java.exe and javac.exe are garbled
> > if the patch above is applied. This is because java.exe and javac.exe
> > output SJIS code unconditionally in my environment.
> > 
> > OTOH, rust-based program such as cargo and ripgrep output UTF-8
> > unconditionally. node.js also seems to output UTF-8 string by
> > default.
> > 
> > I think there is no way for both apps to work properly if pseudo
> > console is disabled. As far as I tested, both of them works when
> > pseudo console is enabled. IMHO, the best way to achieve maximum
> > compatibility, is enabling pseudo console, which is disabled in
> > MSYS2 by default.
> > 
> > As for the case with pseudo console disabled:
> > 
> > If backward compatibility is important, we should apply the patch
> > above. If compatibility with the behaviour in command prompt is
> > important, we should leave the codepage to the system default.
> 
> Pseudo console is probbaly the way to go in future anyway.  For
> older OSes and older apps, we might better opt for backward compat.
> I'll apply your patch for the time being.

Oh, right, can you please send it again in git style?


Thanks,
Corinna
