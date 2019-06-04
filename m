Return-Path: <cygwin-patches-return-9434-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75138 invoked by alias); 4 Jun 2019 17:45:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75028 invoked by uid 89); 4 Jun 2019 17:45:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=HX-Languages-Length:3168, website
X-HELO: smtp01.domein-it.com
Received: from smtp01.domein-it.com (HELO smtp01.domein-it.com) (84.244.140.49) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 04 Jun 2019 17:44:57 +0000
Received: by smtp01.domein-it.com (Postfix, from userid 1000)	id B5F388086DA3; Tue,  4 Jun 2019 19:44:54 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [84.244.139.72])	by smtp01.domein-it.com (Postfix) with ESMTP id 18E488086D9B	for <cygwin-patches@cygwin.com>; Tue,  4 Jun 2019 19:44:50 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:47260 helo=[192.168.1.10])	by ferret.domein-it.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)	(Exim 4.91)	(envelope-from <cygwin@wijen.net>)	id 1hYDUM-0001hR-Lq	for cygwin-patches@cygwin.com; Tue, 04 Jun 2019 19:44:46 +0200
Subject: Re: [PATCH] mkdir: always check-for-existence
To: cygwin-patches@cygwin.com
References: <60c1e83d-59f1-6b7a-80e8-05bf41cc6947@wijen.net> <20190603193414.GO3437@calimero.vinschen.de> <dff7bebf-9fee-462e-0b77-fced83963d29@wijen.net> <20190604074136.GQ3437@calimero.vinschen.de>
From: Ben <cygwin@wijen.net>
Message-ID: <82a42b1d-2ce5-c9bd-8d9e-9a02d62ce31d@wijen.net>
Date: Tue, 04 Jun 2019 17:45:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604074136.GQ3437@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------04F10B21D3FC9EEC2E9AAB11"
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1hYDUM-0001hR-Lq
X-Domein-IT-MailScanner: Found to be clean
X-Domein-IT-MailScanner-SpamCheck:
X-Domein-IT-MailScanner-From: cygwin@wijen.net
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00141.txt.bz2

This is a multi-part message in MIME format.
--------------04F10B21D3FC9EEC2E9AAB11
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-length: 1918

Hi Corinna,

Please see the attachment for my patch.
My MUA indeed replaced the tabs with spaces.

I did notice that the indentation was mixed tabs and spaces,
but as stated on the website I have kept the surrounding indentation.


Ben...

On 04-06-2019 09:41, Corinna Vinschen wrote:
> Hi Ben,
>
> On Jun  3 22:07, Ben wrote:
>> When creating a directory which already exists, NtCreateFile will correctly
>> return 'STATUS_OBJECT_NAME_COLLISION'.
>>
>> However when creating a directory and all its parents a normal use would
>> be to start with mkdir(â/cygdrive/câ) which translates to âC:\â for which
>> it'll
>> instead return âSTATUS_ACCESS_DENIEDâ.
>>
>> So we better check for existence prior to calling NtCreateFile.
>> ---
>>  Â winsup/cygwin/dir.cc | 4 +++-
>>  Â 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
>> index f43eae461..b757851d5 100644
>> --- a/winsup/cygwin/dir.cc
>> +++ b/winsup/cygwin/dir.cc
>> @@ -331,8 +331,10 @@ mkdir (const char *dir, mode_t mode)
>>  Â Â Â  Â Â  debug_printf ("got %d error from build_fh_name", fh->error ());
>>  Â Â Â  Â Â  set_errno (fh->error ());
>>  Â Â Â  Â }
>> +Â Â Â Â Â  else if (fh->exists ())
>> +Â Â  Â set_errno (EEXIST);
>>  Â Â Â Â Â Â  else if (has_dot_last_component (dir, true))
>> -Â Â  Â set_errno (fh->exists () ? EEXIST : ENOENT);
>> +Â Â  Â set_errno (ENOENT);
>>  Â Â Â Â Â Â  else if (!fh->mkdir (mode))
>>  Â Â Â  Â res = 0;
>>  Â Â Â Â Â Â  delete fh;
>>
>> -- 
>> 2.21.0
> I was just trying to apply your patch but it fails to apply cleanly.
> Can you please check your indentation?  The `else' lines are indented
> more than the lines in between and TABs are missing.
>
> Maybe your MUA breaks the output?  If all else fails, you could attach
> your patch as plain/text attachement to your mail, usually that's left
> alone by the MUA.
>
>
> Thanks,
> Corinna
>


--------------04F10B21D3FC9EEC2E9AAB11
Content-Type: text/x-patch;
 name="0001-mkdir-always-check-for-existence.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-mkdir-always-check-for-existence.patch"
Content-length: 1273

From 190b5bc9497a1332ce53afd831debe1ac3e53ffb Mon Sep 17 00:00:00 2001
From: Ben Wijen <ben@wijen.net>
Date: Mon, 3 Jun 2019 20:15:50 +0200
Subject: [PATCH] mkdir: always check-for-existence
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When using NtCreateFile when creating a directory that already exists,
it will correctly return 'STATUS_OBJECT_NAME_COLLISION'.

However using this function to create a directory (and all its parents)
a normal use would be to start with mkdir(â/cygdrive/câ) which translates
to âC:\â for which it'll instead return âSTATUS_ACCESS_DENIEDâ.
---
 winsup/cygwin/dir.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
index f43eae461..b757851d5 100644
--- a/winsup/cygwin/dir.cc
+++ b/winsup/cygwin/dir.cc
@@ -331,8 +331,10 @@ mkdir (const char *dir, mode_t mode)
 	  debug_printf ("got %d error from build_fh_name", fh->error ());
 	  set_errno (fh->error ());
 	}
+      else if (fh->exists ())
+	set_errno (EEXIST);
       else if (has_dot_last_component (dir, true))
-	set_errno (fh->exists () ? EEXIST : ENOENT);
+	set_errno (ENOENT);
       else if (!fh->mkdir (mode))
 	res = 0;
       delete fh;
-- 
2.21.0


--------------04F10B21D3FC9EEC2E9AAB11--
