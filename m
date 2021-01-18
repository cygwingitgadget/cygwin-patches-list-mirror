Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 0F48A386EC51
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 13:20:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0F48A386EC51
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N95Rn-1m4e6G38vX-016Ahl for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 14:20:19 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 49804A80988; Mon, 18 Jan 2021 14:20:19 +0100 (CET)
Date: Mon, 18 Jan 2021 14:20:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: pty: Prevent pty from changing code page of
 parent console.
Message-ID: <20210118132019.GF59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210118131057.32-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210118131057.32-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:K1E6rFUcRvXC4GVT6HztkwgRQi7tzwkR20O53i8kvsR3iGekvEO
 tqWmFT9YfYEamTxJVDnYmO2/4hBdo/HaiOcb7t6mSNdMCDgsN/5he8ZctV+4GxOLV8g8CEv
 vTx7sJ35sRIHTVcKM4PhwjL82pOQLtURkM+uytFtULFnywyrZ7tktGBSkSr3OS0iBfW8h26
 Mwr2L5/PYkUiwlK23eAdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l4yJZIjhZJc=:1xf+4461Wo4v0IM7WIHJLy
 Lpy4pTCoX14yLC6zTCc6v7RkF+ifX7gdshhJetn0Zz2BpPBzJVyotS95iOIh89l/6NOVVy+Y6
 pVj7P++aW0XmiIT3ItUHvDdUNWGwJSbs1iKFDoPs8eViedmW4VyCsJWRls/g3jWoxPtGA6/Mq
 zgIgwOvbppNtrZDOOXfuQ0o1tduZKCFVKlLGdQrleevHOQG7mcBmu0O4R8WsH5pj8xMQ3+hKh
 ge7jNo9G11vZbov2DXiUxPPn7VHjTl2svD90JgFP4WAdjwVZESvoVn9/W4V/qRsaKoAAQVejW
 CpqHpZPlaOzN+JwjuvHMROHBmxxftPmTVeyE2EnJ3w5N6V8yq12yOl7spelVpN7P/KTrnj5n8
 wxEg92N+M2VYgZNRv5J2SE0uTtyKaFNAsqUnMQHBAldV8WFyMHPFM+eTCFsffzqmrUeHQwNrO
 j+LOKf4plQ==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 18 Jan 2021 13:20:31 -0000

On Jan 18 22:10, Takashi Yano via Cygwin-patches wrote:
> - After commit 232fde0e, pty changes console code page when the first
>   non-cygwin app is executed. If pty is started in real console device,
>   pty changes the code page of root console. This causes very annoying
>   result because changing code page changes the font of command prompt
>   if console is in legacy mode. This patch avoids this by creating a
>   new invisible console for the first pty started in console device.
> ---
>  winsup/cygwin/fhandler.h          |   5 +-
>  winsup/cygwin/fhandler_console.cc |  38 ++++++++--
>  winsup/cygwin/fhandler_tty.cc     | 118 +++++++++++++++++++++++++++++-
>  winsup/cygwin/spawn.cc            |   1 +
>  winsup/cygwin/tty.cc              |   2 +
>  winsup/cygwin/tty.h               |   2 +
>  6 files changed, 155 insertions(+), 11 deletions(-)

Pushed, including patch 5/5


Thanks,
Corinna
