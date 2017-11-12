Return-Path: <cygwin-patches-return-8918-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91568 invoked by alias); 12 Nov 2017 23:02:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91541 invoked by uid 89); 12 Nov 2017 23:02:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-3.0 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=qualifies, sentence, accurate, contacting
X-HELO: limerock04.mail.cornell.edu
Received: from limerock04.mail.cornell.edu (HELO limerock04.mail.cornell.edu) (128.84.13.244) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 12 Nov 2017 23:02:16 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock04.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id vACN2DF3028122	for <cygwin-patches@cygwin.com>; Sun, 12 Nov 2017 18:02:14 -0500
Received: from [192.168.0.15] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id vACN2Cwe023522	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Sun, 12 Nov 2017 18:02:13 -0500
Subject: Re: [PATCH] Add FAQ 4.46. How do I fix find_fast_cwd warnings?
To: cygwin-patches@cygwin.com
References: <ac78412d-748f-ed22-473e-9d101f7bde2f@SystematicSw.ab.ca> <0cf17d74-23a4-f08d-fd67-afed0bd3be9d@cornell.edu> <e4e9d518-3a00-6d60-f653-7162711e9672@SystematicSw.ab.ca>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <8be9463b-1349-c309-afe1-828712489f74@cornell.edu>
Date: Sun, 12 Nov 2017 23:02:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <e4e9d518-3a00-6d60-f653-7162711e9672@SystematicSw.ab.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00048.txt.bz2

On 11/12/2017 4:27 PM, Brian Inglis wrote:
> +    <para>Some ancient Cygwin releases asked users to report problems that were
> +      difficult to diagnose to the mailing list with the message:</para>
> +
> +    <screen>find_fast_cwd: WARNING: Couldn't compute FAST_CWD pointer. Please report
> +    this problem to the public mailing listcygwin@cygwin.com</screen>
> +
> +    <para>These problems were fixed long ago in updated Cygwin releases.</para>

The wording of the warning message was changed 3 years ago, in commit 
0793492.  I'm not sure that qualifies as ancient.  I also don't think 
it's accurate to refer to the problem as "difficult to diagnose" or to 
say that the problems "were fixed long ago".

The issue (Corinna will correct me if I'm wrong) is simply that new 
releases of Windows sometimes require changes in how Cygwin finds the 
fast_cwd pointer.  So users of old versions of Cygwin on new versions of 
Windows might have problems, and this can certainly happen again in the 
future.  But the FAQ doesn't need to go into that.  Why not just say 
what the warning currently says (see path.cc:find_fast_cwd()):

"This typically occurs if you're using an older Cygwin version on a 
newer Windows.  Please update to the latest available Cygwin version 
from https://cygwin.com/.  If the problem persists, please see 
https://cygwin.com/problems.html."

You can also add your sentence about contacting the vendor who provided 
the old Cygwin release.

Ken
