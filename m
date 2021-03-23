Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id C6014385701F
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 12:46:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C6014385701F
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N17l4-1lnCMf2Pda-012ZtP for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021
 13:46:23 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id BACA0A80DBA; Tue, 23 Mar 2021 13:46:22 +0100 (CET)
Date: Tue, 23 Mar 2021 13:46:22 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-ID: <YFnjHjNX6xyF2xEl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
 <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
 <YFncTItWHhMlNH5Y@calimero.vinschen.de>
 <20210323213212.d2c5a9e7db7a508260693998@nifty.ne.jp>
 <20210323214206.ebb5b1cb80a8b71ead4e8cda@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323214206.ebb5b1cb80a8b71ead4e8cda@nifty.ne.jp>
X-Provags-ID: V03:K1:NG2jH92hl9H8LKLmHYkhHHj3Z7tiWd9dGJc/YIcEXRH9i9VnmM+
 R28BhNxIetexSiymg4hdGP6XGxvYh0YYP8f1w4CWYZ22haIsz+NQn4zUNsEYVFhJjv+kcD+
 fR/yVGQ2t5NadMFVDOBdCApE0RngY83wB/jdVeFzWGMgQGQwJt+Rgyaykg74S5oWuiPrwGg
 d3t5qPrRAOoqgfSRMSxvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FTJ8xeQgLKg=:/WOIrETOSCr6dz/2zSN3rD
 HD/LEn2nv92zzucfT26eIvsSKRSmGAFkDzZ5XqUNIEaEyEQ5VfvEnLKGUEpJ0TqmCGq3dYNKv
 txo6PU1U9KGNnmbFwyWkGRWlijya3Av3JM9GuRpCHDY4o5mOFHBLzHOwktTqCrbXuWXwMB5Wa
 fDtn6aAb/6SSbxusJ8h2dhJ4Ry39douanFEYoGI86cOu7DpNeccc4QBFj5/kT9Of1QBNCI21p
 1NzvRl4erjlOi448/mqCtGBxvQtW/drzi0woIWVdt+YmACDlTjKoZXQlxQsNiMuE5/ac6J99l
 6IJzi4V6hMLMyS95pBEVyi1yzPqnFpkm9Anai/eSUC8zDmTPt3ol0Ig/1nkIYkCv9/u6IUyEq
 MOG5OVpGeTbOEqaltuqzm6WVPikfNIU0EGLUWqLiSXUVZATfds2ulYQJtj3CCKfBZiJhuW7ao
 2dmHHX8CtA==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 23 Mar 2021 12:46:26 -0000

On Mar 23 21:42, Takashi Yano via Cygwin-patches wrote:
> On Tue, 23 Mar 2021 21:32:12 +0900
> Takashi Yano wrote:
> > I try to check run.exe behaviour and noticed that
> > run cmd.exe
> > and
> > run cat.exe
> > does not work with cygwin 3.0.7 and 3.2.0 (TEST) while these
> > work in 3.1.7.
> 
> In obove cases, cmd.exe and cat.exe is running in *hidden* console,
> therefore nothing is shown. Right?

Yes, that's it.  In my other reply I wrote something about running
without console, but in fact that's running without *visible* console,
so, yeah, setting up the hidden console is it's task.


Corinna
