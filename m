Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id F15263858C39
 for <cygwin-patches@cygwin.com>; Sat, 15 Jan 2022 05:04:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org F15263858C39
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
 by cmsmtp with ESMTP
 id 8RapnoZ6Fyr5H8bFLndRxh; Sat, 15 Jan 2022 05:04:59 +0000
Received: from [192.168.1.105] ([68.147.0.90]) by cmsmtp with ESMTP
 id 8bFLnhR74a4s18bFLnmooK; Sat, 15 Jan 2022 05:04:59 +0000
X-Authority-Analysis: v=2.4 cv=S9vKfagP c=1 sm=1 tr=0 ts=61e255fb
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=Gy0Mbyy3tbmLecltDXIA:9 a=QEXdDO2ut3YA:10
 a=daI9ojH3vpgA:10 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <69605334-cded-ed59-4d8b-0477cdaf5b40@SystematicSw.ab.ca>
Date: Fri, 14 Jan 2022 22:04:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Conditionally build documentation
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <DM8PR09MB70950BB104F774E1F959F7BEA5549@DM8PR09MB7095.namprd09.prod.outlook.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <DM8PR09MB70950BB104F774E1F959F7BEA5549@DM8PR09MB7095.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCkivqGHSR5dIfPQmyGzsUHrm9/Y38TdVQM4sfjFEXzpLzd/2I3v0Vchl1VWKhvDMZiW5SbENE7Lv77v2O0RHeXJtRJZ0bru0MppR0A+xNBUxgBtBVS1
 AHaHaLBxcfN3mNDxxnc3dkaw6liAbXI8+CYEpvvk816xkmGT9lPsh0kE3xlNI4wLnOWXlxSPwT1NgN5eWt3gx8shhKHPF3k/ick=
X-Spam-Status: No, score=-1160.7 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_BARRACUDACENTRAL,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sat, 15 Jan 2022 05:05:02 -0000


On 2022-01-14 13:18, Lavrentiev, Anton (NIH/NLM/NCBI) [C] wrote:
>> Add a configure option '--disable-doc' to disable building of the
>> documentation by the 'all' target.

> Can you please also add --disable-doc to "configure --help"?  It took me awhile to figure out which option I should use to skip the doc from building because it does no longer ignore doc build failure by default (unlike it used to do).  Also this fact is not reflected in the FAQ here:
> 
> https://cygwin.com/faq.html#faq.programming.building-cygwin
> 
> which still mentions the doc build errors ignored:

>> Normally, building ignores any errors in building the documentation

Updated by Jon a month ago:

https://cygwin.com/git/?p=newlib-cygwin.git;a=commitdiff;h=f4a26ececa180cec70c41b6dd2082ff730f92065

winsup/configure.ac:
...
+AC_ARG_ENABLE(doc,
+             [AS_HELP_STRING([--enable-doc], [Build documentation])],,
+             enable_doc=yes)
+AM_CONDITIONAL(BUILD_DOC, [test $enable_doc != "no"])
...

winsup/faq-programming.xml:
...
+Building the documentation also requires the <literal>dblatex</literal>,
+<literal>docbook2X</literal>, <literal>docbook-xml45</literal>,
+<literal>docbook-xsl</literal>, and <literal>xmlto</literal> packages. 
  Building
+the documentation can be disabled with the <literal>--disable-doc</literal>
+option to <literal>configure</literal>.
...

probably won't appear on the web site until the next release.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
