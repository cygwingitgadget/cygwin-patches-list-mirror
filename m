Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by sourceware.org (Postfix) with ESMTPS id 162623858C83
	for <cygwin-patches@cygwin.com>; Tue, 14 Mar 2023 11:00:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 162623858C83
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MZSJa-1pzdX01X8A-00WZ39 for <cygwin-patches@cygwin.com>; Tue, 14 Mar 2023
 12:00:04 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D7969A80C13; Tue, 14 Mar 2023 12:00:03 +0100 (CET)
Date: Tue, 14 Mar 2023 12:00:03 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Fix type mismatch on sys/cpuset.h
Message-ID: <ZBBTs3UwhBBDRevh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230314085601.18635-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230314085601.18635-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:vQVD+dq6OyMGaXdtjZk+O8uadUtobMgzL+QMWO9c3Euf/2peLiF
 baEc4ugpT904BRm2WRbYz8KrpOdXzzH0ByDHq1cEBWBz2iJoMmTZt+rzJw71tNiJitfE64n
 QUY+v0R0iZLqq84iYpKeU0sRmTR8TqR1gDgc1VwTP34PQziiJpfeoKoDsH7Gt07jHClIuWQ
 ZZM0/sOIFkUKuxqzSvjFg==
UI-OutboundReport: notjunk:1;M01:P0:UreQPbha3Fs=;28uHkpX0byiGgGWxcVx3TQXFxvm
 korHQqNk1nFNkVpCodqJMCTSstLp710y+jtCI38lr5uzFnToRw4EDaWUxOz0HvD/hcSIfl2Zn
 q8iHOD98bv9yNsW0pyIDKiisPvkAK0mY3bMoo18bD3ggr6v67EOonPW/9KGFlzMcRgbnCa22H
 l+VyJQqL/DPZIZ0muI4XT+3amRdSFj8S/FidZf9B7vXjEMT7QVZUSdVhn0GZwJuhs8Y3L+3gY
 x8Wi3+v8FAKcIPf3DlnZidBu2M+Ymgf7LRGmOvoLVflRblnFchYjK7YpOEdf1SRYEb5bYGb1V
 dpASezDwd5uKv+oA8mQLRPRJbutwRJ0sxzvLs+DzUYnXLUW5bVX21a71iDINbncmqnXo2Q1Tl
 2pIydksWEO3BF9NHyRgrmRtbYPlJSel7LYqEcVPnXN+5mdPz0xuCtBm0L/7UAcGFsmGIAqaRU
 M5TZz/Wkkini70ZL0QqmdGc7rJNYo4BpPMowZ/SL1EsQTScew5KNqjBcQqViKwNpeGinuQA7u
 x66FtThKITMjRqwlP/qGkjh+hPoWtzwDnW7wg3a5kvTIEX9Qz80QrulbY7a9Amh2vB7pBeBwA
 TaZa2KTdKJoURw9d9Y8pAsVY+YIK97GzDWq+l6W9E5S4tdFrzecoeSjfUQek9NrwNRDSGGNdu
 kpCueNWCPG18HaZr+8HVMI7x7XAqOzGRsWaTww10Fw==
X-Spam-Status: No, score=-97.5 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mar 14 01:56, Mark Geisert wrote:
> Addresses https://cygwin.com/pipermail/cygwin/2023-March/253220.html
> 
> Take the opportunity to follow FreeBSD's and Linux's lead in recasting
> macro inline code as calls to static inline functions.  This allows the
> macros to be type-safe.  In addition, added a lower bound check to the
> functions that use a cpu number to avoid a potential buffer underrun on
> a bad argument.  h/t to Corinna for the advice on recasting.
> 
> Fixes: 362b98b49af5 ("Cygwin: Implement CPU_SET(3) macros")

Pushed.


Thanks,
Corinna
