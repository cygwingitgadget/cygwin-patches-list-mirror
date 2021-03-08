Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 81C1C3864859
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 10:13:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 81C1C3864859
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MeC5x-1lrRug14Z5-00bGqU for <cygwin-patches@cygwin.com>; Mon, 08 Mar 2021
 11:13:29 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 96D36A8266C; Mon,  8 Mar 2021 11:13:28 +0100 (CET)
Date: Mon, 8 Mar 2021 11:13:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/doc/dll.xml: update MinGW/.org to MinGW-w64/.org
Message-ID: <YEX4yHo5zbjPx9x9@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210307163155.63871-1-Brian.Inglis@SystematicSW.ab.ca>
 <aada0b19-26ea-9db0-85f4-8f959441e05a@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aada0b19-26ea-9db0-85f4-8f959441e05a@dronecode.org.uk>
X-Provags-ID: V03:K1:dH5ZonXzRuUSdMnU0Ukt8bNCAQmJ9k5ChPYFHaRGCVSgK07Pf39
 ta9E1Gs9Qz2/Ke7Avqf92MsXx8DDGvEQg8yiWu85tinK46ytkiCzDe2dLPPJVjVhzimy9Y/
 zUsvMfqlyMPCQ1SkvS2p4hBW9Xvm4DCajyQre0w/KBf4TSpBpiiC2w4rrXHybZURhJz2Dej
 ex5YUngsMXVE4ClbM4I/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hG+xk4mEsV0=:HiqambAadsmOmmWIU+oLkI
 QuT+2aWMzVkqZFOY5raSPbiEMcbG1y5D0Mu3STx/HSJjbvbjdh31FWSECsexkwbWwL893V/IC
 CdBwwRkl+BQI2hcmXv7ZGlKxXve61M6uhm/LatGFEKnpoabRJt4JMFZLV0kfKFeffjVhErIsJ
 ZiH3n9jqHqxzR2AOls+qtTcofc2VZ/HhGqHh7pQ42hs5uLNvGtg4HvUPzEC+zju9PvKOKXsQt
 3+UE4T7Rwmwr3jznE/1tQewnFM/P05G+t8KM7CR9wUHJsh5OCKd6WsC1uSmIOjrPjOeNI7URz
 K6ae3O9XXurUvtpQ1BAB0RvapK51B0MfcJTqX0DtCSCUfrP1FuTmIOwUFbKeaIN7Vrrq8I3Tx
 Slt5HTOYtlZgM5YmItghx2XLvzDISmUG63FRj7LQzPF6pgCXzzeDS6dN16YoZ0AfFd06XHpK8
 NGLuKsso/w==
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
X-List-Received-Date: Mon, 08 Mar 2021 10:13:32 -0000

On Mar  7 19:15, Jon Turney wrote:
> On 07/03/2021 16:31, Brian Inglis wrote:
> > ---
> >   winsup/doc/dll.xml | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> 
> I don't think the link here actually has much value, and would be inclined
> to drop it, as far as I can tell it's just giving that as an example of a
> toolchain which produces 'lib'-prefixed DLLs.

However, telling people we use cyg instead of lib for $reason, and then
not pointing to at least one project using this prefix seems puzzeling.
Given that Windows doesn't use a prefix at all, the URL to mingw-w64
might help, doesn't it?

> Also, reading the whole page, the section "Linking against DLLs" needs
> updating since GNU ld has had the ability to link directly against DLLs
> (automatically generating the necessary import stubs) for a number of years.

What do you suggest?  Shall we just remove the section entirely?

> Also, there are other mentions of MinGW.org on the cygwin website (e.g.
> https://cygwin.com/links.html) which also need updating, if that URL is no
> longer valid.

Yeah, we should remove them or move them to mingw-w64, too.


Thanks,
Corinna
