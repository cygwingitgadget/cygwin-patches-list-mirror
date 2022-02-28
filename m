Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id B73E53858C20
 for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022 09:44:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B73E53858C20
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCbR7-1nYHTZ2vkh-009f08 for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022
 10:44:14 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 45B43A80CE4; Mon, 28 Feb 2022 10:44:14 +0100 (CET)
Date: Mon, 28 Feb 2022 10:44:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: Drop use of loadlib.h in regtool
Message-ID: <YhyZbpQMiU7hpbCX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220226164054.26698-1-jon.turney@dronecode.org.uk>
 <20220226164054.26698-3-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220226164054.26698-3-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:LmQzEUcmtiZStxQXSOVFc3lAzqNQlA4Habl20ZMeMLFOhyx7EF0
 z79+2WxpeINAcq57Y8pUatfcsGGeX5MXM5e1i4hjNsOnwtVTBjNO+GZ8KewRCje07MVn+So
 tpR0yIk6U/eL1tPbtcU+w4Xu3Zq3WVynXT0o88wSxk9QYtvErFsoO7iDOT//0jLc7uIYXea
 L79rbKfX/ls/ubNPDp1ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ua3ExS8xC/Y=:LcmyGRDG+YJaHtMgeVlm8w
 s4PnX2ZlM0wG+YACxncaX39md5MNZzUOrTDRQ9oseADZy4ahIgk2ApIOSN9SX8Cmt3nH8VHlR
 FqqcrXy5ZcFgzEhXv2YIismAwYCNmwgHmNsvFhLeaoERsdRA/1DV4exARYAaUexZoQ0Xsvq3n
 aLT3hHfC1GB8vf0NwOni7eSUrRLdXqZM4HXTxxsGmkD3WFlNJh+oiZMNZBKNQv7qtLRyWPckX
 TBeVlZyRu7PqUoEQe4RL4lILTrk9GZs+pyFhzCy1BpchAp+mwcaDHUOd9AvhZgmdpOk+U47Uo
 XLgIdASGXnN037w0CZkuSveeF8jmWhGGq9OckHZDCyg8GhrDJdm9Cb5nxDbjryUC2zNVUvLhf
 eTEkjt+oNkO5VM2zLNE3f9blJsXpDyfXaSifg9eC39ZMjQ8aObi6nT48Qr4f+ozLcqFc7N7MW
 FCmsD1v8LPzRDfMwQNSp96Tj/O1LyGZl9yv7gE6dWrjOPOPtA4QrR2zcmnKuOI5Zrqrz14iRT
 RX6Miexv/T3tpKFFsAhcbRzgxbsR1KfSgnuaOH+Czcb6lwFBDQJskc5el0jubFLU21wDdUkL6
 XhKEBDDBrn4dH9Ov9VcfT7G/BsFltuZas8RUIgfMqTUviK/KPAHUCGhQw0h46V1M0ZUtsrLTl
 LvJ2eJbrv54KyoC1nSW71mI+ymAwB76RYS+RC8TUTGlWb6aQAAZExnciY1KDC3Ia+NOFMOlEZ
 OjFukd+hp/N20Ssn
X-Spam-Status: No, score=-96.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H5,
 RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
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
X-List-Received-Date: Mon, 28 Feb 2022 09:44:17 -0000

On Feb 26 16:40, Jon Turney wrote:
> Link directly with RegDeleteKeyExW(), available since Vista.
> 
> (It's unclear the LoadLibrary wrapper was ever doing anything useful
> here, as (i) DLL lookup in PATH was avoided as advapi32 is already
> loaded into the process, and (ii) advapi32 is a 'known DLL' which is
> only ever loaded from system directory)

Ah, sorry for outlining this in my previous reply.  You were aware
of that already, of course.


Corinna
