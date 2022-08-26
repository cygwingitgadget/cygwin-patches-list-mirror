Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by sourceware.org (Postfix) with ESMTPS id 73E93384D179
	for <cygwin-patches@cygwin.com>; Fri, 26 Aug 2022 16:08:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 73E93384D179
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1aQN-1oQDtr0QyR-00329g for <cygwin-patches@cygwin.com>; Fri, 26 Aug 2022
 18:08:00 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1C34AA806D1; Fri, 26 Aug 2022 18:07:59 +0200 (CEST)
Date: Fri, 26 Aug 2022 18:07:59 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/6] testsuite: various fixes
Message-ID: <Ywjv3xnhMP4rYlMW@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220826125943.49-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220826125943.49-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:YDd94HMf0dh53bt7eTmv+iY/M9fFSszo0ywMSdZKxZ1e/D4GnPf
 vjNiteq3XfTl3hQ/+PwYdZEVu3tqPembbu6HjKt1z3x+bNulBs3XUtnxYfeF0Hepcplx4xV
 fG3n3IQvyIrptCb+gx26kLcoDPLSbCdUTjwQ2IsraLDY4mgrHVIheyJFbO6M3fxwnsKa7Zr
 teuWRPMbaGUIUp87UWV9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0WNXh/Fdkr8=:RtTkKTDZKAlUbftaBgT0N3
 nv/fTIZO80IDK7DNxJ7B/pgFtcGL0/6ND6sw6NvGDUkZF/UIGHhNIj3qiKO5c1nzQTHBWDnme
 7AnSkceRFlBUf8opJRquiHkHezqATawvA1hdA8B/MA7jb6fnzUarA6yvRetvJu58HaPC4IyR9
 I0HCj+uSWCwrUoEwtXmgvEVaQ9UtsLbQurJA09o6WQE+UFaAZWGKZ0v4xCfc45aUYXXDLDkLv
 fhiyo7RDa/6uvYggSXNGgeXcFPqUN2CH+poFFCGZG6l16beJuwPWgQsUe7D9S0eCyeWCQee3k
 SvlZnTGVChBuEj3UPYwiIXCPuyYNG8fXT3KC/1f0LxFCsdAit0bja41olvZZ8H32KUxGy7NmE
 V7nq+7t92nCfGytiPZ4XRpWzv6zCpLa5igW0ryi+vGWIj7AgEhiKqt4sGKEobZVPAMKdmFTz6
 uQfzneM/OmeP3ajMRJJLYGVYRfY9cfs4W54rGMUpXh11k7jeMvPkCrv10uGCM9YueoCJ23y6/
 Dq3Uu6f0BJKMoOm6v494UBVqs1i3rmKHiwkZU3i31GtwhpcpUgmjTSoyIUZG0NfgoK7oqIBFC
 0MjaIxYZ6jOxVfiX8lKcP7rg3PhrwnsZ0fbltCmbQhLRbZ0qU2bR+DkKYQZ1FfZowK0vH8Yaw
 67CIegj4t5J49DWPhz5ePP7Rt5oh6qWkwDz+sIPOdCww5P2eGxjH0ZVRQqAqIjG8hOULyDGXD
 y+k0STdZ6JjpF6XJIHJ2+ha7ARV6pnfXl8B8C+zl5154Ip6GCml3KH+IvVU=
X-Spam-Status: No, score=-95.8 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Aug 26 13:59, Jon Turney wrote:
> This are some fixes for the testsuite I wrote back when I was looking at the
> automake conversion, which mainly fix x86_64-specific problems in the
> testsuite.

LGTM


Corinna
