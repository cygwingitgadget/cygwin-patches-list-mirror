Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 03D7D3857838
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 11:44:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 03D7D3857838
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhlCa-1jxLhG2cCW-00dpTV for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020
 13:44:54 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1D838A82BCF; Tue, 13 Oct 2020 13:44:54 +0200 (CEST)
Date: Tue, 13 Oct 2020 13:44:54 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add workaround for ISO-2022 and ISCII in
 convert_mb_str().
Message-ID: <20201013114454.GI26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
 <20200911120840.GH4127@calimero.vinschen.de>
 <20200911213515.98a88ca7f186ede9bf8fc106@nifty.ne.jp>
 <20200911140601.GK4127@calimero.vinschen.de>
 <20200912010504.586a156f1712f61c3c696d40@nifty.ne.jp>
 <20200912023843.58ef0f3134d6aea5359c27c0@nifty.ne.jp>
 <20200912033758.d3e898332cb37f8b69f43bd4@nifty.ne.jp>
 <20200911185706.GO4127@calimero.vinschen.de>
 <20200912041116.71e276467eaa4040c329547d@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200912041116.71e276467eaa4040c329547d@nifty.ne.jp>
X-Provags-ID: V03:K1:bE25Px3NoK/8o1etTR5mCmjAUnNDJBDzM4+0KoUo7wtMEhZbDlS
 ANKILg4fRbAqTTDVkejn1VICWpoO1leytU7ZBtfetnxvuD9LMRNDGFNO47ljXGSRJUcGzig
 Cq+l77O9N4JE/wCYcN+BUUSnZYbzg2TqisC8SLi0IlbCIaHspC1LfeyPeQYxTOnpE3asQ3D
 iSomAtn3EzvO1wATbxTCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BoxN5pQctZY=:UMFnSDJa7Gvs1a6MCBZ32m
 5vXrteImkkb3PKNJAorbDu0E8yXUIk4XW9VP1Az0gFVQjthivjG49utscbflnHnrihOvxXIAO
 C4yv8nqC+c63YLaTQNm6tB5yBQ9WcVfuldsc5D4n4bNJlJtBUszswizd3uyJeiNRFkEqaa5T5
 qiqt1v9pB/EPiZAijnoR6rUBfmVfROJPrZaUmCgtxLS26KqmLuX3PaHYi5iyJlbUBWAaok/eF
 hc5jAEwAnQJIygODeAJsu1JyF/SVdNz/1S4dklSaWHTrWsBLlyzTVXo9shA5XhknkGmL/wYSR
 AXtoia0zp5vAPdjYsGrA2qqtMjKEjfiu3DKILSvlel69QvZWSxu/NJrMnGlPMeaAz+Vpc8P9Z
 1Sc074G6wHvzaGA0e+dRqsNjELXYrRdXB2OF2n6xyEyXM9WFkaJLAKo8Tx79792DyBfr7HdjR
 rBN2dokRWmGdrHmFubqOJ5gYEftkAIjWn9Ubm35znghigDJKZOwTOR3VR5eYe9hVCS3irW2wV
 i6loPGFUzdzqYpp6iKEemxYCWDrEI4OsgrV91XMEEdmLRRk3UGR6XG69wvcHXTMqRFwyvXidA
 QkvR/J70zyJqA9VAoGUxypakZRLPThGvDgDVhJhwAoTW9+ui4HxJxGCRKfq1ygiO6vydavK1O
 +gyKjO+CurGYUbn4t+zgy44Jk+/Rfngmp28pDMWjqNX3x9dcroQya88VITVzlhPCQo09hgf23
 S0UemXR9jrTdz1NPyo7xQ7ifAkqrrjmInzPVoBOndWEIgkqCSMkRlrbFH4yizgHW3/jtmmSo6
 Kj9n3uzoBS3MraJezdHnLEBSma6UDCSnAdPASfLef2yq9ldjseKu8YhvYnIRgSRfcPVi2ndZu
 Hkn8FVpmlPKx880yveOymuoE0GJOrc5oWTjYIjpjs=
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Tue, 13 Oct 2020 11:44:57 -0000

On Sep 12 04:11, Takashi Yano via Cygwin-patches wrote:
> On Fri, 11 Sep 2020 20:57:06 +0200
> Corinna Vinschen wrote:
> > On Sep 12 03:37, Takashi Yano via Cygwin-patches wrote:
> > > On Sat, 12 Sep 2020 02:38:43 +0900
> > > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > > > How about the patch attached?
> > > > I think this is safer than previous patch.
> > > 
> > > I have revised this patch to fit current git head, and submit
> > > to cygwin-patches@cygwin.com.
> > 
> > Thanks, but I didn't apply this one because it doesn't really make sense
> > to go to the extra effort to support outdated and incompatible codepages
> > we don't handle as Cygwin codeset at all.  IMHO it's not worth to call
> > another MBTWC just to check if a codepage supports the MB_ERR_INVALID_CHARS
> > flag.
> 
> I have checked which codepage does not support MB_ERR_INVALID_CHARS.
> The result is as follows.
> 
> 42
> 50220
> 50221
> 50222
> 50225
> 50227
> 50229
> 52936
> 57002
> 57003
> 57004
> 57005
> 57006
> 57007
> 57008
> 57009
> 57010
> 57011
> 65000

Yup, these are documented on MSDN:
https://docs.microsoft.com/en-us/windows/win32/api/stringapiset/nf-stringapiset-widechartomultibyte

> If all of these are not worth for everyone, I agree with you.

I think we can skip those.


Corinna
