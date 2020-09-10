Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id EDE993857806
 for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020 14:04:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EDE993857806
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqqLB-1kuKes30z3-00mtzr for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020
 16:04:55 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 56D73A80420; Thu, 10 Sep 2020 16:04:55 +0200 (CEST)
Date: Thu, 10 Sep 2020 16:04:55 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: ldd: Also look for not found DLLs when exit
 status is non-zero
Message-ID: <20200910140455.GC4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200910122740.8534-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200910122740.8534-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:JXsi47h6rR6D2H7Hzpg1OtIpH0ZjugQvOYca9/dbNoLkZD3LbXe
 hkR8e/otoOrGC6f/9Iva8pivg6PyMOQyEDJ764DGdOX4QEXerQUO6ecbR9XnCkfLt53Fo38
 4En5yGXbLOMVZafKA6+QjAyeLi+DnVAVIl69qQhm+qln62iwnsQJ7K8y0lSgJoyB5x5z9tn
 +JIXcra2z2Eyrv6ri+gXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yu1gK4k8Hm8=:KM4LXg/7QeCtxzRkVZ2MXN
 Hgagj0f60q9j6vAuclidl2tSI47b7TFDDkHNo6g+9j3ZE9UNZM4pUXfIFLzOjDFdWLsolk24h
 0z/BGCbcUy+/r9zy3Xj8vw53PewOGDhUnofMJusyP2IAnHRRr7cJNLp7gTqeb8qnSQDem7VWu
 CnFkFZKMF0OzX6LD8wDI8SniZjMrX3wy3aWDwRyrNngLd7j8bSuJ2oKMJI/NTOd7fZX59Pa54
 uwzg3drmJnv9SZkSH6j/UX3hS6hA4pTRlqJte8EnAllEmwZigrgAE1X+nDwBtFBcLN2tyrgiX
 jCwgT27gZKFowgnharpQsRoMhrw++P8N2/h6MnMCCV061y7rTXlXJY+faG5M7FX7krTX1sZCZ
 dVII9oLwONW9ZEglChEL2WLWKlf0aNZjdZoHXiXgNdW0Sm3GqBHLcVIhSaduq2qzcNQH4KAIV
 jI4R9qLdLd3OpyISG/ide9McPIKk7tCYbIdWVp2qUBLWYHy810Tsap9NRMxY2wLKL9PcXDsCw
 igZr4uYBRLpK4LrR8X0qQ66JG34gmOaU1zuG6B/6sH8leHT2+YhvpRtkI8ixsNxifVqyiG455
 39M1NLtvdjBObd4zgEt0KXXKQvef0oKWaz7pD5ef9SIZ+jmlpnISoQOG7RK3slijs5AVvIG32
 UeNxQm7RJYCsFv1P8Fp+OoBRcXibeKxTBYVKSOeEzW04q00MLOitTRV8Fp8MBE10OsFfzF9iQ
 JlLOOkPYwKOnYFKZ++QO7m8LEKStkdyM4VVNCQwfdQLpuypCmq5hw6o9Kimm1aRUN686jA5P+
 TmvHWPa90cjRsDjpsHdgWoI2vhsUkGLag36ulwiAt5eXayYvUs/RgdFCJJVBh2wCpm00No758
 rWMg00pPdV6rhYkAKB8g==
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Thu, 10 Sep 2020 14:04:58 -0000

On Sep 10 13:27, Jon Turney wrote:
> If the process exited with e.g. STATUS_DLL_NOT_FOUND, also process the
> file to look for not found DLLs.
> 
> (We currently only do this when a STATUS_DLL_NOT_FOUND exception occurs,
> which I haven't managed to observe)
> 
> This still isn't 100% correct, as it only examines the specified file
> for missing DLLs, not recursively on the DLLs it depends upon.

Better than nothing?  Please push.


Thanks,
Corinna
