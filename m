Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by sourceware.org (Postfix) with ESMTPS id 298DF3858413
	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2023 14:51:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 298DF3858413
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRk8w-1q2vEl1imY-00TFdt; Mon, 20 Mar 2023 15:51:25 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1C5CAA80BBE; Mon, 20 Mar 2023 15:51:24 +0100 (CET)
Date: Mon, 20 Mar 2023 15:51:24 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Message-ID: <ZBhy7E4vKHTRNW6k@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Yoshinao Muramatsu <ysno@ac.auone-net.jp>,
	cygwin-patches@cygwin.com
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
 <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
 <ZBWL85hJIlbZHc/D@calimero.vinschen.de>
 <608a78b6-f523-14f1-333d-f59e9f2bb8d5@ac.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <608a78b6-f523-14f1-333d-f59e9f2bb8d5@ac.auone-net.jp>
X-Provags-ID: V03:K1:8UyWdDlxHAqzutRKL6/TPEIUFf8T13rKfJWyuQwrkxQpaXILVjp
 HgxrY+xGksZ1sjMXTfM/RoF3ML4t3lQbm9vaCPz8XagodjO4h2Iv9HSB2Fq21aF9HMQTg8A
 0pXsH26rqjfWf0k5p1+vA3A9ViQtNobZF7URyWVzZl3hKyK+GgpDIFQWHARlH0VY9mj6N+a
 WGN+e5lBEKTTjlpsQ27eA==
UI-OutboundReport: notjunk:1;M01:P0:fpIat9+FtPY=;C8hgaoacPoJxPoyWkZn5jaxoPkc
 u1hnwURaMTl9p4Qx8F2gjdikBSGBgoJZw7AmzqHEx3CtvWimOXn2B7GOkjhyam2AG23FIvF8I
 wP453qNt9t+zZ0TJqyLNCTORrmHnGIV/OraVHgJIOTq76RQZeTYFpbB3FWyd843BGbuW6TrvO
 bBxG+yyjDWQKCPbfuTGkHJuvwrbMMYJB71EuGERPYCw44R7hAVoTbJEflT/ZQfRk+RchDyEG4
 JBjFZbBIbDqh1/hu+Zjf3x021j3AHsOGvojuzos1PblafNzIWqtL6mU5azfoQmKSn/rRnxbNv
 buUowHaKZz56U3WRUngKgHdUtINAOX/63RzSwxryHBVhrqV1ZVq1mlr1md2gPORXB0TXAVEdL
 pmjRo4fv/ex3D7e5/z2B6uWuOABs1FUgbFAJqM820FHvrArOvzYBDGs2Tw0jCFeCljkjn/ADp
 AExObYdbeW+XI84UiAhPnUKKozyhcAYSUbz5ROO0DBQKtSBzVClbyqW2lXGIYr7pKMZS6sqmS
 uy5WnGhXSWqM5AYTvkoyntcWi5ThuoKwjn3cggSHYgl5/qj5baYOxD/cyNhWvTl2bVe3mopM1
 /+8IxjHBu0so5IJK/MZfr4PYgZpjlg75Rb5TQ3ZnFuU5TRVZtavB9QzVMQrPm75n5CxC4tGrl
 7vZcZlgLNN+DCnH73MUs8aBDG6HLZK0uDhBBkLKpcw==
X-Spam-Status: No, score=-97.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mar 20 22:06, Yoshinao Muramatsu wrote:
> On 2023/03/18 19:01, Corinna Vinschen wrote:
> > FILE_SUPPORTS_OPEN_BY_FILE_ID flag is missing.
> > 
> > NTFS always supports this since Windows 2003!  So we could
> > use this flag as indicator that, probably, POSIX rename/unlink
> > won't work.
> 
> I thought that if there was no FILE_SUPPORTS_OPEN_BY_FILE_ID
> and OpenByFileId() worked, it would be a Signature,
> but the result was different.
> 
> I tested OpenByFileID() on a bind-mounted directory, it was failed.
> Maybe it's because of the path isolation.
> ltsc2022 process isolation says "I support it" but it not works.
> Okay, it's not a security issue. So now I'm writing this here.
> 
> Unfortunately, the state of the FILE_SUPPORTS_OPEN_BY_FILE_ID flag
> does not match the actual behavior, so I fear it may be corrected.

Actually, it doesn't matter if open by fileID works.  The fact that
this flag is missing *is* a pattern we can use.  It allows us to
distinguish the hyper-v isolated NTFS from a standard NTFS and thus,
we can immediately do the right thing.

> ps
> Corinna, I read the new email about fs_info::update patch
> you posted while I was writing this.
> I will report back when I test it, but it may take some time
> as I usually use msys2 and don't have a cygwin development environment.

No worries!


Corinna
