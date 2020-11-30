Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id E4AD638708C4
 for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020 14:21:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E4AD638708C4
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MZk1p-1kewHD1TCZ-00Wl1g for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020
 15:21:24 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id DDD3AA80D1D; Mon, 30 Nov 2020 15:21:23 +0100 (CET)
Date: Mon, 30 Nov 2020 15:21:23 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix access to block devices below /proc/sys.
Message-ID: <20201130142123.GI303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9c5f23af-ac11-3856-7aab-88dd1c184429@t-online.de>
 <20201130110344.GF303847@calimero.vinschen.de>
 <cd58c473-6aa4-b104-5909-5bd9ed6df1b1@t-online.de>
 <20201130140435.GH303847@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201130140435.GH303847@calimero.vinschen.de>
X-Provags-ID: V03:K1:awSM01uuwdCkoqAJlDHcQk8zAhoyc+wRUvaXmCtGfDxJZ6M1a1J
 jrrmAYDmSEYxGaPRREBGnUw6Tq86xkEPa5QAx6S14UjxrXRL3PxPcNVmQlXe/5rXhf6US+6
 AdQaPYQWHbEbitHKO2XFEMX38/WKzOYmWLlXlkfDnkb2ApG3TKXgZilQG8vW1mLBzJm1AVp
 hFWt17letF1KddlpnKllQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UbFXRMQeFCA=:hSZeF1jj2XsoA09jB+q1Fg
 /3e8xqtLkOuZBVcNOaE8rnjEhPnsEgzkk8OCdAuIvEriPpqoC5uStexn4RY3z3boF8ZVw0A43
 otWa8zhHaEVxCs8XrwIfUB2DMaUiFx2frhq0WX5RPp3ESAitY6co2oIpzRt63xOYXTgHiKRN/
 H8i4Oa4RRVKMBmJ8Fu3Fv5+op4Ci1nBdrfxipb0KlM5WXE4fB5QdS7U7tcXasEwFX/XbkRqv2
 phNta8a/6tjcMtSTwQUOnF96+YQYsUKGoJv5jSbc6nWs30zJ/ffS6VHxG+nizqy8iNM+LNSvb
 cDLPGJWGrI7+ScgiZzgJY42M7xvqEXr+wq9yBD0khr45V2OT0+TynPuwLLxUJI5u2fHCPTxMH
 kqHxR+qNKbmy+YxlHO88419I955zc+BUngjSge2PL8k7MlwEA+1UetH1cxbCpSLEOwPVulW94
 gqbWxEWAqQ==
X-Spam-Status: No, score=-100.6 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 30 Nov 2020 14:21:27 -0000

On Nov 30 15:04, Corinna Vinschen wrote:
> On Nov 30 13:49, Christian Franke wrote:
> > Corinna Vinschen wrote:
> > > On Nov 28 22:59, Christian Franke wrote:
> > > > ...
> > > > The attached experimental patch does not fix the lseek() (sorry), but
> > > > handles such block devices with fhandler_dev_floppy instead. Tested with
> > > > above use cases.
> > > > 
> > > > I'm not sure whether this could break access to other /proc/sys block
> > > > devices. This would happen if fh->exists() returns virt_blk for devices
> > > > which do not support IOCTL_DISK_GET_DRIVE_GEOMETRY* or
> > > > IOCTL_DISK_GET_PARTITION_INFO*.
> > > Pushed, becasue it's a nice idea.  The above problem shouldn't happen,
> > > in theory, but I'm not sure.  virt_blk is generated for devices types
> > > 
> > >    FILE_DEVICE_DISK
> > >    FILE_DEVICE_CD_ROM
> > >    FILE_DEVICE_VIRTUAL_DISK
> > >    FILE_DEVICE_DFS
> > >    FILE_DEVICE_NETWORK_FILE_SYSTEM
> > > 
> > > FILE_DEVICE_DFS or FILE_DEVICE_NETWORK_FILE_SYSTEM might be a problem,
> > > but there should be a way to workaround that, if necessary, isn't it?
> > > Maybe it's a bad idea to treat those as blk devices at all?
> > 
> > Could anything be read from such a node? If yes, treat as character device?
> > 
> > If no and /proc/sys/foo/bar/some/path allows access to /some/path behind
> > DFS/NFS node /proc/sys/foo/bar, then treat as directory?
> > 
> > This is already the case for SMB shares:
> > 
> > $ ls -ld /proc/sys/DosDevices/X:
> > lr-------- 1 ... 0 Nov 30 13:10 /proc/sys/DosDevices/X: ->
> >   /proc/sys/Device/LanmanRedirector/;X:..../127.0.0.1/Share
> > 
> > $ ls -lLd /proc/sys/DosDevices/X:
> > drwxr-xr-x 1 ... 0 Nov 14 09:06 /proc/sys/DosDevices/X:
> > 
> > $ ls -L /proc/sys/DosDevices/X:
> > ... files on this share
> 
> ...and it's already the case for NFS shares, too:
> 
> $ ls -ld /proc/sys/DosDevices/Y:
> lr-------- 1 corinna vinschen 0 Nov 30 14:59 /proc/sys/DosDevices/Y: -> /proc/sys/Device/MRxNfs/;Y:00000000001cb27f/...
> 
> $ ls -lLd /proc/sys/DosDevices/Y:
> drwxr-xr-x 5 corinna vinschen 41 May 19  2016 /proc/sys/DosDevices/Y:
> 
> That means we don't have to handle FILE_DEVICE_NETWORK_FILE_SYSTEM in
> the code creating the virt_blk device type at all.  I have high hopes
> this is the same for DFS, albeit I can't test it...

Oh, right, I just realized that \Device\MRxNfs, as well as
\Device\LanmanRedirector are symlinks pointing below \Device\Mup:

$ ls -l /proc/sys/Device/LanmanRedirector
lr--r--r-- 1 Administrators SYSTEM 0 Nov 30 15:20 /proc/sys/Device/LanmanRedirector -> /proc/sys/Device/Mup/;LanmanRedirector

$ ls -l /proc/sys/Device/MRxNfs
lr--r--r-- 1 Administrators SYSTEM 0 Nov 30 15:20 /proc/sys/Device/MRxNfs -> /proc/sys/Device/Mup/;MRxNfs

\Device\Mup is a character device and thus the devices below are not
accessible for directory enumeration.  I assume it's the same for DFS.


Corinna
