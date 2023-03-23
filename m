Return-Path: <SRS0=hRoz=7P=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0009.auone-net.jp (snd00009.auone-net.jp [111.86.247.9])
	by sourceware.org (Postfix) with ESMTPS id 1DFBE3858CDB
	for <cygwin-patches@cygwin.com>; Thu, 23 Mar 2023 16:40:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1DFBE3858CDB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from [172.27.35.81] by dmta0009.auone-net.jp with ESMTP
          id <20230323164027520.HZDM.21443.[172.27.35.81]@dmta0009.auone-net.jp>
          for <cygwin-patches@cygwin.com>; Fri, 24 Mar 2023 01:40:27 +0900
Message-ID: <f82458c2-72be-7485-66da-82b0342ae729@ac.auone-net.jp>
Date: Fri, 24 Mar 2023 01:40:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
 <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
 <ZBWL85hJIlbZHc/D@calimero.vinschen.de>
 <608a78b6-f523-14f1-333d-f59e9f2bb8d5@ac.auone-net.jp>
 <ZBhy7E4vKHTRNW6k@calimero.vinschen.de>
 <ZBjD9exM9ZBGDzK3@calimero.vinschen.de>
 <434bbf77-6a08-3be2-747f-13dfc4637275@ac.auone-net.jp>
 <ZBnwKcr+ZL6sv0jh@calimero.vinschen.de>
From: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
In-Reply-To: <ZBnwKcr+ZL6sv0jh@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023/03/22 2:58, Corinna Vinschen wrote:
 > I pushed a new Cygwin DLL, test release 3.5.0-0.251.gfe2545e9faaf.
 > This should do what we want, now.  If you can confirm, I'll push
 > your workaround afterwards.

I have tested cygwin-3.5.0-0.251.gfe2545e9faaf.
It works fine with bind mounted directory in the hyper-v container.

However, the currently reported FILE_SUPPORTS_POSIX_UNLINK_RENAME
and FILE_SUPPORTS_OPEN_BY_FILE_ID are different from the
actual behavior and I will report this as a bug at
https://github.com/microsoft/Windows-Containers/issues/341

In the future, I expect that FILE_SUPPORTS_POSIX_UNLINK_RENAME will
be desirable as a check target, but then checking
FILE_SUPPORTS_OPEN_BY_FILE_ID in gfe2545e9faafd may become harmful.
(in process isolated container,
  posix unlink/rename works but OpenByFileId() not)

At this time, using FILE_SUPPORTS_POSIX_UNLINK_RENAME for
the check would mean the occurrence of additional failures
and subsequent workarounds.
This may be too optimistic, but STATUS_INVALID_PARAMETER is
an error at the parameter check stage, so I expect a small loss
in case of failure. Is the additional cost of unlink/rename failure
due to an incorrect FILE_SUPPORTS_POSIX_UNLINK_RENAME unacceptable?

----

Slightly off-topic, but since I could not use gui to set up cygwin
in the container, I am using setup-x86_64.exe with cli.
Is there a way to install the cygwin package by specifying
the package version from cli?
This time I modified setup.ini and installed with -l -L.

-- 
Yoshinao Muramatsu <ysno@ac.auone-net.jp>
