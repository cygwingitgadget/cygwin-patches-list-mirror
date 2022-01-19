Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 04CD73858401
 for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022 14:39:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 04CD73858401
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MqatK-1mWiUz0KxM-00maW0 for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022
 15:39:29 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A9296A80D67; Wed, 19 Jan 2022 15:39:28 +0100 (CET)
Date: Wed, 19 Jan 2022 15:39:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Silence more build rules
Message-ID: <YegioLvRwD4+T3PF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220119131521.51616-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119131521.51616-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:0hIiPs1OZMWbKP1nJBlxDcFvUIo1RMjvWsDuj6oJximsit45+ts
 m6eluoT1JUkomP/ihS3GkabVKMn+s7FQVl20PnD84TwWv122AyOucqWZBWJ6S+HW0ddni1o
 UqXCk/MvZtQwqdx1XVju5qX/HbopRfStnIoQVcQbOfugBUiUopYeXTjwl6ihJDQeTSSDYd/
 TEuJPC24WzB8r3Miv82gA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SHEjtYhZzHg=:F57K8B08Fxx/QzwMpI2zwO
 w7c5E7lnoPYjONWN5HFNB/XMe6fwXTOyUU4NU2W8NFDSqSgCUzMAQkz8ybwbg+GZKaxv4YoCU
 Hxf9Gbx5OdNhKDFyajdtl7D0Z/gW9IbqSVA5T88+h4mXfOCzP1sjzayqOC93HQsunKGs8qiTM
 5RtJKkVVKJPXJICJJqtm5IzOimZvvHzFO+Nq+FM/gTz57Crumk2Dy/4/dgAPTfwdFZQh3MKnI
 +ntSFSfUuULB1UP4OfInU8MzSf36zip1A87VaKSWTumYUtltl2UX870SNXPOFFyX524mLklrA
 1ex7QXTZUt12Q03dWbUV7ZkuZP6tEvbWTI8Zco36U+Jlw1z4jCUOq3MpU4409Pp+t9Q8MUQav
 U64r8WulwxmBswga98rB85lfgJPdxXJi7y3uk+nfTYrgtrTKRRVMnL+BTAib7de/7mxPmRivS
 pCXo2pgRyeMQUiJZRrNXiRXdgq35e+gCALj9m6EnBOUQXKfUCCTsB5E9avJZT0e5txflEnJm2
 BsK3lKxiXGHNGj2jXdPKT8T8rq1xGN+CjHeFCZ/sDpLbJfpN0pvW7CBYIHoCbJO5TWax06zWg
 /rtBOdN517/niCHmGnoY+QPQj+0u+nJgtH3rDqQxlqfEmCXlzkbyspAO4zyHzXM28yczUvAXh
 6T6+sviZnA/o06MlR7aaBuUD7x7r4s50OVv98nD7sVaN1brzd/xQMF/RPfg5EvTDhMQt4ERMO
 vLWu3W7DCnXqCUEm
X-Spam-Status: No, score=-97.2 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE,
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
X-List-Received-Date: Wed, 19 Jan 2022 14:39:32 -0000

On Jan 19 13:15, Jon Turney wrote:
> Jon Turney (4):
>   Cygwin: silence most custom build rules
>   Cygwin: silence dblatex when building PDFs
>   Cygwin: silence xsltproc when writing chunked html
>   Cygwin: silence xsltproc when writing manpages
> 
>  winsup/cygwin/Makefile.am | 38 ++++++++++++++++-----------------
>  winsup/doc/Makefile.am    | 45 ++++++++++++++++++++++-----------------
>  2 files changed, 45 insertions(+), 38 deletions(-)

Yesss!


Thanks,
Corinna
