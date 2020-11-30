Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id EDEDB3833012
 for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020 10:47:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EDEDB3833012
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGgRW-1kxUVC3EGo-00DpXZ for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020
 11:47:56 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E142BA80D0E; Mon, 30 Nov 2020 11:47:55 +0100 (CET)
Date: Mon, 30 Nov 2020 11:47:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/2] proc(5) man page
Message-ID: <20201130104755.GE303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201125064931.17081-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201125064931.17081-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:kp/uk+axXYeP8psLXSsN/Ed6+fpNhNtD4wGZ04k4baPc0eJQ1Wk
 EhX4SJy4g593UyeWdxfT97OTWQiWjKgAV37zqcZ6b0Ydl2VRslW3oVaktgD1Hi+c/++N100
 sHw4FIzCesyE6QfeexZX9+07nkhzz/QYCAqV+zOQvk4YSjAbgDp/wQ01LbGNeFiqzw2QuyI
 JhK6fuYMVwdJS/yK4I/Pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GDXVpiFR610=:Y5lDnM8dyv3WTMhuN37kMk
 6JutDMYfjogBHsBvALxlkmFDlGhBPGibyfYFZVqZ43i6Jn2AiLlQ36vaRRm2ZOoCIDFnTaXQP
 3EVkK9fZhEYCVj2hDSnFsSOAwNtm0fTVtAfupwBfMFGtjEI/yeZbnVaGPwuJ2g4wstxq2NZNp
 /Bzf82Eqa5rx3mKbBpwzkL0L73L0NMGfN3WXI4rqhDRQoX2aI4Io/Uxsub7fawlFkcxojFbqd
 NZtNnjjzkr8zUwwUr0jj4XL0Y2amoXUcJdI9OGtwUsCiQWIIfVKfY6VjVtson0LNsKV02YBw6
 VQWwcyjUwnIThubJfc45tn7yv0S3CRSFAKJXk4KeArvOpCVvo2exD7SqtGlKcLKH4MZYmPKWM
 QdGUW2nr2HkaUjrkduBS6FwxnFEJqZaxpt4OB7j4SXbTnXfLIrVkPqeNrYlgHeT/EOAZhq/i9
 wxFxl2eguw==
X-Spam-Status: No, score=-100.6 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 30 Nov 2020 10:47:59 -0000

Hi Brian,

On Nov 24 23:49, Brian Inglis wrote:
> Brian Inglis (2):
>   specialnames.xml: add proc(5) Cygwin man page
>   winsup/doc/Makefile.in: create man5 dir and install generated proc.5
> 
>  winsup/doc/Makefile.in      |    4 +
>  winsup/doc/specialnames.xml | 2094 +++++++++++++++++++++++++++++++++++
>  2 files changed, 2098 insertions(+)
> 
> -- 
> 2.29.2

It would be helpful if you could outline the changes from v1.


Thanks,
Corinna
