Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 52FB8385BF9E
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 14:27:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 52FB8385BF9E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N3bGP-1lp8io47j1-010Zvb for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021
 15:27:30 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 0ABD6A80DC9; Tue, 23 Mar 2021 15:27:29 +0100 (CET)
Date: Tue, 23 Mar 2021 15:27:29 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-ID: <YFn60XBYI5qRfpo4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
 <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
 <YFncTItWHhMlNH5Y@calimero.vinschen.de>
 <20210323213212.d2c5a9e7db7a508260693998@nifty.ne.jp>
 <20210323214206.ebb5b1cb80a8b71ead4e8cda@nifty.ne.jp>
 <20210323215227.eda395caff35c4d5aa9b9007@nifty.ne.jp>
 <YFnt95aAHnuu7NCC@calimero.vinschen.de>
 <20210323225142.3ddc21334ca645ab838ddf49@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323225142.3ddc21334ca645ab838ddf49@nifty.ne.jp>
X-Provags-ID: V03:K1:rWX4sHLCkRu7y6j1F34yFTjnnet+0Az2VQFpt0RWsNoY6Tf3x8i
 EHL8Jhg3cCAdtBbSEg33u3WG5p/uzZxx0cMaVvHaXk8drVcOXJbP/HkeQWLDob88igSL0oo
 PiVK+4bGFXs41i5ZvY1JL4fo6pf/kve3BrpxRhHBGUE3bLindX09Nm6lGEhL93w2EM85z5R
 hgUk5mKSgm9QRKn5zBRpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a1/pcXIb1vg=:sxRQEVSi5b6H07fHCn2j0f
 8a77PnqI/TM3mHFcBA2HIEd3sKQMNJlXXHu28FO9O+lCOhwVG0JkH6HqM3HGYqwfp9MExrc9m
 IlINNJHSdqDziJj6v4jdp2zXVBPjRj5wy6C6uicFiDU3ovsWdVjSOsrUkwh53GHzsMnkQ3IEv
 tavDYeCpRV5yZNA8nXoPYCj4XGIMSyoxyfDAvRnb4rGK42iwALnQiBNFXmMUrLUu93o01J09m
 NX/puwcQBJhh0udqkKhmQ4O0NeSiCdfd/mtTq3IKSni56cJM+CNw69wg4h4gRQ10z0/RXv8n0
 3mn6HOETjELJANinCT1UdZZ1LjdF8RmWV99VQiK7glVbolw7OI2jHSW91h1YHGSglDLcBvANP
 kFrAuLdF3LsA37Hubwg76G+W0vOwNsiErI29bMkO8jA2rGdBzLCrf87ezKUWpm7ioSSN9pDgb
 Xjbo78XlEZoJy1ELDzFBR8exqDojpOLf5RXBCwNZjsQ/8euUuas5
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 23 Mar 2021 14:27:33 -0000

On Mar 23 22:51, Takashi Yano wrote:
> On Tue, 23 Mar 2021 14:32:39 +0100
> Corinna Vinschen wrote:
> > On Mar 23 21:52, Takashi Yano via Cygwin-patches wrote:
> > > On Tue, 23 Mar 2021 21:42:06 +0900
> > > Takashi Yano wrote:
> > > > On Tue, 23 Mar 2021 21:32:12 +0900
> > > > Takashi Yano wrote:
> > > > > I try to check run.exe behaviour and noticed that
> > > > > run cmd.exe
> > > > > and
> > > > > run cat.exe
> > > > > does not work with cygwin 3.0.7 and 3.2.0 (TEST) while these
> > > > > work in 3.1.7.
> > > > 
> > > > In obove cases, cmd.exe and cat.exe is running in *hidden* console,
> > > > therefore nothing is shown. Right?
> > > 
> > > In what situation are
> > >   psi->cb = sizeof (STARTUPINFO);
> > >   psi->hStdInput  = GetStdHandle (STD_INPUT_HANDLE);
> > >   psi->hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
> > >   psi->hStdError  = GetStdHandle (STD_ERROR_HANDLE);
> > > these handles used?
> > 
> > Hmm, trying to make sense from the code, I'd say, these handles are used
> > by default, unless run.exe is already attached to a console.  In  the
> > latter case, it calls CreateFile( "CONIN$") etc. to attach the new
> > process to that console.
> 
> "if (!bForceUsingPipes && bHaveConsole)"
> then handles are replaced by CreateFile("CONIN$", ...) etc.
> else replaced by pipe handle. If so, handles returned by
> GetStdHandle() are never used.
> 
> Do I overlook something?

AFAICS, bForceUsingPipes is always FALSE.  bHaveConsole is only TRUE if
run.exe is started from a console.  If run.exe is started from the GUI
(which was the primary idea, IIRC), bHaveConsole is FALSE.  So the
GetStdHandle() handles are used when started from thre GUI, isn't it?


Corinna
