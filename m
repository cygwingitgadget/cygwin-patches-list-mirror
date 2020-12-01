Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id BA3623945C31
 for <cygwin-patches@cygwin.com>; Tue,  1 Dec 2020 16:04:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BA3623945C31
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7Jj2-1kpdvY150G-007k0B for <cygwin-patches@cygwin.com>; Tue, 01 Dec 2020
 17:04:56 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id AC304A80D13; Tue,  1 Dec 2020 17:04:55 +0100 (CET)
Date: Tue, 1 Dec 2020 17:04:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix access to block devices below /proc/sys.
Message-ID: <20201201160455.GN303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9c5f23af-ac11-3856-7aab-88dd1c184429@t-online.de>
 <20201130110344.GF303847@calimero.vinschen.de>
 <cd58c473-6aa4-b104-5909-5bd9ed6df1b1@t-online.de>
 <20201130140435.GH303847@calimero.vinschen.de>
 <20201130142123.GI303847@calimero.vinschen.de>
 <c07b35fb-525f-0744-0297-af49aa219cdd@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c07b35fb-525f-0744-0297-af49aa219cdd@t-online.de>
X-Provags-ID: V03:K1:g9UZ2xnPSIwhGRVK1FW40hxrhirmLPiIcXtfg8kpWTLQada5r02
 8smTBg6dRbgEkz/nhZyhC7On5/RwWnO7oKo6jkqs8rWfgby5Uebd4MSRsIr2bh+hAOPU6M3
 bqY0mJf0F1/lOG1E4LCSDfhlOXcJzNmNWtilCqdlwTQp0+IWY4g1RrA6D8WgWeCAXlSC4o+
 lMhy9PPFKcP95G+LO1pFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BoTZULb5fus=:vgjnNtFbhiSMaIY94nrqJI
 qbURCEWOHEHsCPacOw0pLavoZE/Y8j7uPsKHuodhPmkrLyjH1CWIz79371WQu7H8wO23nZJeS
 wbmDp7xA9RIEnYxy12DJSQbroZ1LpwcZR6aVps3JvLJtNTzzwA727aaXc9GJomemfBiwEckqT
 8FTdA3HRTXDzRZph6jHT1QnTF7l9hik9mKN8F+eN7FFzObZlj2ztADwaldR2sHFw22L1VeWXR
 5co4guI5psPhSh06NutCy2rUdtUivDkXHADS2EGLJZuoc1yx6X4002+l7NKnlm+Qm+9zZpjTR
 YcurK2It2pguLIhV7Wf0l7tnDVTNe8rfAHAO3x6THWdfLDMHvgwEsRh/7UfJZLgMds4WXOSmb
 td2W+uf7j4fWpd8OsH8li0gj/pW7eAfh9U2zkZvFP8HREYOUutK9H+7qhaFC17IXYN2WPzZzV
 /g3HkKYWCw==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Tue, 01 Dec 2020 16:04:59 -0000

On Dec  1 16:59, Christian Franke wrote:
> Corinna Vinschen wrote:
> > \Device\Mup is a character device and thus the devices below are not
> > accessible for directory enumeration.  I assume it's the same for DFS.
> 
> Here I see \Device\Mup as a block device on two systems (cygwin1.dll 3.1.7):
> 
> $ ls -l /proc/sys/Device/Mup
> brwxrwx--x 1 Administrators SYSTEM 0, 250 Dec  1 16:50 /proc/sys/Device/Mup

Huh?

$ ls -l /proc/sys/Device/Mup
crwxrwx--x 1 Administrators SYSTEM 0, 250 Dec  1 17:04 /proc/sys/Device/Mup

This is what I'd expect.  Can you debug why this is a block device
on your systems?


Thanks,
Corinna
