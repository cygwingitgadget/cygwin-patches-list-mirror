Return-Path: <SRS0=7Ga2=FM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 589EE4BA2E14
	for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2026 10:23:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 589EE4BA2E14
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 589EE4BA2E14
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784370210; cv=none;
	b=TzDrMGMJVVcQ+J47j1v0pUUgBby+CMq2pjhgRUPXura5264eBlwveRZXDOaRNCSZcAxnBZ0myeNezAA3/Z2JeIzqlpBdRtVo9ykPoM4QRt5P0SpD5Ax6NWPl7oE4XX4Zzjy4pvKDCjQiqJrkU0RmGZiVFe+jrBRpIB935dsXr6w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784370210; c=relaxed/simple;
	bh=FNmS2FRlYDm+DuIHVmnm/+KJysoYLzULyF72yQIXkrE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=NcaYxaagcM6JJKsoJOSx1t/lLExlD8cj95ot0/nqG2ltq6WFIWkmJEyFOn6PJ+4GJirI2vs7LJ8suh5Q+Q2QhMSv8kzOXFflopUEjX9XhvfAYNfUFLJ+LZtiSUYuyibXGTuvDZSzQlHZp5j4DvqMHNkbbtVpm3V1TnCe5KN31o4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=QPJzz9Ef
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 589EE4BA2E14
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=QPJzz9Ef
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260718102325506.BYUK.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2026 19:23:25 +0900
Date: Sat, 18 Jul 2026 19:23:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: open: Unlock fdtab before open_with_arch()
Message-Id: <20260718192323.22154d67d4f9f6a73cc5385e@nifty.ne.jp>
In-Reply-To: <Pine.BSF.4.63.2607172308470.20466@m0.truegem.net>
References: <20260717031021.1537-1-takashi.yano@nifty.ne.jp>
	<Pine.BSF.4.63.2607162324080.95488@m0.truegem.net>
	<20260717201812.5d42df17e6c8e5d846ec0574@nifty.ne.jp>
	<Pine.BSF.4.63.2607172308470.20466@m0.truegem.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784370205;
 bh=jnkp+yiO1OIT53HnU2UHo2rjcJmeKSz8wxrbbeOHDxM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=QPJzz9EfQY1CwNJloymo7VfADGs2BFYf51IXIJKdEe5G9Vvwgm2Mu1ihezncs3rsmjJPJJY/
 5dp02G1LOF+W2oeXFk0wFHQTUlu8bNhng12v1HXsMawSGj7Soku2uY0QFbbaNCqzHxoKs3n/C4
 xKfhDl3VzzXYt9hweePxxgYQUshgyp+9lXoFBEpS9dl82iRjxyJ5lFMwS3DNd3c2arTw6sH4hB
 oQYDDyjK06XkiGTaD8xiRYA55tO1xcH1+GI31p6bOgZM97EuDXSUQjBwGryduWPU/nrWWI1JLx
 4PfcST64F16gfTm1NHAES52vzVGGzhYgdiMS8gnlD+WuEywg==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Fri, 17 Jul 2026 23:16:46 -0700 (PDT)
Mark Geisert wrote:
> Hi Takashi,
> I agree with your comments on my comments. As a check against regression, 
> could you please run Christian's OPEN_MAX STC on your patched system when 
> you have a chance?  Here's the STC in case you don't have it...
> ----8<----
> #include <errno.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <sys/stat.h>
> 
> 
> int main()
> {
>     for (int i = 0; i < 10000; i++) {
>       char name[32];
>       snprintf(name, sizeof(name), "file-%04d.tmp", i);
>       errno = 0;
>       int fd = open(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
>       if (fd >= 0)
>         continue;
>       printf("open(%s, ...)=%d (errno=%d)\n", name, fd, errno);
>       struct stat st;
>       printf("stat(%s, ...)=%d\n", name, stat(name, &st));
>       break;
>     }
>     return 0;
> }
> ---->8----
> Success is indicated by a report of error 24 when attempting to create 
> file-3197.tmp. Don't forget to delete the 3196 file-*.tmp files after.

Actually, I already tested Christian's test case and got:
open(file-3197.tmp, ...)=-1 (errno=24)
stat(file-3197.tmp, ...)=-1


> If that test works your patch is GTG as far as I'm concerned. I believe it 
> should go to both 3.6.11 and 3.7.0.

Will do. Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
