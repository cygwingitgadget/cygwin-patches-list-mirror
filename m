Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id A9D823944826
 for <cygwin-patches@cygwin.com>; Tue,  1 Dec 2020 19:37:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A9D823944826
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Ml72g-1kKmL10SgG-00lU76 for <cygwin-patches@cygwin.com>; Tue, 01 Dec 2020
 20:36:59 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 3EE66A80D13; Tue,  1 Dec 2020 20:36:58 +0100 (CET)
Date: Tue, 1 Dec 2020 20:36:58 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix access to block devices below /proc/sys.
Message-ID: <20201201193658.GO303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9c5f23af-ac11-3856-7aab-88dd1c184429@t-online.de>
 <20201130110344.GF303847@calimero.vinschen.de>
 <cd58c473-6aa4-b104-5909-5bd9ed6df1b1@t-online.de>
 <20201130140435.GH303847@calimero.vinschen.de>
 <20201130142123.GI303847@calimero.vinschen.de>
 <c07b35fb-525f-0744-0297-af49aa219cdd@t-online.de>
 <20201201160455.GN303847@calimero.vinschen.de>
 <46d31f81-d077-b088-6e07-3684582f666d@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46d31f81-d077-b088-6e07-3684582f666d@t-online.de>
X-Provags-ID: V03:K1:3Ypnzlh6MJtI8me6EVRyW59J1lWg8mdOySL2R+P3kiRJXXbks9i
 ZsaW+pV89KvstKtn6oZW0ecDxUjOxySFb1IVrwLizqiGo3TKgwE+uqa05rE/UI5cM+UWoR+
 7DFc3tl5iL5ZWqw0pqv9jdqWVxeh6tglaF94XyV/JQmgJpxkC6gAqq0no9kXZRpOIQssrSK
 V+JYb1p0puETmZXGZm0Kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:heD6R0TopbQ=:i1EXz1ofY6/lqy1Tfnz/JR
 MJVNPFJFLdbiYcUyD6dDEPRiZGy0mBeZvOKxWeL6uO+ddmvh8iLcxQp2pG0BWlZZYz4iTwCsm
 YVLYcM3CsqpH2GbScIYvDszkPYvt9hhZGxUDkrmq4KqbB8V9b8/GqT8N+ME+FgSfLMjCsXqdC
 ulcJgeL0J1OEDra/Ik4100/qFi1puSgGVMR2IebkVbCqVIphmPgQ43B/e2lbrCeueFXKYjtfv
 lS9UQOV2Su16Y0CkMmX4RHVp5G3dCcb/FDVK39tPdX/fcKLQhpH194rpLyTmDmBGLfmSFmQZ2
 h2WC29fouYyMw1gZG16pa/OZde2UmcwdcDj3YGvLwRSSSJW/1IxByOG0YEEi2GIEOk3wufQT+
 V75SWv+c31L9FmdGXIYBw0tCI0alzGzMnoUtl2wilxBPYASEmXTkPJ8JTmCTH9E9tLXtRvzUU
 vVF0o0OiZw==
X-Spam-Status: No, score=-99.3 required=5.0 tests=BAYES_00, BODY_8BITS,
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
X-List-Received-Date: Tue, 01 Dec 2020 19:37:02 -0000

On Dec  1 19:48, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On Dec  1 16:59, Christian Franke wrote:
> > > Corinna Vinschen wrote:
> > > > \Device\Mup is a character device and thus the devices below are not
> > > > accessible for directory enumeration.  I assume it's the same for DFS.
> > > Here I see \Device\Mup as a block device on two systems (cygwin1.dll 3.1.7):
> > > 
> > > $ ls -l /proc/sys/Device/Mup
> > > brwxrwx--x 1 Administrators SYSTEM 0, 250 Dec  1 16:50 /proc/sys/Device/Mup
> > Huh?
> > 
> > $ ls -l /proc/sys/Device/Mup
> > crwxrwx--x 1 Administrators SYSTEM 0, 250 Dec  1 17:04 /proc/sys/Device/Mup
> > 
> > This is what I'd expect.  Can you debug why this is a block device
> > on your systems?
> > 
> 
> NtQueryVolumeInformationFile() returns {DeviceType = 0x14, Characteristics =
> 0x20010}
> 
> fhandler_procsys::exists(...):
> ...
>   status = NtOpenFile (&h, READ_CONTROL | FILE_READ_ATTRIBUTES, &attr, &io,
>                   FILE_SHARE_VALID_FLAGS, FILE_OPEN_FOR_BACKUP_INTENT);
> ...
>   if (NT_SUCCESS (status))
>     {
>       FILE_FS_DEVICE_INFORMATION ffdi;
> ...
>       /* Check for the device type. */
>       status = NtQueryVolumeInformationFile (h, &io, &ffdi, sizeof ffdi,
>                          FileFsDeviceInformation);
> ...
>       if (NT_SUCCESS (status))
>       {
>         if (ffdi.DeviceType == FILE_DEVICE_NETWORK_FILE_SYSTEM)
>           file_type = virt_blk;  <<===============
>        ...


Uh... ok, that's what had changed with commit 80e35a211f69 as of
this morning :}


Corinna
