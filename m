Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id A69733857C6E
 for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2020 11:17:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A69733857C6E
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M9WBG-1jt77F1BKO-005aYV for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2020
 13:17:21 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 6C48CA80763; Fri, 17 Jul 2020 13:17:18 +0200 (CEST)
Date: Fri, 17 Jul 2020 13:17:18 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: FAQ Proposed Updates Summary and Preview Diff
Message-ID: <20200717111718.GF3784@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5dd6e092-3963-a47e-dda5-160d15b70ca0@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5dd6e092-3963-a47e-dda5-160d15b70ca0@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:zuo0gxQcVjYShlsvZgl8MikA+BmiPE+uPqQIN6mavkjh5XH1zDP
 Wj1g35JYtADceeQlFvY0bo8xhkcSc4lnQ7M8i/wd7RDDfxdftcWk37Wq4dcnfWh6HgX3fQe
 xNuj4sPBNoJj7PvlITgE/JRhn8ulTmauN3+Yt1enhdZJtAcgA92SgOrg84TkuxsWwoNledq
 9EZWGAuqs5SXHHN0s/j0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qHevaqpw8dk=:lqCr2Fo3ihy9AK9x0a88AF
 Z2MFkImeAFgRb3x/4z5vJxmXQtMcev4yIv6rqkYvefyUncwsNPXGscDnHqB5t8ieGhNjga1CB
 IeiLKggk+3ucxl9eYovQGQbIxm5HbLU8P3iM7QBLD/4wB5q47iflyH4ceUPjLJQlbNrj4QhTj
 445b+kwCimXreojBQWTkGhbybauuNe281NMfsRUBLulMscPDI23OXNgadUAidtnDCVart8OT9
 HnuxKxzU6BXcRmFLmveMU6O+c+NA7wbWmhXrKeO2lfjuuJQUrbwjG5AHBaXRCLPMadMr1Gk80
 7G+apcp71zJWEe3IT4rldc/CAWRV/v+tE+x8ZOHJo5FS9Puhl1SoeOpq1R+nV5IKymiS6daoD
 5tWtLCyc9e1Dqm4gJqzH4/Ht9VkUcIby7v8s81M0Zz/kGvFnikydWdHIAyIA4Lc88zEndigrR
 kbB+Ylsfe+TqOEiGVf/DTyLBiEe3Lvy6iy5xhRwYJIsnuw59C/kmRA3rRfuTrwRuDJ9Ts/YSb
 WKGLE6WNUmm3/jrTdVYyEgskaiZRvdnQFD4Xq1gbplt5lAahMyeFNcC0EyHvOWua8iHay4ZVg
 KR0GnwjocQw0FC/pyWoOUgz0/UJDjYNhZHK/HjiHtCZ6TNHTGYmxopOUXW8IujBUISXK9P1Io
 i1S3SbnN3O6W+oEG829ek4ZdEovZ31aznT1A/incUH8J+4OOkxZtmV4hMHjnswCUg42DuXo/z
 I5nS04qTh8eg4eJEbKTuwvxzPjZk0VR8fLsJ7YapWLT/5nOA5g7YiKTInE7q4qjICruLH/IbX
 he8k8z0FtratJAvLDQ+vmQoxSM+i1p0n+0Jtj89zk/D46oxkz69XIMvZqt5UwoU/U4pMW9FQB
 0hMyuOFa0ESXGrpd7mEg==
X-Spam-Status: No, score=-98.9 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 17 Jul 2020 11:17:25 -0000

Hi Brian,

On Jul 16 21:35, Brian Inglis wrote:
> Just want to get feedback on how these FAQ changes should be packaged as patches
> (separate, series, single) and whether some of the changes should not be applied
> at all.
> 
> Summary
> 
> General:
> 
> change setup references to use the Cygwin Setup program;
> change Win32 references to Windows;

Please, no.  At least not where Win32 refers to the API.  While this is
called "Windows API" these days, the word Windows alone doesn't really
cut it.  At leats use "Windows API" then, or IMHO even better, use the
informal "WinAPI" abbreviation.

> reword net release or distribution references;

Uhm... example?  I'm not sure what you mean here.

> emphasize 64-bit Cygwin and setup-x86_64 over 32-bit;
> change see <ulink/> to place links around available wording;
> change <literal> for <filename> or <command> where appropriate;
> change bash .{ext1,ext2} usage to .ext1/.ext2;

Using comma separated lists within curly braces is the offical
shell way to express alternatives:

  $ echo a.{b,c}
  a.b a.c

Please keep them as is.

> trim trailing spaces highlighted by git diff.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
