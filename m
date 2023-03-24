Return-Path: <SRS0=XmY1=7Q=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0005.auone-net.jp (snd20007.auone-net.jp [27.86.5.231])
	by sourceware.org (Postfix) with ESMTPS id 37DED3858D28
	for <cygwin-patches@cygwin.com>; Fri, 24 Mar 2023 13:48:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 37DED3858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from [172.27.35.81] by dmta0005.auone-net.jp with ESMTP
          id <20230324134816762.LHQA.37033.[172.27.35.81]@dmta0005.auone-net.jp>
          for <cygwin-patches@cygwin.com>; Fri, 24 Mar 2023 22:48:16 +0900
Message-ID: <e9fcb0d5-1537-e23f-21ac-7c56bac4c788@ac.auone-net.jp>
Date: Fri, 24 Mar 2023 22:48:14 +0900
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
 <f82458c2-72be-7485-66da-82b0342ae729@ac.auone-net.jp>
 <ZB2Ph+7EkP8evVJo@calimero.vinschen.de>
From: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
In-Reply-To: <ZB2Ph+7EkP8evVJo@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023/03/24 20:54, Corinna Vinschen wrote:
 > Thanks, I pushed your patches.  We can reevaluate the
 > FILE_SUPPORTS_OPEN_BY_FILE_ID handling if Microsoft actually
 > changes this in Hyper-V.

Great! Now we've got a working implementation and
we know why the code is the way it is.

I use msys2 and have found via this issue that
the cygwin code achieves a lot.
Many thanks for all the contributions
and efforts made thus far.

-- 
Yoshinao Muramatsu <ysno@ac.auone-net.jp>
