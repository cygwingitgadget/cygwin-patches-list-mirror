Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 96156386F41A
 for <cygwin-patches@cygwin.com>; Tue,  9 Mar 2021 09:23:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 96156386F41A
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N7AEs-1lpb2n2HaG-017XzY for <cygwin-patches@cygwin.com>; Tue, 09 Mar 2021
 10:23:17 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C0ABBA80D38; Tue,  9 Mar 2021 10:23:16 +0100 (CET)
Date: Tue, 9 Mar 2021 10:23:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Transfer input for native app only if the
 stdin is pcon.
Message-ID: <YEc+hJIeHDKqQnsy@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210308145510.1164-1-takashi.yano@nifty.ne.jp>
 <YEZDgPyUTu18fFD5@calimero.vinschen.de>
 <20210309004818.0e6973cfde7a563ab293e1ac@nifty.ne.jp>
 <YEaOlWwJDe/3R7m/@calimero.vinschen.de>
 <20210309122249.6b0a1ae4335f7cf89ed6c1d0@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309122249.6b0a1ae4335f7cf89ed6c1d0@nifty.ne.jp>
X-Provags-ID: V03:K1:kPyEIp98SiCTInZjdwR3viI+YEIRK81XTttqIwsM3eC6CDV4KXK
 O/j65oxGiWH9ZCidEIBSfC+D+kZMK8UcKBVPQIMLeyYsR9Z7Y5C+566/Jlhzw82KhDn5A68
 nZvNkf1A3L/tjbuo5iIoOvTF1dklOokk+G2bWhit8ECf5MmCfMBZVqmYKqcL66KtqRQQjK/
 A2Cqb8CJZ62HpSNe6O3Dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IPKnCHYHXzY=:gzoe0ZIE5BX0cfhGWFaRWz
 ++iElX9yU0ucDNUelcLsuK1hRhYk5S+gIMcyKm7LyNpwzHlSDVA3XLjGVaIzRIinvlfuM5zVx
 EjWlmOoV1T3koBohN90/3cWdXfE1SlSrZmD2bmaRb+V9m4fIHteHBAw8cjNM6ObvEvX4nxwZ9
 1ImBSuRZDa7mjSYFZrUGKFLLkBvC0VR80mShH9F65XSwAXTedp2s8LoTYeTwiPplK8l5so5cY
 7ap0PckNiyj0gDwz4K5WErHDvPNqXmoxAkAQj0CGzqlhudAVmxtjh1mui+h/sWmj66pm6XDQm
 bafxWCNvNSeSCVrcGSRRxjJJr+CtUfdLJJUZ0ET+H+BSnppoub4I5g+j3ITBQ+ZmYgW4R9kUi
 ae1EAk6IZbhmqLPDvYdn9ED+Bt3xfvUnGJ5g8+oKKUJBTpb99VD/R4/umrZU7cLh2UM2I/bbc
 KAP/OJzZHw==
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
X-List-Received-Date: Tue, 09 Mar 2021 09:23:21 -0000

On Mar  9 12:22, Takashi Yano via Cygwin-patches wrote:
> On Mon, 8 Mar 2021 21:52:37 +0100
> Corinna Vinschen wrote:
> > On Mar  9 00:48, Takashi Yano via Cygwin-patches wrote:
> > > On Mon, 8 Mar 2021 16:32:16 +0100
> > > Corinna Vinschen wrote:
> > > > Hi Takashi,
> > > > 
> > > > On Mar  8 23:55, Takashi Yano via Cygwin-patches wrote:
> > > > > - Currently, transfer input is triggered even if the stdin of native
> > > > >   app is not a pseudo console. With this patch it is triggered only
> > > > >   if the stdin is a pseudo console.
> > > > 
> > > > do you have more patches in the loop?  I wonder if I should really start
> > > > the test release cycle for 3.2.0 or if I should wait a bit...?
> > > 
> > > I'm sorry to submit patches one after another. However,
> > > I think this should be the last one. Please go ahead.
> > 
> > Great, thanks!
> 
> I am very sorry but I would like to submit just one more patch.
> I apologize to overturn the previous statement...

No worries :)


Corinna
