Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 70FEA3844079
 for <cygwin-patches@cygwin.com>; Wed, 16 Mar 2022 07:43:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 70FEA3844079
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N1feo-1oEYyo483k-012380 for <cygwin-patches@cygwin.com>; Wed, 16 Mar 2022
 08:43:55 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 239E8A8071E; Wed, 16 Mar 2022 08:43:54 +0100 (CET)
Date: Wed, 16 Mar 2022 08:43:54 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix gmondump formatting goofs
Message-ID: <YjGVOi2/U1W6N2xu@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220315004730.15783-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220315004730.15783-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:h2iRPdYY4+sU+XPxiBFBOgKzH00XfeRPSo2vT01LK7aAVZ+wq0a
 Jx82lpZhB4OaQ/UBmvX8qtb/lbZi3nf3pr+2U0+9mLEMyI1X449UukMY8PcZDUjLeevynCR
 UA/8PlRuobEEB7w+Z4WxiXUpdBcuY8OgJAcZd+35fzGb2MJEe+knsnZbV5jpB57aXXpyDHj
 lzq7CJCfBHiQGpG6014Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v9e/sjb66Bc=:vPhT3xbd3e0QpbnsBJUxC9
 uOYlaHCpXgaCdoK3qg4Op7d3d3NsH8IfcnXUrGBzrlke/qbCBsnlpF8lcxPASGE0Y2ERuARGW
 cik8mS2WW5ZQlLO/uhYS+k8Iscqxq0R+HS4pwfJiCCfESAfn7lRMIs7IldMYlpnZi75yNIpvg
 IhSUfBj1jMmOOTccq3UeQW7apYO1wSGo1oH1efZRxU7Jl8kBK5Zl7KGjq7HILeAY158QDrT4B
 ah+9NCQuf3U2/TmMMCmXHWvj4U4mTcsdpVUliHlZ0IQNtphOM2T+VJzC2ZQ6a138T78yqAOe1
 okOywJGUHkiqrFbdU7MP6Qk37GJ54FIvfI54h8JN85HciI5z/d1qAlUoyuK1za5QSA9kOa59A
 Qz71HIsIbnlO2YMdpqrydVsM+GPYQ+esb32BDxJPVp0IRpPEebght6g+NIn37sPqs9UJuNwlq
 mAqCvPjqj4e4PkCK8B7LFsRjcXKEeIzfoBq4gsDE20tlcBBrrdRslpC1Eme4Ael2+1/K7hceJ
 Gu/tZgRxvEpgR/d2WWe3T4m16x3+9FqC7+9nxIgt3F+eeEmiLzUM6HZyATvW52aiTJ3V+CQ1P
 rHfFNMNyGWFR0KBWKXIberMb7Q6tynEYzGayyS7CM+FPfhK58iwTUV7wc05OW8aMNCVk4kPaH
 4pzsX9gXpML+FKanHXuBvy1KwAV6HIi8RtbEeayoth8vosvtDTn7V6Ph/GSJrxDrbeZ8P7IcH
 N7BniwdZAguwsY9I
X-Spam-Status: No, score=-96.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 16 Mar 2022 07:43:57 -0000

On Mar 14 17:47, Mark Geisert wrote:
> The rewrite of %X to %p was malhandled.  Fix that/them.

This should probably go into 3.3 as well.  Care to write a
matching entry for the release/3.3.5 file?


Thanks,
Corinna
