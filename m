Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	by sourceware.org (Postfix) with ESMTPS id 87B0A3858D32
	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2023 20:37:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 87B0A3858D32
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Ma1D8-1q1RX10c7g-00VvO8; Mon, 20 Mar 2023 21:37:11 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7770CA80BBE; Mon, 20 Mar 2023 21:37:09 +0100 (CET)
Date: Mon, 20 Mar 2023 21:37:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Message-ID: <ZBjD9exM9ZBGDzK3@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Yoshinao Muramatsu <ysno@ac.auone-net.jp>,
	cygwin-patches@cygwin.com
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
 <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
 <ZBWL85hJIlbZHc/D@calimero.vinschen.de>
 <608a78b6-f523-14f1-333d-f59e9f2bb8d5@ac.auone-net.jp>
 <ZBhy7E4vKHTRNW6k@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBhy7E4vKHTRNW6k@calimero.vinschen.de>
X-Provags-ID: V03:K1:gDLvjhY4DCXtchC05TuILxQWZHn7UmybTLk1Wz/pPa3JXugGUG1
 DQp8uxAWmebyPAhmT1e2L3I+7IyO9coxajKgIQwaAB3x6exhAit4xYiCHM92/p8kBvw7hgA
 fl00fbeE8Sr7tTljufLSn4yJpjhc/k2ftlsDcNEwjRUQicBucyQDLJ2kNEBLF3p895sDNSl
 TRvKxh08gXkCEfBoHKMzA==
UI-OutboundReport: notjunk:1;M01:P0:mDF3ifuxqqI=;7nUQRswrL/sUoewUH6c+qlelw0o
 wnt5wgvrrdtZOUtbkr8n3eFtkwZMmgmXpiNQvUsj9KkThI7odc7GUnIGCIYz+cKH4Ao84bQ6w
 TXvhz+j2L37HaiYGy7mLQIcGYxsI69bj/RvHjdTEwPtJt1Gc7nAsTQxKAKjoh1cowGGWQaEPC
 wypsPZ6z68RX0MCZRW9NYUAUUN4ZpbOcuftArGOIUzlJlR7Zp0kwELrPA4fJrcaYGk/6LzP5S
 SxvEq+jWg/4u8Xxyl+usmAVHHDmcDRzf/I3syU2RtAhjAlKreRiSSz+O1qovzVWYQG70T7XgH
 zJCL1vQYffj75bjHpaNO7BWaUAL0PIqn47rWY8YwhOHkIAEc3WU3nRbSlG0LaRpbJDYiKh3xS
 U3dfTfpGHHE3y/6l+hKt6fiNC7FR4MkPoSTZGFq7OXjTvdsUMS4144QJEP3A5d4qHNyqHW/CM
 gcVpQsiOqPDrlGuSg3M49pBJ8yH897CPNftb4+Ig1FX5IrU8AVXM9al02MR8/gGKMPbO7VQLE
 +X/3u6tcx+BgC3zc3xCmSZh0Z7mMFJYfYLQfJqdWxeiHJDP/qiCqPsGDDCavl3gaHIqYA3M+V
 V7/YKDWnd/xz8eS9LHYQLnig+2DQucXR2cQkz9gwTe+8mjXjRY0p13dW8OK9FsKZewV8WkcTs
 Z4cLBsQaTRT7ZKSiOl3jiLNH2w/u7THuN8YsCTa3bg==
X-Spam-Status: No, score=-97.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mar 20 15:51, Corinna Vinschen wrote:
> On Mar 20 22:06, Yoshinao Muramatsu wrote:
> > On 2023/03/18 19:01, Corinna Vinschen wrote:
> > > FILE_SUPPORTS_OPEN_BY_FILE_ID flag is missing.
> > > 
> > > NTFS always supports this since Windows 2003!  So we could
> > > use this flag as indicator that, probably, POSIX rename/unlink
> > > won't work.
> > 
> > I thought that if there was no FILE_SUPPORTS_OPEN_BY_FILE_ID
> > and OpenByFileId() worked, it would be a Signature,
> > but the result was different.
> > 
> > I tested OpenByFileID() on a bind-mounted directory, it was failed.
> > Maybe it's because of the path isolation.
> > ltsc2022 process isolation says "I support it" but it not works.
> > Okay, it's not a security issue. So now I'm writing this here.
> > 
> > Unfortunately, the state of the FILE_SUPPORTS_OPEN_BY_FILE_ID flag
> > does not match the actual behavior, so I fear it may be corrected.
> 
> Actually, it doesn't matter if open by fileID works.  The fact that
> this flag is missing *is* a pattern we can use.  It allows us to
> distinguish the hyper-v isolated NTFS from a standard NTFS and thus,
> we can immediately do the right thing.
> 
> > ps
> > Corinna, I read the new email about fs_info::update patch
> > you posted while I was writing this.
> > I will report back when I test it, but it may take some time
> > as I usually use msys2 and don't have a cygwin development environment.
> 
> No worries!

Wait.  I might have misunderstood something.  This is about accessing a
host NTFS from inside a Hyper-V isolated process, right?  So from the
point of view of the Hyper-V isolated Cygwin process, the NTFS
filesystem is a *local* filesystem?  Or is it mapped as a remote
filesystem?

The difference is important, because my patch would only change the
outcome if the Cygwin process in the Hyper-V container gets the
NTFS filesystem presented as a remote filesystem.

I noticed this problem when I was looking into implementing the
FILE_SUPPORTS_OPEN_BY_FILE_ID flag checking.  I have a different
solution from the one I pushed today in the loop which probably
makesmuch more sense and is independent of the subtil difference
between loca and remote FS.


Corinna
