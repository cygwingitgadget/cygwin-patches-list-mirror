Return-Path: <cygwin-patches-return-8829-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1541 invoked by alias); 19 Aug 2017 17:14:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1454 invoked by uid 89); 19 Aug 2017 17:13:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=Requirements, HTo:U*cygwin-patches
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 19 Aug 2017 17:13:51 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v7JHDmq0016991	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 13:13:49 -0400
Received: from [192.168.0.4] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v7JHDlJo004213	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 13:13:48 -0400
Subject: Re: renameat2
To: cygwin-patches@cygwin.com
References: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu> <20170818151525.GA6314@calimero.vinschen.de> <f7e3cc27-6989-54d8-8e3e-c11cdd5dfeca@cornell.edu> <20170819095707.GE6314@calimero.vinschen.de> <68b3c713-3261-e9d7-0865-384d18553744@cornell.edu> <20170819162828.GF6314@calimero.vinschen.de> <20170819163720.GA16422@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <0dd9fa10-9fb9-0848-72b5-920c7b6c20c3@cornell.edu>
Date: Sat, 19 Aug 2017 17:51:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170819163720.GA16422@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00031.txt.bz2

On 8/19/2017 12:37 PM, Corinna Vinschen wrote:
> Oh, one more thing.  This is a question to Yaakov, too.
> 
> diff --git a/newlib/libc/include/stdio.h b/newlib/libc/include/stdio.h
> index 5d8cb1092..331a1cf07 100644
> --- a/newlib/libc/include/stdio.h
> +++ b/newlib/libc/include/stdio.h
> @@ -384,6 +384,9 @@ int _EXFUN(vdprintf, (int, const char *__restrict, __VALIST)
>   #endif
>   #if __ATFILE_VISIBLE
>   int    _EXFUN(renameat, (int, const char *, int, const char *));
> +# ifdef __CYGWIN__
> +int    _EXFUN(renameat2, (int, const char *, int, const char *, unsigned int));
> +# endif
>   #endif
> 
> Does it makes sense to guard the renameat2 prototype more extensively
> to cater for standards junkies?  __MISC_VISIBLE, perhaps?

I'll defer to Yaakov.  But here's a related question.  Is renameat
currently guarded properly?  The Linux man page says:

Feature Test Macro Requirements for glibc (see feature_test_macros(7)):

       renameat():
           Since glibc 2.10:
               _POSIX_C_SOURCE >= 200809L
           Before glibc 2.10:
               _ATFILE_SOURCE

This suggests that we should do something like the following:

diff --git a/newlib/libc/include/stdio.h b/newlib/libc/include/stdio.h
index 331a1cf07..9eb0964f2 100644
--- a/newlib/libc/include/stdio.h
+++ b/newlib/libc/include/stdio.h
@@ -381,8 +381,6 @@ FILE *      _EXFUN(open_memstream, (char **, size_t *));
 int    _EXFUN(vdprintf, (int, const char *__restrict, __VALIST)
                _ATTRIBUTE ((__format__ (__printf__, 2, 0))));
 # endif
-#endif
-#if __ATFILE_VISIBLE
 int    _EXFUN(renameat, (int, const char *, int, const char *));
 # ifdef __CYGWIN__
 int    _EXFUN(renameat2, (int, const char *, int, const char *, unsigned int));

Ken
