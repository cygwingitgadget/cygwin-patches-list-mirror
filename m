Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 4EB68385741D
 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021 20:40:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4EB68385741D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M1ZQT-1llkLD44wF-0036t1 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021
 22:40:25 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7C8DAA82BFD; Thu, 20 May 2021 22:40:24 +0200 (CEST)
Date: Thu, 20 May 2021 22:40:24 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: utils: chattr: Improve option parsing.
Message-ID: <YKbJOEBmYEkVsEk3@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <d515bfba-ce77-40c0-0c3e-67895675f753@t-online.de>
 <YKVPOaBrb0a9lV54@calimero.vinschen.de>
 <e78257d8-bd2a-3ea0-0cea-48114ec017a0@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e78257d8-bd2a-3ea0-0cea-48114ec017a0@t-online.de>
X-Provags-ID: V03:K1:4jhSyL0sfw+qaQ3b4hXSfch0eovXmUiWuyGJZQA4VjrM3unSPNA
 vPYZxlcoRQntmTeUuLRuBlSlJavfyoTtSJy0EAMqGizA6199djPsV0Mf2oUeE26KqsQPJaz
 g0K2qKlf/8vHqZqP2anG9FSLhS9R0Ya4PAq1Z0PVsqMSIn0oRx0B/cSTMkzchRmXlIJJe8+
 Y7d19yUF/QotH99UX0bIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IOskNSiCazo=:o5bD3dlWkDnsYrDfxPzbFy
 LtH1h8DivqQsWw+rFZ6a+bdlJXfGhSiTETz03B8RKXgLHmCEp0zqRv95Y8sc9qE2VFNGHe9DL
 sbIwEaOwTEQrk+OKkpb4mis0RGTfL8DGnjEggYbJwLDGh5yQbqfgnmtgJcpmUyb1ja2Aqq8GO
 KkeiZ/xaStHDaBYRBmNuadGL3/dmw+cd163OrLORvtsWF3pGT8QRzo6FjotCrLB2+hJlKWSKd
 S5PkAAqb1q3zu4+r6dI5heR02/eFxSZx2yGm+OTUzrRQn+EBADu73jS6g0V7MPGGlyRAlS/MB
 x7uCIwW72ybo3aFXjILrOfljgPE9K89DDqrHdixjZQ8UeGtkHS33orh89Y02zKouItHNgq3jG
 4p2gNsUDPZ2s49KAgvwOBM/e2A7j4/6tIVTyx8eWFNNJwEOupfV4vskezG83t27znqgOgDBPg
 c/Vr6owtwX8eS5a3ub6cqu9zEG+9wIowDR8fLvl39fFYC3wndyaDhnTh8ItDv4zOqQUrC+r40
 /txIfKtd5ra4eRhYBOSDds=
X-Spam-Status: No, score=-98.9 required=5.0 tests=BAYES_00, BODY_8BITS,
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
X-List-Received-Date: Thu, 20 May 2021 20:40:27 -0000

On May 20 12:01, Christian Franke wrote:
> Corinna Vinschen wrote:
> > Hi Christian,
> > 
> > On May 19 17:46, Christian Franke wrote:
> > > ...
> > > $ egrep 'ACL|--r' chattr.c
> > >            "Get POSIX ACL information\n"
> > >        "  -R, --recursive     recursively list attributes of directories and
> > > their \n"
> > Oops.  Please patch while you're at it...
> > ...
> > >  From 865a5a50501f3fd0cf5ed28500d3e6e45a6456de Mon Sep 17 00:00:00 2001
> > > From: Christian Franke<...>
> > > Date: Wed, 19 May 2021 16:24:47 +0200
> > > Subject: [PATCH] Cygwin: utils: chattr: Improve option parsing.
> > > 
> > > Interpret '-h' as '--help' only if last argument.
> > Who was the idiot using -h for help *and* the hidden flag? *blush*
> > 
> > I'd vote for --help to be changed to -H for the single character
> > option.  The help output is very unlikely to be used in scripts,
> > so that shouldn't be a backward compat problem.
> 
> New patch attached.
> 
> Note that there is now the possibly unexpected (& hidden) behavior that
> 'chattr -h' without file argument clears the hidden attribute of cwd.
> 
> Regards,
> Christian
> 

> From b838125f797c123d4a6d2f0ef30cccee8face50c Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Thu, 20 May 2021 11:05:29 +0200
> Subject: [PATCH] Cygwin: utils: chattr: Improve option parsing, fix some
>  messages.
> 
> Allow multiple characters also in first '-mode' argument.
> Use '-H' instead of '-h' for '--help' to fix ambiguity with
> hidden attribute.  Fix help and usage texts and documentation.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/doc/utils.xml  | 10 +++++-----
>  winsup/utils/chattr.c | 32 ++++++++++++++------------------
>  2 files changed, 19 insertions(+), 23 deletions(-)

Pushed.


Thanks,
Corinna

