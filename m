Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by sourceware.org (Postfix) with ESMTPS id 2E2293858D3C
	for <cygwin-patches@cygwin.com>; Tue, 21 Mar 2023 17:58:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2E2293858D3C
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1JJC-1pd2cD0A3e-002keb; Tue, 21 Mar 2023 18:58:03 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 920C7A80D37; Tue, 21 Mar 2023 18:58:01 +0100 (CET)
Date: Tue, 21 Mar 2023 18:58:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Message-ID: <ZBnwKcr+ZL6sv0jh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Yoshinao Muramatsu <ysno@ac.auone-net.jp>,
	cygwin-patches@cygwin.com
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
 <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
 <ZBWL85hJIlbZHc/D@calimero.vinschen.de>
 <608a78b6-f523-14f1-333d-f59e9f2bb8d5@ac.auone-net.jp>
 <ZBhy7E4vKHTRNW6k@calimero.vinschen.de>
 <ZBjD9exM9ZBGDzK3@calimero.vinschen.de>
 <434bbf77-6a08-3be2-747f-13dfc4637275@ac.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <434bbf77-6a08-3be2-747f-13dfc4637275@ac.auone-net.jp>
X-Provags-ID: V03:K1:8yZZM2VYbZ2g2d4g0H8lVyI+5ONXQ+ZrEnZdTB+Atnx3eWXFQ2x
 OVSd2TKggZGARxvMCML0BHY0ayQyDm9N+s/WP97tDBg/S13FqvUwgYBucRUYB0vbQz9xCE+
 cEu92Im3pFrI751n17Qiekm7wAU/yIOK5E4atdZ4kYWoKY8wG/VWe6TFhtPy32c4egsQMgJ
 TJOEtYcknKlMOtNRcxwnA==
UI-OutboundReport: notjunk:1;M01:P0:oOaS4jEZnGg=;xGoxKIqjXGXmvcDzpEjV/4b52jT
 QIRtBnLXTwyn/qHiRUV8VKj1oV4w+zRupivI1Evm4W0NCXDcj0nQFlBGyMspwfL9525hElGdV
 jKWyqFCfAKwG1HOLm77p6kvPaYKma3YHWg24Z/LWDee0g4Dsu6BtAHWkzYyGhuxHS7GppO1Tr
 xNsL1ZjHB+ENKZDMtJpZXlRQRT5++XZNs88lDwf3CtvNbQS25THrirvPDsAfkdHJEZB3Q5wLG
 PahWYPjIKQWB6YJR8gaqiliwjaiAKZxRAOF3QsfasoTJ03PuGAhwmPMMKTosjEw14tt1XKaRL
 x8AB1wNXUOpXBBDNOutgblt4cyzXg7BSOxuSZ1yFNCOqHzlCX3dcRm4wdb2AUjXCTXfR/DSnq
 C4hmIOmMpl77fASYQdFE2jtu4Gw6jisSvFW2dBrb3L+F/Z1Vh4BgCaP9ISMel4X7ENMaqhpo7
 MJr5gieOqPieYeVaWbOpu0SR1xxn/mTUpTz+K1VnG/0HWsaM/0/KgQfKVcYqLqn7fhc1it5ln
 XymdCgAzavC9a1CFHMtcCUCV2K2uvPCstjCs/SmXAHIULEc8ETE0KVkuv+a+7UCHUydvsf6lS
 qG8CKqDao9ipBceCM9DYPq3NzJSxYQM5/nmFwjf//Y1+t9HRqr/e9l4HgXOrRVwcutR4lIZaU
 om4q0DYnny2dI33BynjO4lqBNrZBG5Y/yfmmH1PFLQ==
X-Spam-Status: No, score=-97.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mar 22 00:32, Yoshinao Muramatsu wrote:
> > Wait.  I might have misunderstood something.  This is about accessing a
> > host NTFS from inside a Hyper-V isolated process, right?  So from the
> > point of view of the Hyper-V isolated Cygwin process, the NTFS
> > filesystem is a *local* filesystem?  Or is it mapped as a remote
> > filesystem?
> > 
> > The difference is important, because my patch would only change the
> > outcome if the Cygwin process in the Hyper-V container gets the
> > NTFS filesystem presented as a remote filesystem.
> > 
> > I noticed this problem when I was looking into implementing the
> > FILE_SUPPORTS_OPEN_BY_FILE_ID flag checking.  I have a different
> > solution from the one I pushed today in the loop which probably
> > makesmuch more sense and is independent of the subtil difference
> > between loca and remote FS.
> 
> I don't understand the whole picture, so I may be missing the point.
> So I will report only the points I am sure of.
> 
> The file system on the host side is the local disk.
> In the container, it appears to be exposed as a ntfs local
> file system because unlink_nt() tries to use posix unlink semantics.

Right.  That and the fact that the filesystem characteristic don't have
the FILE_REMOTE_DEVICE flag set, as your getVolInfo output already
shows.  I could just have re-read your mail instead of asking redundant
questions, sorry!

I pushed a new Cygwin DLL, test release 3.5.0-0.251.gfe2545e9faaf.
This should do what we want, now.  If you can confirm, I'll push
your workaround afterwards.


Thanks,
Corinna

