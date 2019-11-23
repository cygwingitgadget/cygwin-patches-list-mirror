Return-Path: <cygwin-patches-return-9856-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90585 invoked by alias); 23 Nov 2019 15:09:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90576 invoked by uid 89); 23 Nov 2019 15:09:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=june, June, dates, 1210
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Nov 2019 15:09:51 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id YX2hiDEno17ZDYX2jit8IM; Sat, 23 Nov 2019 08:09:49 -0700
Reply-To: Brian.Inglis@SystematicSw.ab.ca
To: Cygwin Patches <cygwin-patches@cygwin.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Subject: newlib/libc/include/sys/features.h: Cygwin Unicode level
Openpgp: preference=signencrypt
Message-ID: <9d9b6d93-eb25-5f08-015a-ec3675232201@SystematicSw.ab.ca>
Date: Sat, 23 Nov 2019 15:09:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00127.txt.bz2

Should the Unicode version setting of Cygwin feature macro __STDC_ISO_10646__ at
the tail of {newlib/libc,/usr}/include/sys/features.h be updated to reflect
Thomas Wolff's and any subsequent updates of the encoding tables to Unicode
version 10/11/12:

	Unicode Release Dates
Version	Year	Month (Day)	Value
12.1.0	2019	May 7		201905L
12.0.0	2019	March 5		201903L
11.0.0	2018	June 5		201806L
10.0.0	2017	June 20		201706L

$ tail {newlib/libc,/usr}/include/sys/features.h
/* The value corresponds to UNICODE version 5.2, which is the current
   state of newlib's wide char conversion functions. */
#define __STDC_ISO_10646__ 200910L

#endif /* __CYGWIN__ */

#ifdef __cplusplus
}
#endif
#endif /* _SYS_FEATURES_H */
...

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
