Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 86EBB3858036
 for <cygwin-patches@cygwin.com>; Tue,  8 Dec 2020 09:53:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 86EBB3858036
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M2w8Y-1kjGIY16nU-003Nmz for <cygwin-patches@cygwin.com>; Tue, 08 Dec 2020
 10:53:30 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 11AEFA806E3; Tue,  8 Dec 2020 10:53:29 +0100 (CET)
Date: Tue, 8 Dec 2020 10:53:29 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Allow to set SO_PEERCRED zero (v2)
Message-ID: <20201208095329.GN5295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201207102936.1527-1-mark@maxrnd.com>
 <20201207153025.GJ5295@calimero.vinschen.de>
 <20201207153513.GK5295@calimero.vinschen.de>
 <0dffe28e-1b11-3637-ade1-c005a554ce50@maxrnd.com>
 <20201208094733.GM5295@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208094733.GM5295@calimero.vinschen.de>
X-Provags-ID: V03:K1:n6xWMisDVwS9DOpsCWIEYMHC7z1sAX3Pn022Xxh0U2VVFUaAa9c
 cyHsa20nacpnD6p6nw7+JznxUp030rDE6Unf2xC1wL/KNUX3ZpmwBAcK5UpmfqCZuFrapxF
 xisJG+1YUazNCL+PPbwUpcDbk9mjhuJU4ZEfZR/GQcu2GZSiD7x2usqK3xHrOcQSbraIW/n
 12XxM9wTICsZozd5KInDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fnLgp+6PeOU=:wqc2aP76D4Mo7wnX4HYFCC
 8CmxCZnMslIE7KNylA4wjZUzJFB740JHVL9zNqRJpPSwZ91TCh7gP90eKR5zOuM9zn072CaDR
 92S424CQuQkP4J9+a4CzEodt/zIBekH5b5DTu5M6jxeC9p/G4Cg2VVu4vcXMorNQNO6W9pE02
 Qup/PHm+dqknQtiMlaBVcFQR/ZE2D8+PRmKlsmHMlSn6OHRfDtIVM0+kN4pIY0n2p5z51t87G
 hjaefIKVrDJQ1MKVIGfSyR1/Gfo0EwBNET5tmCNsbS2zexFyv37iErPLj61+VxQz4MJcZGAua
 UXqCyRIXvPngszi449ybDQwnPSJ9fg1bzwExt1kYVM73hLMe/5avmL32KUoP9kdCIsfp6r3o9
 /Tfuh0B3BfihflrAxcGzRiZcbvgzJMv4Xl3LLgp0ySO6+imCF7O33dbtWDwikOyp/lMWonixc
 y22F8H9t+g==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 08 Dec 2020 09:53:33 -0000

On Dec  8 10:47, Corinna Vinschen via Cygwin-patches wrote:
> Hi Mark,
> 
> On Dec  7 19:25, Mark Geisert wrote:
> > Hi Corinna,
> > 
> > Corinna Vinschen via Cygwin-patches wrote:
> > > On Dec  7 16:30, Corinna Vinschen via Cygwin-patches wrote:
> > > > On Dec  7 02:29, Mark Geisert wrote:
> > > > > The existing code errors as EINVAL any attempt to set a value for
> > > > > SO_PEERCRED via setsockopt() on an AF_UNIX/AF_LOCAL socket.  But to
> > > > > enable the workaround set_no_getpeereid behavior for Python one has
> > > > > to be able to set SO_PEERCRED to zero.  Ergo, this patch.  Python has
> > > > > no way to specify a NULL pointer for 'optval'.
> > > > > 
> > > > > This v2 of patch allows the original working (i.e., allow NULL,0 for
> > > > > optval,optlen to mean turn off SO_PEERCRED) in addition to the new
> > > > > working described above.  The sense of the 'if' stmt is reversed for
> > > > > readability.
> > > > > 
> > > > > ---
> > [...]
> > > > > -- 
> > > > > 2.29.2
> > > > 
> > > > Pushed
> > > 
> > > I created new developer snapshots for testing.
> > 
> > I didn't phrase my comment somewhere about "future snapshot TBA" as I had
> > intended.  I just meant some future snapshot, not that I was requesting one
> > for this patch.  But thank you very much anyway.
> 
> I freely admit I didn't actually read your comment :}

...the part talking about a future snapshot, that is...

> 
> I just created this snapshot because it seemed useful, so all is well :)
> 
> 
> Corinna
