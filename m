Return-Path: <cygwin-patches-return-7962-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29013 invoked by alias); 8 Feb 2014 15:00:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28999 invoked by uid 89); 8 Feb 2014 15:00:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: smtpout09.bt.lon5.cpcloud.co.uk
Received: from smtpout09.bt.lon5.cpcloud.co.uk (HELO smtpout09.bt.lon5.cpcloud.co.uk) (65.20.0.129) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 08 Feb 2014 15:00:30 +0000
X-CTCH-RefID: str=0001.0A090208.52F6468B.014F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=7/97,refid=2.7.2:2014.2.8.111214:17:7.944,ip=,rules=__MOZILLA_MSGID, __HAS_MSGID, __SANE_MSGID, __HAS_FROM, __USER_AGENT, __MOZILLA_USER_AGENT, __MIME_VERSION, __TO_MALFORMED_2, __TO_NO_NAME, __BOUNCE_CHALLENGE_SUBJ, __BOUNCE_NDR_SUBJ_EXEMPT, __SUBJ_ALPHA_END, __IN_REP_TO, __CT, __CT_TEXT_PLAIN, CT_TEXT_PLAIN_UTF8_CAPS, __CTE, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __SUBJ_ALPHA_NEGATE, __FORWARDED_MSG, BODY_SIZE_1300_1399, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, __URI_NS, HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, BODY_SIZE_2000_LESS, BODY_SIZE_7000_LESS
X-CTCH-Spam: Unknown
Received: from [192.168.1.72] (86.174.32.243) by smtpout09.bt.lon5.cpcloud.co.uk (8.6.100.99.10223) (authenticated as jonturney@btinternet.com)        id 52F02AF9004ADB7F for cygwin-patches@cygwin.com; Sat, 8 Feb 2014 15:00:27 +0000
Message-ID: <52F64694.9060102@dronecode.org.uk>
Date: Sat, 08 Feb 2014 15:00:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add minidump write utility
References: <52F50B71.8030608@dronecode.org.uk> <20140207174431.GA1640@ednor.casa.cgf.cx> <20140207191826.GA20749@calimero.vinschen.de>
In-Reply-To: <20140207191826.GA20749@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2014-q1/txt/msg00035.txt.bz2

On 07/02/2014 19:18, Corinna Vinschen wrote:
> On Feb  7 12:44, Christopher Faylor wrote:
>> On Fri, Feb 07, 2014 at 04:36:01PM +0000, Jon TURNEY wrote:
>>>
>>> This patch adds a 'minidumper' utility, which functions identically to
>>> 'dumper' except it writes a Windows minidump, rather than a core file.
>>> 	
>>> I'm not sure if this is of use to anyone but me, but since I've had the patch
>>> sitting around for a couple of years, here it is...
>>>
>>> 2014-02-07  Jon TURNEY  <jon.turney@dronecode.org.uk>
>>>
>>> 	* minidumper.cc: New file.
>>> 	* Makefile.in (CYGWIN_BINS): Add minidumper.
>>> 	* utils.xml (minidumper): New section.
>>
>> This is awesome.  Thanks.
>>
>> Could you add Red Hat as the copyright holder, like dumper.cc?
>>
>> You can feel free to check this in and update it as you see fit.
>>
>> Thanks for doing this.
> 
> I agree, but, like some other parts of our utils, you don't have to put
> the Red Hat copyright in there if you go with a BSD-style license, Jon.
> Look at the header of ldd.cc.  This is fine for new Cygin utils.

I prefer the GPL.  I will adjust the copyright holder as requested.

> Just one, really important point:  Would you mind to add documentation
> for the tool and its usage to utils.xml?

Um, I already did?
