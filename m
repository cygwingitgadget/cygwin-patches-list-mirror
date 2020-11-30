Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 9DFC738708B2
 for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020 11:03:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9DFC738708B2
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQeIA-1kVrbr0xl8-00NeMQ for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020
 12:03:45 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 86242A80D0E; Mon, 30 Nov 2020 12:03:44 +0100 (CET)
Date: Mon, 30 Nov 2020 12:03:44 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix access to block devices below /proc/sys.
Message-ID: <20201130110344.GF303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9c5f23af-ac11-3856-7aab-88dd1c184429@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c5f23af-ac11-3856-7aab-88dd1c184429@t-online.de>
X-Provags-ID: V03:K1:FEl9aPg7GhSf3+2GRi/zXtNlbyZhcgR6ndfB23XV7mgCa8QZzYi
 9zgDAKRfoZr8cXQoq7pzR311YyHXXxgmjKbDqilI62uUSybD3DAC4Ace5VqlD7X4LkbmWK0
 7l05qZL6pIkHXMssJgjC4WwH4+gCsLf4xPlUVv9Za2/Jp/soRwKRrdMo9u11YG4vVagcQ7V
 H50NhF5PIdBGFN/Elqc0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5fYNXBLhu3s=:wj4dJjEg4WgKr7W826snLQ
 Hu/huQxxxswvmvGL4W1Fkdoy8xGYEHD6wMrwOKmRHww1XMY6s2r6vqMKqlHJCR64rN5Pl4q3d
 lYX21lT6AXj2W6LqxBSgGta2x3XLupu44jgFdgEzL2/hxUfFGyqRXY8WYsgAqDsiR40D5EKEo
 jTy1VcJCe0E9vQy5ITt5URcn9z6R1PV8vmnk5txVOs6e3OAzWRExY05TGgOg8JzVJGWJAe2/a
 p5Z+Y9LPAZowvpXpgtsVgGsNjMX6HkAUz8aWYtLabqFYuNYC0eshlcoaLe2IMnFND0EoTX8nH
 yQ2f6gkYZTF3EjZ5+ZaCqccxsCyxyOsjbvgcLZ3Jw2FaW46Nl/zWix5rWgWyjbCos+m5CgLbl
 aVKDMzEjN6EQOCniMZ8cPQk3dxy6W5nvmrdfWOfC+h2r6vK8cCHzJkRSvWNYihxfR+7touX+F
 nGXZKA6d0Q==
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
X-List-Received-Date: Mon, 30 Nov 2020 11:03:48 -0000

On Nov 28 22:59, Christian Franke wrote:
> There a very few but occasionally interesting use cases for read access to
> block devices below /proc/sys:
> 
> - Read raw images behind drive letters which are not linked to regular
> /dev/sdXN partitions. For example read decrypted images of VeraCrypt
> partitions or container files:
> /proc/sys/DosDevices/X: -> /proc/sys/Device/VeraCryptVolumeX
> 
> - Read raw images of Volume Shadow Copies:
> /proc/sys/Device/HarddiskVolumeShadowCopy*
> 
> Copying such an image actually works with 'dd', but 'ddrescue' reports a non
> seekable device. This is because fhandler_virtual::lseek() is used. It calls
> fhandler_procsys::fill_filebuf() which does not make any sense in this
> context. This lseek() always fails - without setting errno, BTW.
> 
> The attached experimental patch does not fix the lseek() (sorry), but
> handles such block devices with fhandler_dev_floppy instead. Tested with
> above use cases.
> 
> I'm not sure whether this could break access to other /proc/sys block
> devices. This would happen if fh->exists() returns virt_blk for devices
> which do not support IOCTL_DISK_GET_DRIVE_GEOMETRY* or
> IOCTL_DISK_GET_PARTITION_INFO*.

Pushed, becasue it's a nice idea.  The above problem shouldn't happen,
in theory, but I'm not sure.  virt_blk is generated for devices types

  FILE_DEVICE_DISK
  FILE_DEVICE_CD_ROM
  FILE_DEVICE_VIRTUAL_DISK
  FILE_DEVICE_DFS
  FILE_DEVICE_NETWORK_FILE_SYSTEM

FILE_DEVICE_DFS or FILE_DEVICE_NETWORK_FILE_SYSTEM might be a problem,
but there should be a way to workaround that, if necessary, isn't it?
Maybe it's a bad idea to treat those as blk devices at all?


Thanks,
Corinna
