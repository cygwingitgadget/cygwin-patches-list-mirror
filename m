Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by sourceware.org (Postfix) with ESMTPS id 428223858C50
	for <cygwin-patches@cygwin.com>; Sat, 18 Mar 2023 11:18:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 428223858C50
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MbRXd-1qETEB1tJR-00bu7K; Sat, 18 Mar 2023 12:18:50 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1C0BDA80B9A; Sat, 18 Mar 2023 11:01:23 +0100 (CET)
Date: Sat, 18 Mar 2023 11:01:23 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Message-ID: <ZBWL85hJIlbZHc/D@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Yoshinao Muramatsu <ysno@ac.auone-net.jp>
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
 <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
X-Provags-ID: V03:K1:9btx7kmiTeoJYZ6iBJsMF3ZNsexzvqldORUsKe+e2GDQRE+gJkV
 OFvAaukJxItdRCz4H19Ca+g6H++emmQQhfdj5HA5/6dQnvEMYewL8xJ8KzSsyqo3RHyMoi1
 pnW4+7Hy2TAak1y4T0wTlBhYB3m5x+V9/JHD4iUMuUK2RlxnAikjcKppxbsDN0USnki1nj6
 cBurzOsrae8KnYBR7td2g==
UI-OutboundReport: notjunk:1;M01:P0:3iQc7OArlrk=;2rYKOMGvL70D407laCZ07AgF7nN
 p0FQ7VvuSlT5Hy7/xQjJWD7KD0MZtdeCKV2M8SAQT7G1ATyHlvsa2Q8/plmYuZx4OuQRssYYE
 6RilK7a2Z8A3TiICHy760myXJQuIbSmJNzd8jfUP66RAuYTHzNOsYKlS4kS2JSV0vokdBKWSe
 mt2yU/L7KrJo6c/2BIsZnG3cp5v1bm0F/lnuXKfZX4qEdBgnTZ7dwkxbInJBc5mPy6EBbWKBM
 jwtTS7GA0FrvuQZe3RmqsqA9CdI6bl6cq8Yh1UpkqWuvJnOz7aT/D/xXvYY7gKFylTCU1ObnW
 t1WtuEoUTIE6pXEMfW/tZTHTh6pQVqtGNuUmRHHRgBaPnNyFTGis7XpLWZpe+w5FeMU4YEANS
 JMieSkkPQdDzvybU4ig/F2OsLrLWjTydk3eNeU68jVDermWiVSB+PaKPPwZmzWCNCM2AZ1Ne+
 QngNiGCICT2F7sFwDpvZPnt0SQI3Gru6tpfbK9P+zvHtfZhH6DuI2SZUX1lgPFXHpfsShBoQm
 GWLJdVfwerjAPd/wm4FOvQp8pcdODB1vL4dUqdn9+4lTinBiFpAHtFnMd/cGRRCl1A6ENWkzz
 abZ9M9YlnmMlM7BFI+VOQeV4HD8mmBB6nGNaKY2u8gGagywCR8FlYZM7HiWGGqxOEhMna3Bvt
 kSbR8o0gAzJUvaRPZDhBcAbyd9bnc9aw6DrtA6k5YQ==
X-Spam-Status: No, score=-97.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Yoshinao,

On Mar 18 14:29, Yoshinao Muramatsu wrote:
> Hi Corinna.
> I'm Yoshinao Muramatsu. Thank you for your thoughtful guidance.
> I have not modified the patch yet,
> but I have made some observations and post the results.
> 
> I forgot to mention in my first post that there is a workaround
> for this issue, which is to use process isolation unless
> hyper-v isolation is absolutely necessary
> (mainly caused by build number difference between host and container).

Ok, but that's a propoerty we'll never be able to test.

> In the logs, here we can find some differences.
> But I believe it is unclear if it will always be so.
> If additional inspections are done, they will be costly.

Assuming we can pull some information from the filesystem flags, the
cost is negligible.  We just check bits in a filesystem bitmask.

> I would also like to see better support for POSIX unlink/rename
> semantics in the container mechanism.

Yeah, but... do you have high hopes?

Assuming we can fetch useful info from the filesystem flags, we could
basically do both, add your patch to have a workaround in case the
Windows call returns INVALID_PARAMETER, and an early test for a FS
flag which can be used down the road to avoid the workaround.

> Therefore, I think it is not a bad idea to simply retry rather than spending
> time every time to check the conditions to deal with rare situations.
> However, in certain situations it happens all the time.
> (So if we can cache it that would be great.)
> But performance in the vast majority of other situations is more important.

The filesystem info is cached, so the filesystem flags are only checked
the first time we open a file on the filesystem.

> In the following logs, c:\ is the normal ntfs volume in the container,
> andc:\opt is the volume of the bind mounted host.
> Where the differences are
> - 0x00000020 Supports Disk Quotas
> - 0x01000000 Supports Open By FileID
> - 0x02000000 Supports USN Journal

I just updated the csih package to 0.9.13.  The getVolInfo tool
now prints *all* known filesystem flags.

> == hyper-v container (has issue)
> $ mount
> C:/cygwin64/bin on /usr/bin type ntfs (binary,auto)
> C:/cygwin64/lib on /usr/lib type ntfs (binary,auto)
> C:/cygwin64 on / type ntfs (binary,auto)
> C: on /cygdrive/c type ntfs (binary,posix=0,user,noumount,auto)
> 
> $ /usr/lib/csih/getVolInfo.exe /cygdrive/c/
> Device Type        : 7
> Characteristics    : 20020
> Volume Name        : <>
> Serial Number      : 3456656850
> Max Filenamelength : 255
> Filesystemname     : <NTFS>
> Flags              : 1c706df
> ...snip...
> 
> $ /usr/lib/csih/getVolInfo.exe /cygdrive/c/opt/
> Device Type        : 7
> Characteristics    : 20020
> Volume Name        : <>
> Serial Number      : 955187689
> Max Filenamelength : 255
> Filesystemname     : <NTFS>
> Flags              : 2c706ff
> ...snip...

This is disappointing.  One of the newer filesystem flags is
0x400, FILE_SUPPORTS_POSIX_UNLINK_RENAME.  As you can see,
the flag is set.  But the POSIX functionality doesn't work
here, right?

However, what's really curious here is the fact that the
FILE_SUPPORTS_OPEN_BY_FILE_ID flag is missing.

NTFS always supports this since Windows 2003!  So we could
use this flag as indicator that, probably, POSIX rename/unlink
won't work.


Corinna
