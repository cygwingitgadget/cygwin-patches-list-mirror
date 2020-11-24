Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 46CC3385700A
 for <cygwin-patches@cygwin.com>; Tue, 24 Nov 2020 10:52:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 46CC3385700A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7NaW-1kZpt40XZU-007oF0; Tue, 24 Nov 2020 11:52:06 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 653AAA80974; Tue, 24 Nov 2020 11:52:05 +0100 (CET)
Date: Tue, 24 Nov 2020 11:52:05 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH 0/2] winsup/doc/: add proc(5) man page
Message-ID: <20201124105205.GV303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
 Jon TURNEY <jon.turney@dronecode.org.uk>
References: <20201123221101.16864-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123221101.16864-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:iE0cXm3EwmU7HPnHQJ8ua//Tg5jtjIiVrboo4UMUzWLAlB0/EM9
 mj4dYj4D81tTZp8tf+JSNllGI8yRCpkTW6GezUa7ZgnTvoA+BHPLwffva72Ac4tzvqI4IiK
 b7er7V0Z+39wN46GQp6/GzkeaY+jX3LH7Aoz6YXZM+PDC6OtvVV3YA8n91DIYbFf1qagb+F
 gADbl4zCROuYDFuiMPy+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p0loKo5hqh8=:fVU3NT2ypOShzqgbxscpWJ
 xJef9f8I7MXM0o6aPxJVB/bGZg3SxhcrvT79VHtugXDvWwlglCsNvyLHocNTyMo8zVCO3p/w5
 EkxCxc/mu1q4iifIVr8vK108Q0VBnzKcDj4JL6BWeMmfThZUV1vGH/CpDG+BYr3UipDlcP4OP
 zDz29b2ilsgjelaItHnSiqa8gvWSsC1Ej98XB5KrvUvj4Eina3x/QgAezmvbqQ41+75PFn7/1
 ra6JKnRjFfV9V+/tRfK0hzkGxaifRmh6L4sp8Qv+PrCmn1RdUrpQKt8K+GQroVVh8gQ3Vl1xv
 uGbdLy6YZsmqrCjv6ch3qA/TH1zwZ81IhSNmnyqKwOiJOxvK0baVZGxNYKY9C2aEgIBEiI5e3
 1tUQE1TFfIRfnSnjNB+uhh6uZwLfX0lVu9QonJaY7tOTffK20wfa5Zyf8768GE053FhY/KE9N
 do1BGtQf3Q==
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
X-List-Received-Date: Tue, 24 Nov 2020 10:52:13 -0000

On Nov 23 15:10, Brian Inglis wrote:
> Hacked a Cygwin proc.5 man page, by combing through fhandler_proc...,
> converted to proc-5.xml using doclifter, included after pathnames-proc
> before pathnames-proc-registry sections in specialnames.xml, and
> modified to match and create a refentry to generate proc(5) man page.
> 
> One of the issues with the xml input is that formatting wide screen
> displays as if at .in 0 appears to be impossible, or at least not in
> evidence in any of the other inputs or outputs, which don't include such
> heavily indented lists of lists, and ending and restarting heavy
> indenting context appears ugly.
> 
> Brian Inglis (2):
>   specialnames.xml: add proc(5) Cygwin man page
>   winsup/doc/Makefile.in: create man5 dir and install generated proc.5
> 
>  winsup/doc/Makefile.in      |    4 +
>  winsup/doc/specialnames.xml | 2100 +++++++++++++++++++++++++++++++++++
>  2 files changed, 2104 insertions(+)
> 
> -- 
> 2.29.2

LGTM.  Jon, can you take a look, too, please?


Thanks,
Corinna
