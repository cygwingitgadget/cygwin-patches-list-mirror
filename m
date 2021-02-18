Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id DFC79386F006
 for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2021 08:40:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DFC79386F006
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M9nEJ-1lGFE60wLN-005mgd for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2021
 09:40:03 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8122BA80B83; Thu, 18 Feb 2021 09:40:02 +0100 (CET)
Date: Thu, 18 Feb 2021 09:40:02 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/2] cpuinfo: fix check; add AVX features; move SME,
 SEV/_ES features
Message-ID: <YC4n4kNlKPKFgmLA@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210217162836.57947-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217162836.57947-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:2uNppljf7m0AM1MIE0dIcSSND2fMRscx8wjK3B7dhrn2PirAHvX
 KtihgJDPyxmU8D2zbOOENekMjV5Er4xpKs3uLTzq08xlBDdOkoDZro5d7+kmHiyQOmD2wGr
 KazsK01SAbgQPc62ndN2cOX0XBHqfbHmqdUKJCgPIArT41bUtmce0qhCz/nmVXYRfZXyfdK
 bj2KY42trzA/efAZLox7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EJyw54QGOfU=:fPCHloh4mu3BgwL809Q5EK
 rbI4NEngX8v/XWgwNJz4paAkXOkC8O+Q+RVt872mVkC3bynJD9DCdcicXacXdZoeJtCUYwMHR
 vpVjvDIte2dspVEh3EEPJT/wwWRgdO/O+rSsFHEXHFpPsBS0VJMrOZkTNiQ9CMcd6jJWvYySO
 uqkjyCWTm46g2DVIiBEcVZTZIUJFSyEKqj+pUflvNnQuuGU+yGjS2LCVQ0ahIl/AoRGRbFhnW
 P0YV3HKTDg8ST7E8x/F/giikLTY9Md+p7Zv2mpZNpyl+FY1lpKMReGde39UEf69puxipcAMhz
 aS7P8a0lZrLqEssHU396ITqH6pB056lAe3yLE3aBf3b4X9hCiyfotQcdL9vxMy/7T22Dyy/3/
 odWFQCCI2sDE2UM7uKuYjLS+eyUsKEhmm7mQQc0MEBSPPUPqpJMzLqEUlu3gbdl8+WTaJ+H+N
 /5GNb4NrvQ==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Thu, 18 Feb 2021 08:40:06 -0000

On Feb 17 09:28, Brian Inglis wrote:
> Brian Inglis (2):
>   fix check for cpuid 0x80000007 support
>   add AVX features; move SME, SEV/_ES features
> 
>  winsup/cygwin/fhandler_proc.cc | 46 ++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
> 
> -- 
> 2.30.0

Pushed.

Thanks,
Corinna
