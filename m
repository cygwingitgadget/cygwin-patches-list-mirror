Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id C8F573890413
 for <cygwin-patches@cygwin.com>; Tue, 19 Jan 2021 09:25:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C8F573890413
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQ8OG-1lNsWi1z1c-00M0RP for <cygwin-patches@cygwin.com>; Tue, 19 Jan 2021
 10:25:32 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CE78DA80D4D; Tue, 19 Jan 2021 10:25:31 +0100 (CET)
Date: Tue, 19 Jan 2021 10:25:31 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 08/11] path.cc: Allow to skip filesystem checks
Message-ID: <20210119092531.GL59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-9-ben@wijen.net>
 <20210118113630.GX59030@calimero.vinschen.de>
 <a1fb688c-a327-940a-ec99-651760ce02eb@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1fb688c-a327-940a-ec99-651760ce02eb@wijen.net>
X-Provags-ID: V03:K1:oPxaBrIyET4mLDL4q04tupYWAk2iLgyVTCPsqujEbQJ2XvMppld
 eqsIO3pNUlcpYZlGZreRamS4IYmq+s0Fw9G1PyJiCi6FyM1Np7PvSNqYI2wHKRA9py3ILM0
 /OFXge5LUeXZK1RgCYJIF6BGX7j8601Zp6L+r9Req0CeV+jYmIRVg9wQgx4Pr/MKWOVoXgZ
 763iR+8HtidF0VJ2nW5Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SMBag2P3Xrc=:FcUQn5lAa7qWuHYLVtjMpb
 eVONhqQJ104vn7RYYpYYQqJAVY85Kxeq3Q7XhZUIhO8TLQ3Hem61HPEk9pvkM2t5iw5xetgGB
 pGwV/urkoyBb2X3TZLZd7+UViTgAlatYdmqBYDcPY9lqrnKbz8gWGL4tDxyjMtbnFZ6en9itf
 n9lz2VmAr8lyi0ma8HstTG7r9sFMsFKycjDj3DzeclntUVRTgnzrpzCAp6yVKdfAgsdcT74Pt
 DLBByL5D38Dep40IwxoOEOKaWwlJK4Lwa0hRKa6aPHwZDJf/aDZLMCi7+tVHyO7WPkPUw3jWm
 IkkYj8EdmvCQYM6wlHET6NLswKGvcANmHCjLuS+P2+KpCm/xelcpWgK3/GvDZ9TOi0vTJiYqJ
 8yAFd1CcT4f5WPpHr6kc+W/segVkMuwb+N2Qc9E8WIVhTX7Q92Nfp5cvZXJHL9QaP9dwB7Pkg
 wKEfagfPKA==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 19 Jan 2021 09:25:35 -0000

On Jan 18 18:15, Ben wrote:
> 
> 
> On 18-01-2021 12:36, Corinna Vinschen via Cygwin-patches wrote:
> > On Jan 15 14:45, Ben Wijen wrote:
> > 
> > Without any code setting the flag, this doesn't seem to make any
> > sense.  At least the commit message should reflect on the reasons
> > for this change.
> > 
> Something like this:
>     path.cc: Allow to skip filesystem checks
>     
>     When file attributes are of no concern, there is no point to query them.
>     This can greatly speedup code which doesn't need it.
>     
>     For example, this can be used to try a path without filesystem checks first
>     and try again with filesystem checks
> 
> 
> If you want, I can also squash some of these related commits.

That's not necessary, but a log msg hint along the lines of "in
preparation of <what follow up patch is doing>" would help.

However, just to be clear here.  While I really appreciate your efforts,
I'm not sure yet if we really *can* skip the filesystem checks.  This is
dangerous but often perpetrated territory.  Trying to work around
certain checks almost always resulted in other problems in the past,
like POSIX/Linux incompatibilities or forgetting to handle Windows
quirks.  A certain callousness and high frustration barrier are
required.


Thanks,
Corinna
