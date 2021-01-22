Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id B9ECB398BC09
 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021 09:50:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B9ECB398BC09
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M7KG2-1l69oP1bR6-007hN7 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021
 10:50:29 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 03799A80D50; Fri, 22 Jan 2021 10:50:29 +0100 (CET)
Date: Fri, 22 Jan 2021 10:50:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/4] Improve pseudo console support.
Message-ID: <20210122095028.GC810271@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210121205852.536-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210121205852.536-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:6A98bftZ+a7diLzTNDZgA+5DvGW65lks+M+chJMr/QO8YS1e/8y
 VLSZtzCy8ow4HYZ+fNQoZeDnC4iNOU42Z8wnOC3CeKhxYSV5Q8zV4UxxMGhVjQDBfQipS53
 Ryy36mUWuC6nioMp/eNW443Nht+BHPqOB07WfBwPBnxqpmDGy3eUIVNS+SSvMCoIGClTWj9
 9l7tPK/s5mp+8E6X9hXdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ab6Oio+d/C8=:XVJqkoDPBasq7Hs6J64Sss
 CV2KZRSGT7PHy3Jq9eIjiH3qaUcIYOkAl3ehAVomyBwR5ZfCEpvFX/Xpt9XEKZqhvf+Lwz3uq
 JsXfAOYCjPMiN5z3fIIYwYgfGRaHRGCxkNPgd4PeSncmSTIlm/ep4Qg0VuIq5kEPLs4cvo4XZ
 cRT4RTpJmmKy2OukwhmDTK0ygikVAjJ2y3O+JKLLxkQk898SXIxzAjmQsSuT8YKt195UdZQKV
 XOFlTZkGtaLkI/SrUhTgxScbKMxI5saNnGz6vn1vRrNy7vrUo2Qizhq32gGvgDey5DCTSxtoy
 L4FO4R/+Q2vkDNvG5JKTgWrtaeZUo77WOKV8iV/bCRU8iZagNLmL5vBfpUESZMYAgHRagaEJZ
 6WXn5hbKP1+smFylYio9pHwtFm5WOYx96UUSQyOmtIemWsuslanUmOEl0nRG08pCW/EOuaqvh
 1FECR6hPZupWtrGcTK8rwxultjTtZTc=
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Fri, 22 Jan 2021 09:50:32 -0000

On Jan 22 05:58, Takashi Yano via Cygwin-patches wrote:
> The new implementation of pseudo console support by commit bb428520
> provides the important advantages, while there also has been several
> disadvantages compared to the previous implementation.
> 
> These patches overturn some of them.
> 
> The disadvantage:
>  1) The cygwin program which calls console API directly does not work.
> is supposed to be able to be overcome as well, however, I am not sure
> it is worth enough. This will need a lot of hooks for console APIs.

Definitely not.  We should really not cave in to such expectations.
Cygwin apps are POSIX apps in the first place and should use the API
provided by Cygwin and other Cygwin libs.  Yes, there are border cases
like the X server or cygrunsrv, but these are limited and should stay
limited.


Corinna
