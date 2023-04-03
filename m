Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by sourceware.org (Postfix) with ESMTPS id 9E6283858D39
	for <cygwin-patches@cygwin.com>; Mon,  3 Apr 2023 18:36:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9E6283858D39
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MXXZf-1pukma1GcJ-00Yxbu for <cygwin-patches@cygwin.com>; Mon, 03 Apr 2023
 20:36:35 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BDFC2A80896; Mon,  3 Apr 2023 20:36:34 +0200 (CEST)
Date: Mon, 3 Apr 2023 20:36:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 1/3] Allow deriving the current user's home directory
 via the HOME variable
Message-ID: <ZCscsuGjXqL8W803@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1679991274.git.johannes.schindelin@gmx.de>
 <cover.1680532960.git.johannes.schindelin@gmx.de>
 <e26cae9439b01c8a958eb19072c88e9db3abd36e.1680532960.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e26cae9439b01c8a958eb19072c88e9db3abd36e.1680532960.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K1:9wKrItajOynbsvsnLaSY43kC1cjTRsx5pBo81Pxc7v8k6yhckRm
 lJwu3YDnDRVozfpNh7ckuRaRXtzoztLncoiv8ucr++B9Bh6sS7dJPl3FJ5Sx/ds+cMedVpu
 pLcZKc241WRDJjMO9KQg4E33yfJ2GdHAwPJH/bEU4xvmbWpTeQC2yVVbwuRvRD3HfwelSaL
 98LFexuGOz19urA+ELExg==
UI-OutboundReport: notjunk:1;M01:P0:rkgLFLbcy64=;oImQPVGaJdeVhNz6NnkE4PWyeaP
 sVpjjWVX+dU6LKqx7jrSn3V3KwQcI6+QHaiKQ8neEVhiTkwWTsdIbPri/LbIEe1Z8wUveJYeY
 I80dgG/Lmf7J2ZQBB7q9WRPwj0T+NAlWpde7OEKav+S72X9u8DTr7NQISq74SqNQIIDFGeYPE
 p1BK15Elvslp70jFT2FzzmlFpXaGwX0XdZARwIp9Q+zglY604N4dVc0y+tOwn1V1x2NYbyKzF
 6hJ2YVIEqmEU45/TGD6AEkn20qxjWdQpeok6UjwbHojmlLOegVk0AgfpQHlLqTwWctlXN/wDT
 hBqxa0PTrDDOK/lUGC9qo2PC8R/+xP2O39V+VynrnRh3X56OkrArU4fbdWOz3UG2OXVd6pHC/
 CH+qKDuH2Wvjm/EdjV6WmW0Pq8CteUNRg+PaRTSUeTRj3UEIoArdJUJFjsAQe/wgBY9aeHyJa
 wmYaE5OgeWqaIO1lLLq8SEdWAqJ1ksnttQvJDClDxh0OaLZ965L/87gSdUSylGqrSUEmFnNdJ
 Y0hyusrpJXg/Yp3ci/qTb4Z1uab+SJS0OcyY0k2s979j4NGWRRtPwAQJ4dN5L/c1gUiBC8sNP
 n3yXcxeeRgzfJMqA2E/ErsCK8VXozNgHHR0qK+Ij8IIm0gi4fSxecCAyIkDQ9wPvfK8cD8BT0
 FEbbcwNJJxvfa1PYPr2o72HIv7mSPzWFqeVs31WmCg==
X-Spam-Status: No, score=-97.7 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Apr  3 16:44, Johannes Schindelin wrote:
> This patch hails from Git for Windows (where the Cygwin runtime is used
> in the form of a slightly modified MSYS2 runtime), where it is a
> well-established technique to let the `$HOME` variable define where the
> current user's home directory is, falling back to `$HOMEDRIVE$HOMEPATH`
> and `$USERPROFILE`.

This patch is already merged.


Corinna
