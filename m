Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 2746E384C005
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 10:46:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2746E384C005
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N2EHo-1m6Uf032Ss-013dOm for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2021
 11:46:16 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D6CCBA80D7F; Mon,  1 Feb 2021 11:46:15 +0100 (CET)
Date: Mon, 1 Feb 2021 11:46:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: getdtablesize: always return OPEN_MAX_MAX
Message-ID: <20210201104615.GL375565@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210128025150.46708-1-kbrown@cornell.edu>
 <20210128102029.GY4393@calimero.vinschen.de>
 <151a4199-92f2-43aa-dd91-5d86c2e1d3c6@cornell.edu>
 <20210128160749.GB4393@calimero.vinschen.de>
 <9b430aa5-1033-ebef-b002-b1523355271c@cornell.edu>
 <20210201095054.GF375565@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210201095054.GF375565@calimero.vinschen.de>
X-Provags-ID: V03:K1:oC7obtTa1uWqpH6kct6eOyVeMD/IaohI80oTZ4bj304mJVa7MbP
 XgvrLW0rrDiD0z6iWUKEVKN8RSAKSh9ZUd4FHnRcP25VHQ5IRSJUct0r6g1aJHnJ91B0fbl
 rpxIZZdbvIV/UN7e/em2zeHi2W17dg9YXpjMVeVVSAQyEvckOZeLmSFsgSzVpROJdaG9idC
 I04zOFIkOo+wHNHvVrjkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Vtb7tZBKhM=:b0u1YYevAjCWVO6uO11FTp
 +w+f26Rb+2nk52kMuT3KMkJJ9UnX/4GePOIi/V0kU3wX3R0k+WBUtrr/5QooblKbk6agY6Sy0
 DvyCsCTqAEbboehMccla3c9kb7qB0+PxC8VNWE5DAHvOupRg8IV02QKS61zYdc70l2kGvSOK/
 hG6PR+R/i5sDz6fjYHFsH52CYuYhQ63huM6O9psuo9rgiGIS14ioRijbplKbTlSxGlDm3kvsh
 9RTAUBZNUXTBbkdATSzJLZSvguz6OJN0nyGtqBBM/bUOI9FqN8ZcpcA8z0yY31r+WbcLgi1dZ
 CvZu4Twak0iNKT2IgX6urV20UVdzLqiFrE/nveE5AqkmsuV4ydkHrP7kB/rHf1X3luKNDO/S7
 Xpf28IOCxtSNNJECXQcRev9wd1ktVohd0NKG5XthrcmsoTCd7xzzECs5oucVOYdrMU+INaslp
 +hmJjF9d+g==
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 01 Feb 2021 10:46:19 -0000

On Feb  1 10:50, Corinna Vinschen via Cygwin-patches wrote:
> On Jan 28 15:33, Ken Brown via Cygwin-patches wrote:
> > On 1/28/2021 11:07 AM, Corinna Vinschen via Cygwin-patches wrote:
> > > One problem is that there are some applications in the wild which run
> > > loops up to either sysconf(_SC_OPEN_MAX) or OPEN_MAX to handle open
> > > descriptors.  tcsh is one of them.  It may slow done tcsh quite a bit
> > > if the loop runs to 3200 now every time.
> > 
> > I don't use tcsh.  Is it easy to test this?
> 
> I just checked the source.  In the olden days, before the invention of
> close-on-exec, tcsh closed all descriptors > 2 up to OPEN_MAX prior to
> starting any executable.
> 
> With close-on-exec this happens only at startup and after an error
> occured.
> 
> So testing should be easy: The tcsh startup may be noticably slower.

I checked this right now and I don't see a noticable, i. .e, any,
difference.


Corinna
