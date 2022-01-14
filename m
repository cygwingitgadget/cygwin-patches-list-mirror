Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 58E7F3858401
 for <cygwin-patches@cygwin.com>; Fri, 14 Jan 2022 09:15:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 58E7F3858401
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N7zRz-1mDWzK438N-0154sx for <cygwin-patches@cygwin.com>; Fri, 14 Jan 2022
 10:15:14 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7B0A1A80ED6; Fri, 14 Jan 2022 10:15:13 +0100 (CET)
Date: Fri, 14 Jan 2022 10:15:13 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Some fixes for console and pty.
Message-ID: <YeE/ITK4s3WSkqvH@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220113122811.241-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220113122811.241-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:IseZt31/dWfR0o3mN/jobRF89IzzVHhhnsjbJMp2upxR/huXmRP
 xfaNHVw2xkM/ncWN8OolWgGMjE/PJl21Zs1AfKlIqHZcNVlV/aTUQdM2ymmVCYkJSQELxWz
 +21zoVWkEgxo2agh+KFyj/VIK6IS4kXL7Es1x+hP5tBOVuY78BSvHtEMrFVpiNocB+brxpO
 ePOmxIDynua1alXmULMkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cWlo7WbQsSk=:MjzLt6vSR+2q1YJGr3VEwl
 r+7Za8XxzHxRmE7wBu2cPUTbjpKSMM5rbhMobwl/A67wagUcdGIeFIyykO7y/oPa8YSDpQdF+
 J/V1XQsH6hDDuo49sFJ6rjGdorVd9jNPBBnoAvR9Uek4hDZtgKt0wFoHtgeiBV/vvyzfeYEgJ
 YPJtJSMVb94G5ClFvpbKP/HLra7p8gEQkfpFjR2dez3m0FD/9iBJPrRjZjDwbzsF+Xbp+8Wm6
 dPNPrGIfKzsTW2B5ID6feCDaBX7plcClan+LkSHh6KK/SftsvrhKIjH4eIJzkdVnBBwtsjLEp
 1OrFPX2ZM8dgHXZyXLyfn2nYJDahdKCfTWsT7HH8uCPeyoP9O98kYU/95WNV7oOF9EfiU713D
 KeE761iRfceDIZDa17OnlUKpgFCZiNkCgDtDALDfZhvC+VkAsjVaZWG57I/s00kx4qc/tvgsG
 Wp3rB/qiWg0QFB72D6MLg3d1fVgMQdx1tIrmZhU+vl9aJgrBsfejvWQQCZI2rpXN5y3X+nSgd
 mF9cQ8vdV9K2A9r1pYRUrhHtUKsbuXmK6id7YYKGR++cZxl+YZdPIXToKq9TMZRZSfkWJOQRu
 B4dF7P/s5MKFjgVYHkMX2io4e2HaZIXOjokYjMWHwaPPklEk0KtPuSwIFs7KUqidB4tXDSiGV
 RxXm0jy7jFbSUDKHmOzlP1u/7qHpekoHAygVquokXtaTMgNrGr8xNIW2Kw29PCEnTelW6em8y
 9acOFLYNEXPlTNJI
X-Spam-Status: No, score=-95.2 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Fri, 14 Jan 2022 09:15:16 -0000

Hi Takashi,

On Jan 13 21:28, Takashi Yano wrote:
> Takashi Yano (4):
>   Cygwin: pty, console: Fix deadlock in GDB regarding mutex.
>   Cygwin: pty: Fix memory leak in master_fwd_thread.
>   Cygwin: pty: Stop closing and recreating attach_mutex.
>   Cygwin: console: Fix potential deadlock regarding acuqiring mutex.

LGTM, but you know, it's your code anyway ;)


Corinna
