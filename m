Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by sourceware.org (Postfix) with ESMTPS id 80F953841889
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 14:35:37 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MIKs0-1p0ths0Yi4-00EQpq for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023
 15:35:36 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B29FBA80A3A; Tue, 10 Jan 2023 15:35:35 +0100 (CET)
Date: Tue, 10 Jan 2023 15:35:35 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pinfo: Additional fix for CTTY behavior.
Message-ID: <Y713t43ryah6qmHw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221228083516.1226-1-takashi.yano@nifty.ne.jp>
 <Y7vdjTREYWiLAJ9N@calimero.vinschen.de>
 <20230110223706.1d38233b6be7d03f512275dc@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230110223706.1d38233b6be7d03f512275dc@nifty.ne.jp>
X-Provags-ID: V03:K1:aDSSfFMdPrQ6SGtLu0pRYDD9WuQaPmH8S2BeY/VImLQRKGuHfz4
 VLri4Se33PR/GrWm0uFdfAf4D1EJ50cwHT7gM/wZWm/3l+FO0rsH+pc4efkRhb+ug9rdSFX
 87+LqA8EuXJ87vLdC++0Qd/0Y4pUBAOMI7aP4tBpF7SDXLKd4AKrhuD/9MJqCmgqw/Ng6zB
 ayVz9BfLYoeHze2+pIjKQ==
UI-OutboundReport: notjunk:1;M01:P0:ALWMnLNr9uA=;EnNO5Z5MTJEXxP+Zjd0qjzzSTvG
 6KHgw6ZgL5EzDm6ldeoP6izHjRGY5gs5F7jFVLqPuIcXbYKshYbDxgGwyh5DMer2za8V3XbgV
 qj6i1cj4330evLfVIGiIMeH6j84hvIyBbrC1wIzr3gISGsMyLuwrz/kBwjIVGzaqUezPggnSF
 6xaSSGPfE90fTShKETwQVlqZF4JAlAm87zdYiCGCqH0FvBfRWUAOB7yAnIUVST1/mEjncODjl
 LZEAGP5ISnTERMXVMofwOI6H4ZrBz0t2tWgM/uCw1ba2WkiXNoixfa8uawFDA33w43H+3VqGh
 ZIl55BnESKXeZwv9vULvtoySRaKlwmSEsWfU2gszFrQrH2aib2mTFJjOeRs0WKFiuE2gXcgc2
 ufqNg0+rUkb5XKWSrHehbSmGdPaXKRZdCanD33eTVWD3GoyDpzWQfJFNz8E/sCcEIWEpGvWu4
 V5Ra08eGSmp6q6/oSdge9theoclWmJz+jQ6F6YzHONloQvt//v0RC8lBFusbLzW6DNDGZS+Xt
 zfTX+nQraNk1jU1rvacWA5/yCdVSfahZ/fLgMFUw54cWaQo3AR+N3m5WVp+JKbvPBXH6y3Se4
 4iV6tzs4SUrZdH++hSwvcaQNb3MXrLym6LgLok94d7iu1+inOMKydiTuEcluZOQcrBx3QjQJq
 cK7zEp8HJcPuSjARoyH9Ri4cdFgfGmjeuUzyjvnbAQ==
X-Spam-Status: No, score=-96.7 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jan 10 22:37, Takashi Yano wrote:
> On Mon, 9 Jan 2023 10:25:33 +0100
> Corinna Vinschen wrote:
> > Also, given this was a "kludge" from 10 years ago, is it really still
> > needed?
> 
> Ah, do you mean the "kludge":
> winsup/cygwin/syscalls.cc: 1455:
>       /* This is a temporary kludge until all utilities can catch up
> 	 with a change in behavior that implements linux functionality:
> 	 opening a tty should not automatically cause it to become the
> 	 controlling tty for the process.  */
>       if (!(flags & O_NOCTTY) && fd > 2 && myself->ctty != -2)
> 	{
> 	  flags |= O_NOCTTY;
> 	  /* flag that, if opened, this fhandler could later be capable
> 	     of being a controlling terminal if /dev/tty is opened. */
> 	  opt |= PC_CTTY;
> 	}
> 
> and
> 
> winsup/cygwin/dtable.cc: 767:
>   /* This is a temporary kludge until all utilities can catch up with
>      a change in behavior that implements linux functionality:  opening
>      a tty should not automatically cause it to become the controlling
>      tty for the process.  */
>   if (newfd > 2)
>     flags |= O_NOCTTY;
> ?
> 
> These codes might be able to be deleted. I'll check if these
> are not needed.

Actually I meant commit c38a2d837303, introducing the -2 value for ctty.
But yeah, the above stuff is also interesting and every opportunity to
get rid of old workarounds is nice.


Corinna
