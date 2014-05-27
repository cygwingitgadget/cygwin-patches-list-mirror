Return-Path: <cygwin-patches-return-7996-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21442 invoked by alias); 27 May 2014 15:09:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21196 invoked by uid 89); 27 May 2014 15:09:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.1 required=5.0 tests=AWL,BAYES_20,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: smtpout09.bt.lon5.cpcloud.co.uk
Received: from smtpout09.bt.lon5.cpcloud.co.uk (HELO smtpout09.bt.lon5.cpcloud.co.uk) (65.20.0.129) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 27 May 2014 15:09:16 +0000
X-CTCH-RefID: str=0001.0A090205.5384AA99.0027,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=7/97,refid=2.7.2:2014.5.24.103620:17:7.944,ip=,rules=__MOZILLA_MSGID, __HAS_MSGID, __SANE_MSGID, __HAS_FROM, __USER_AGENT, __MOZILLA_USER_AGENT, __MIME_VERSION, __TO_MALFORMED_2, __TO_NO_NAME, __BOUNCE_CHALLENGE_SUBJ, __BOUNCE_NDR_SUBJ_EXEMPT, __IN_REP_TO, __CT, __CT_TEXT_PLAIN, __CTE, __ANY_URI, __URI_NO_MAILTO, __URI_NO_WWW, __URI_NO_PATH, __SUBJ_ALPHA_NEGATE, __FORWARDED_MSG, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_1000_1099, __MIME_TEXT_ONLY, HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, BODY_SIZE_2000_LESS, BODY_SIZE_7000_LESS
X-CTCH-Spam: Unknown
Received: from [192.168.1.93] (86.139.179.106) by smtpout09.bt.lon5.cpcloud.co.uk (8.6.100.99.10223) (authenticated as jonturney@btinternet.com)        id 537BBB7500729C3D for cygwin-patches@cygwin.com; Tue, 27 May 2014 16:09:12 +0100
Message-ID: <5384AA8F.9070607@dronecode.org.uk>
Date: Tue, 27 May 2014 15:09:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Rename detached debug info as cygwin1.dll.dbg
References: <537F4FD9.8050203@dronecode.org.uk> <20140523140534.GB750@calimero.vinschen.de> <20140525035338.GA7252@ednor.casa.cgf.cx>
In-Reply-To: <20140525035338.GA7252@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2014-q2/txt/msg00019.txt.bz2

On 25/05/2014 04:53, Christopher Faylor wrote:
> On Fri, May 23, 2014 at 04:05:34PM +0200, Corinna Vinschen wrote:
>> On May 23 14:40, Jon TURNEY wrote:
>>>
>>> Not sure if this is wanted, and it obviously has some knock on effects on
>>> package and snapshot generation.
>>>
>>> But, cygport names detached debug info files by appending the .dbg suffix.
>>> This is 'obviously correct' as it means that both a foo.exe and foo.dll can
>>> exist and have detached debug info.
>>>
>>> For consistency, the attached patch changes the name of the detached debug
>>> info file for cygwin1.dll from cygwin1.dbg to cygwin1.dll.dbg
>>
>> As far as releases go, this is ok.  I'll just have to tweak the next
>> cygport file slightly.
>>
>> Chris might have to tweak the snapshot generation script as well, so
>> he probably wants to chime in, too.
>
> It's more than just a tweak.  I've known that there is a discrepancy for
> a long time but haven't considered it that big a deal.  I'd prefer that
> this change not be made.

Fair enough.  Patch withdrawn.
