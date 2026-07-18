Return-Path: <SRS0=Y8Ds=FM=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 31DA84BA2E07
	for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2026 06:02:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 31DA84BA2E07
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 31DA84BA2E07
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784354525; cv=none;
	b=WDcBF8RkADPT9dUnRwALEAdR6oLXIBWA8idkdqNHTp9GYP9ZFadocNrZ6FsbAG3CwzHKsCEzYBFwLPkAwFqTvzkEBeF9n679guW1nCmjs7nVi7Q/JhG7jVPJX6UHrNo+Pz/XW7wTNxt0Ram9+j/c7WPCJST0AYoDZmGhteiLGco=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784354525; c=relaxed/simple;
	bh=MfDoyguwfCuhlxbRXIghO3ZbmB8u+L+qdsykpc6aS4s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version; b=ODAf+XDFHO8UJFy6CFlBzYwCcka3ceEyYH+mLywDroQPlmK66ABhN0aK27xicxAIiFzelN3HrfK+ppFLhXSrj+9PLDrp4yKwSoBvxzBwuMYOrSkelHvCY+PGAmhZWajRZEl2SaDyX2bRbMrDId+qqHeOjeEKKWDmTguJPSg2XxU=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 31DA84BA2E07
Received: from localhost (mark@localhost)
	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id 66I6GkKQ021780
	for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2026 23:16:46 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
X-Authentication-Warning: m0.truegem.net: mark owned process doing -bs
Date: Fri, 17 Jul 2026 23:16:46 -0700 (PDT)
From: Mark Geisert <mark@maxrnd.com>
X-X-Sender: mark@m0.truegem.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: open: Unlock fdtab before open_with_arch()
In-Reply-To: <20260717201812.5d42df17e6c8e5d846ec0574@nifty.ne.jp>
Message-ID: <Pine.BSF.4.63.2607172308470.20466@m0.truegem.net>
References: <20260717031021.1537-1-takashi.yano@nifty.ne.jp>
 <Pine.BSF.4.63.2607162324080.95488@m0.truegem.net>
 <20260717201812.5d42df17e6c8e5d846ec0574@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,
I agree with your comments on my comments. As a check against regression, 
could you please run Christian's OPEN_MAX STC on your patched system when 
you have a chance?  Here's the STC in case you don't have it...
----8<----
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>


int main()
{
    for (int i = 0; i < 10000; i++) {
      char name[32];
      snprintf(name, sizeof(name), "file-%04d.tmp", i);
      errno = 0;
      int fd = open(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
      if (fd >= 0)
        continue;
      printf("open(%s, ...)=%d (errno=%d)\n", name, fd, errno);
      struct stat st;
      printf("stat(%s, ...)=%d\n", name, stat(name, &st));
      break;
    }
    return 0;
}
---->8----
Success is indicated by a report of error 24 when attempting to create 
file-3197.tmp. Don't forget to delete the 3196 file-*.tmp files after.

If that test works your patch is GTG as far as I'm concerned. I believe it 
should go to both 3.6.11 and 3.7.0.
Thanks & Regards,

..mark
