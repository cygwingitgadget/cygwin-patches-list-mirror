Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	by sourceware.org (Postfix) with ESMTPS id C61693842405;
	Tue, 10 Jan 2023 14:29:21 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MsI0I-1ow4ss0qzq-00tmpy; Tue, 10 Jan 2023 15:29:20 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9472EA80A3A; Tue, 10 Jan 2023 15:29:19 +0100 (CET)
Date: Tue, 10 Jan 2023 15:29:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <tyan0@sourceware.org>
Cc: cygwin-patches@cygwin.com
Subject: Re: [newlib-cygwin] Cygwin: ctty: Add comments for the special
 values: -1 and -2.
Message-ID: <Y712P2K2u15BNnZS@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <tyan0@sourceware.org>,
	cygwin-patches@cygwin.com
References: <20230110131557.3B148385843E@sourceware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230110131557.3B148385843E@sourceware.org>
X-Provags-ID: V03:K1:j7ms8FbbFNLzJKkjzwJLJCqbwGhGwItBB0pT++eS9BU3bXPqyzp
 j7TpV9xyDcQeXew0Yj067J0iKu6K7GVzsB8WnvmvZ8ZJsmGr8kCLp+SvkObgKwuc1OrcUJA
 KnX4yS4uVt25HhilqMkgOn7Kgv/3UtRQlw69Z8kVu85E1uSw9p0FykclxVHlbh7xu1fKRJO
 QMlqupgo8z4fHSaR7pi5Q==
UI-OutboundReport: notjunk:1;M01:P0:pDWLsyJ3zuI=;o0DyKmxIPqephsR1EkJAf3Zh2Sm
 STvJYCLP+8vz+pWB8jXf0UoI0a1E3oUzeW/HvygCCRwpgJ4nNeWVStKe2yTREE3u0PX7EHmZ1
 GYoePhHAE59+e+Xu+IySeSbQwMPUilf3fpaDvDNTEnSpMy+MyGaLsb5Bcbo8YVax3QMVF4MPv
 xvegUNaFckZvPXdJ4z/t6Qrz34AStXOizqpqQwZyXRSpo2cVFpyOSyPfJOO67675wTLcXsmmR
 ju+hhWLtMOaQk+xZoDpOpGTXdRplCV9pczwlxHNrvhVaZpjVmehenblWZ2W1GrHMWzBBhIjyT
 Lb7kadwbmRMX2UobPiDi5vkG1XxgxsatCsN/M4fL0f1HWQRNJ5A4XXKry6REmHm74DFdnEzLt
 6LPt8AEaa8uCFW/unY9NsPDa196aDvNBX+zOXfgfhqekszpjc22H8JSRqMm354GL2Nh0GlSPg
 odFpWngvMjxFsE5YVzYaRimUfA/T1zJ9XPICAMmfpw3rhIJwrwgSKvIW2SbFQq+Dt7AKJerRa
 rM5HqUASEAmE43MBJjP4ktlxJpdOEX6zqDmI3NRK4CHOYbMY/L6xMhXf6hqrP/0KeZdJhxL0I
 CBax43vB9L4lEsw/GqPnBMK3hEA2N7VnJ+tBN2vBCB0yyRyiKFA4kh14xzbIerjclbRQ90KHt
 V7HY6BtofzbxMpsUt2/49TMe0bUECsGbRCtZucC6nQ==
X-Spam-Status: No, score=-96.7 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jan 10 13:15, Takashi Yano via Cygwin-cvs wrote:
> https://sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;h=3b7df69aaa5752f78537eafa5838f65a1ddfc938
> 
> commit 3b7df69aaa5752f78537eafa5838f65a1ddfc938
> Author: Takashi Yano <takashi.yano@nifty.ne.jp>
> Date:   Tue Jan 10 22:04:40 2023 +0900
> 
>     Cygwin: ctty: Add comments for the special values: -1 and -2.
>     
>     _pinfo::ctty has two special values other than the device id of
>     the allocated ctty:
>     -1: CTTY is not initialized yet. Can be associated with the TTY
>         which is associated with the session leader.
>     -2: CTTY has been released by setsid(). Can be associate only with
>         new TTY which is not associated with any other session as CTTY,
>         but cannot be associate with the TTYs already associated with
>         other sessions.
>     This patch adds the comments in some source files.

Oh, ok.  I was more thinking along the lines of using symbolic values,
kind of like this:

  #define CTTY_UNINITIALIZED -1
  #define CTTY_RELEASED      -2
  #define CTTY_IS_FREE(_c)   ((_c) < 0)

I'm not sure the names make sense, but you see what I mean.  The
comments could precede the definitions in the header file then.


Corinna
