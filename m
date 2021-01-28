Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 8D169398E413
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 10:14:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8D169398E413
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MpUEO-1llrnm1BRE-00ps1L for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021
 11:14:30 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B234DA80D85; Thu, 28 Jan 2021 11:14:29 +0100 (CET)
Date: Thu, 28 Jan 2021 11:14:29 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_serial.cc: MARK and SPACE parity for serial port
Message-ID: <20210128101429.GX4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGEXLhUUtV-kKxO-jQo4427R=N=Uo1aT_LrHGpc1r55umbb92w@mail.gmail.com>
 <20210128100802.GW4393@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128100802.GW4393@calimero.vinschen.de>
X-Provags-ID: V03:K1:gKJWDQePowx5cOszg56r/I1MLLt6cgqqwCuFInxtdQWw48zx9qN
 jDMsnazWRwkFhLFgpwooKBc+7dYtk3eAoVSqCopFliFSq/dAajg9vJnGT9b6eH/6qpzGGn0
 z8P0HiQLXNe79ZFnleI0EQtqUAGYzPWe3duhmhNSL1rD4J2iMx7uLtPWJ42nqnt/Wnp56RG
 8hHJay7u92ORYX8dHqfOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9QvJeySVTiQ=:KPoL2v7jfuxpk2i++w3aLP
 Up8GogAWObNO8lN4cDEaqh5U11LWPg82kSbFT9nFHYyPjzrOPg27tdJfvJNpNptmLs0PFXeu6
 twMawAE0dX0+/m2P07eJwoU+ea6sKADKV08HxZFpKLIPMCGCVjWSODKKEAM3M+OnVm9rLwPmi
 G9zywi9ERO9lDfKFU5090d2qpd3WM3TVd6deYMDC/FNiUYk8EGSKdBxXWPQSkjBU45mxVqpMM
 j57Ax2uWtGhSfXZ4xsLRDhPiux1at6GPWhIYpZj8gKdwJaHo+69rbsBNpLZ5cclhcK7Iq7tIA
 B/XVTH9RCaFB9RxrJD0Xm+R6HnEEQ9elGRlsmSXbBkZueZDML0m/7ikSS0ksIY6OWKvWDarj+
 PpxnfuBGb29J1IAyL8xQgbze2QJmEDRmD9P5/AH6Au3Yu41eDzK1mhsV4zfMyHeh+4W6SUg4p
 FnV89UYgOA==
X-Spam-Status: No, score=-101.2 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Thu, 28 Jan 2021 10:14:33 -0000

Oh, btw...

On Jan 28 11:08, Corinna Vinschen via Cygwin-patches wrote:
> Hi Marek,
> 
> thanks for the patch.  [...]
> > index 17e8d83a3..933851c21 100644
> > --- a/winsup/cygwin/include/sys/termios.h
> > +++ b/winsup/cygwin/include/sys/termios.h
> > @@ -185,6 +185,7 @@ POSIX commands */
> >  #define PARODD 0x00200
> >  #define HUPCL 0x00400
> >  #define CLOCAL 0x00800
> > +#define CMSPAR  0x40000000 /* Mark or space (stick) parity.  */

Why did you choose such a big value here?  Wouldn't it be nicer just to
follow up with 

  #define CMSPAR 0x10000

or am I missing something here?

Also, on second thought I think CMSPAR should follow CRTSCTS, a few
lines below, because of its numerical value higher than CRTSCTS.


Thanks,
Corinna
