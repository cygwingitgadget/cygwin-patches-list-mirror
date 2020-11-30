Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 5C2313877015
 for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020 14:04:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5C2313877015
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N01hu-1jwZJS1Ae6-00x1rl for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020
 15:04:36 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 9943EA8092D; Mon, 30 Nov 2020 15:04:35 +0100 (CET)
Date: Mon, 30 Nov 2020 15:04:35 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix access to block devices below /proc/sys.
Message-ID: <20201130140435.GH303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9c5f23af-ac11-3856-7aab-88dd1c184429@t-online.de>
 <20201130110344.GF303847@calimero.vinschen.de>
 <cd58c473-6aa4-b104-5909-5bd9ed6df1b1@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd58c473-6aa4-b104-5909-5bd9ed6df1b1@t-online.de>
X-Provags-ID: V03:K1:snGegBLT5UyctGxVSTRZBDWifI7vfFiN9F430KHLZDVOqLwilbz
 xwkdfIlT4MmwlbHJs5W7dWf195QNu0VX4XZJYjtd7X6KFqOBjSlXAODgnu2SXOIbnknQHhV
 42+cOkjXZp763salLNb+jZFxkh23/2nyHLyaUCBrsIkxfe6HN3xvChV3ifmtobE7kVHGROl
 /dYapgqk4eUGunfTaFf1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j/8mCk38Zyw=:1qHrpErabNNOtweIQiZjUE
 nCQaD5/1LXuDG5j5T6jRU9zTGx63g5vPFvB+bHFvYHyYN/PEXYeocIzjJgl6yxW4vLW22FI3x
 o6i3TDKMwjX4scQlHEGToCY92anWb51N3wzqyD2hJo5vnJl0qk/VXPlwwErL8CzXHWKZdvAfz
 uxwZdrNPI4Cu6ZcGw7MMiy1Ra2ZU5+uQVsUsYqQ2sKjEuYv7QhRiDM4QQrrweMZoaWXC8PmY3
 nYXGPAuiiOoPA+2+3niygaT0GUSJEQDtcIR6tGPfY0wbXSUMperK4n5/1ZvHomiA+1b1ekvQJ
 4sejhbhNCoD3hb5K0I2vKE80GizPvTjaICXuxFdyNt91W8isffe6lFeXjRV9G13LkyX9k5amR
 0xj0bjSJucI8q0SgSWmbsTZq3yeIpY62iuenzm0rn2hru7XJ+tJ+sTqViaZxQyDoCLCTwNZ+W
 tzxtDLnmTw==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 30 Nov 2020 14:04:40 -0000

On Nov 30 13:49, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On Nov 28 22:59, Christian Franke wrote:
> > > ...
> > > The attached experimental patch does not fix the lseek() (sorry), but
> > > handles such block devices with fhandler_dev_floppy instead. Tested with
> > > above use cases.
> > > 
> > > I'm not sure whether this could break access to other /proc/sys block
> > > devices. This would happen if fh->exists() returns virt_blk for devices
> > > which do not support IOCTL_DISK_GET_DRIVE_GEOMETRY* or
> > > IOCTL_DISK_GET_PARTITION_INFO*.
> > Pushed, becasue it's a nice idea.  The above problem shouldn't happen,
> > in theory, but I'm not sure.  virt_blk is generated for devices types
> > 
> >    FILE_DEVICE_DISK
> >    FILE_DEVICE_CD_ROM
> >    FILE_DEVICE_VIRTUAL_DISK
> >    FILE_DEVICE_DFS
> >    FILE_DEVICE_NETWORK_FILE_SYSTEM
> > 
> > FILE_DEVICE_DFS or FILE_DEVICE_NETWORK_FILE_SYSTEM might be a problem,
> > but there should be a way to workaround that, if necessary, isn't it?
> > Maybe it's a bad idea to treat those as blk devices at all?
> 
> Could anything be read from such a node? If yes, treat as character device?
> 
> If no and /proc/sys/foo/bar/some/path allows access to /some/path behind
> DFS/NFS node /proc/sys/foo/bar, then treat as directory?
> 
> This is already the case for SMB shares:
> 
> $ ls -ld /proc/sys/DosDevices/X:
> lr-------- 1 ... 0 Nov 30 13:10 /proc/sys/DosDevices/X: ->
>   /proc/sys/Device/LanmanRedirector/;X:..../127.0.0.1/Share
> 
> $ ls -lLd /proc/sys/DosDevices/X:
> drwxr-xr-x 1 ... 0 Nov 14 09:06 /proc/sys/DosDevices/X:
> 
> $ ls -L /proc/sys/DosDevices/X:
> ... files on this share

...and it's already the case for NFS shares, too:

$ ls -ld /proc/sys/DosDevices/Y:
lr-------- 1 corinna vinschen 0 Nov 30 14:59 /proc/sys/DosDevices/Y: -> /proc/sys/Device/MRxNfs/;Y:00000000001cb27f/...

$ ls -lLd /proc/sys/DosDevices/Y:
drwxr-xr-x 5 corinna vinschen 41 May 19  2016 /proc/sys/DosDevices/Y:

That means we don't have to handle FILE_DEVICE_NETWORK_FILE_SYSTEM in
the code creating the virt_blk device type at all.  I have high hopes
this is the same for DFS, albeit I can't test it...


Thanks,
Corinna
