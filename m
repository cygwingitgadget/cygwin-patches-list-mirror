Return-Path: <SRS0=IKhM=TC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 38A2C3858D33
	for <cygwin-patches@cygwin.com>; Mon,  9 Dec 2024 14:13:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 38A2C3858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 38A2C3858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733753635; cv=none;
	b=EO8KKYOpJ3P9nb0EarczZBewJZDHoC6hiUZsp8aRWqxPqhpRqBvl4ikmI0c2pyyH5VWABGT4/9ee/6jNuEHI8JE5NTQf997zt5SQ3Nsd1aPWNccEupti8K9MaMV5NeT/xtU5NmivSclxXYadjqNFUojW7LMlI46ZwHaNe59Iipk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733753635; c=relaxed/simple;
	bh=3JXmiTAoVU1pjC5/iM/3B4EER/9jbNtoMxDITU+T46M=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=pmuv4vzFcg4UELtbB8SOB2tJF9wuU3ycP0xc+3XDObGbNWVPPR30CfsH2iz7XTontinN1ihg9x6NAvb1km9njY2i1cI7bcLIHCspw4MikR9Z85Dx2tHw/hekEJEJ5J450JeBPAPmUmHHJKJNMYdMvTDE1ahpPOHEz/egVs1je4w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 38A2C3858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=euQRP3Wj
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20241209141353480.LVEU.33191.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 9 Dec 2024 23:13:53 +0900
Date: Mon, 9 Dec 2024 23:13:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: disk_file: Add error handling to
 fhandler_base::fstat_helper
Message-Id: <20241209231352.af7a0e0eef3bf4d7703f0649@nifty.ne.jp>
In-Reply-To: <Z1bezEg87t-BRgHU@calimero.vinschen.de>
References: <20241208074410.1772-1-takashi.yano@nifty.ne.jp>
	<Z1bezEg87t-BRgHU@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733753633;
 bh=Qr31i40YMWZxxe3+a7Jn2VkdGFn074Zc2kV1vjO7Xp0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=euQRP3WjLh6jq+4Sp2GNZR8aImYlYGw+R6ATwZruEje70YPsfgtAq3rNuKVj/+lQmWU2OFMt
 h8NERsQiebB/+71v+NgnS/62Z1szcM1cT/g4r6UY5LhDe+SKk0xOfh+YJ6VjCkOPP8K6N6oBk/
 5ZLSv0Hz/MIphHXlqvdItgA/43J4UAMC6Gxj75BeRwkrwRgfRbWh/JOKlRkNYd5IxABaMmzATv
 7LrxPMMCS9bae6a71y58zosdSy0yzViW51YjtX2lmTjCiHzB5l7XWkQWuH697PXYhtOJhOL2YU
 rZE36unNQSZsilwDWKtN1jF3E1BybuQEJI0uhBFGEYqBEoTQ==
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 9 Dec 2024 13:13:00 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Dec  8 16:43, Takashi Yano wrote:
> > Previous fhandler_base::fstat_helper() does not assume get_stat_handle()
> > returns NULL. Due to this, access() for network share which has not been
> > authenticated returns 0 (success). This patch add error handling to
> > fhandler_base::fstat_helper() for get_stat_handle() failure.
> > 
> > Fixed: 5a0d1edba4b3 [...]
>   ^^^^^
>   Fixes
> 
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/disk_file.cc | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/winsup/cygwin/fhandler/disk_file.cc b/winsup/cygwin/fhandler/disk_file.cc
> > index 2008fb61b..7c3c805fd 100644
> > --- a/winsup/cygwin/fhandler/disk_file.cc
> > +++ b/winsup/cygwin/fhandler/disk_file.cc
> > @@ -400,6 +400,11 @@ fhandler_base::fstat_helper (struct stat *buf)
> >    IO_STATUS_BLOCK st;
> >    FILE_COMPRESSION_INFORMATION fci;
> >    HANDLE h = get_stat_handle ();
> > +  if (h == NULL)
> > +    {
> > +      __seterrno ();
> > +      return -1;
> > +    }
> >    PFILE_ALL_INFORMATION pfai = pc.fai ();
> >    ULONG attributes = pc.file_attributes ();
> 
> This introduces a regression from the user perspective.
> 
> The underlying fstat functions were meant to return *something*, no
> matter how few information we got, as long as the file exists.
> 
> The reason is, for example, that Windows disallows to fetch stat(2)
> information on files you don't have permissions on. For instance,
> pagefile.sys.  On POSIX, you don't expect that stat(2) fails for these
> files, even if you can't access them in any other way.
> 
> So prior to your patch, ls doesn't fail on pagefile.sys:
> 
>   $ ls -l /cygdrive/c/pagefile.sys
>   -rw-r----- 1 Unknown+User Unknown+Group 2550136832 Dec  1 11:45 /cygdrive/c/pagefile.sys
> 
> The file exists, the stat(2) info is partially available.
> 
> After your patch:
> 
>   $ ls -l /cygdrive/c/pagefile.sys
>   ls: cannot access '/cygdrive/c/pagefile.sys': Device or resource busy

Indeed. This seems due to:
$ icacls 'c:\pagefile.sys'
c:\pagefile.sys: The process cannot access the file because it is being used by another process.
Successfully processed 0 files; Failed processing 1 files

So, it looks very natural to me that stat() fails.
However, it is very annoying that ls /cygdrive/c shows a lot of errors.

$ ls /cygdrive/c
ls: cannot access '/cygdrive/c/Config.Msi': Permission denied
ls: cannot access '/cygdrive/c/DumpStack.log': Permission denied
ls: cannot access '/cygdrive/c/DumpStack.log.tmp': Device or resource busy
ls: cannot access '/cygdrive/c/hiberfil.sys': Device or resource busy
ls: cannot access '/cygdrive/c/pagefile.sys': Device or resource busy
ls: cannot access '/cygdrive/c/swapfile.sys': Device or resource busy
ls: cannot access '/cygdrive/c/System Volume Information': Permission denied
'$GetCurrent'                      AMD                       ESD                    ProgramData                  Windows          gtk-build      vfcompat.dll
'$Recycle.Bin'                     BOOTNXT                   Microsoft              Qt                           appverifUI.dll   hiberfil.sys
'$WINDOWS.~BT'                     Config.Msi               'NVIDIA Corporation'    Recovery                     bootmgr          inetpub
'$WINRE_BACKUP_PARTITION.MARKER'  'Documents and Settings'   PerfLogs               Symbols                      cygwin           msys64
'$WinREAgent'                      DumpStack.log            'Program Files'        'System Volume Information'   cygwin64         pagefile.sys
'$Windows.~WS'                     DumpStack.log.tmp        'Program Files (x86)'   Users                        etaxSign         swapfile.sys
$ 

> Along these lines, if a share exists and is visible, stat(2) info should
> be available just the same as for pagefile.sys, even if you can't access
> the share otherwise.

This sounds reasonable, so I'd withdraw this patch.
Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
