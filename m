Return-Path: <cygwin-patches-return-7151-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12195 invoked by alias); 11 Jan 2011 14:26:22 -0000
Received: (qmail 12154 invoked by uid 22791); 11 Jan 2011 14:26:20 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,TW_YG
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 11 Jan 2011 14:26:15 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.5]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 11 Jan 2011 14:26:12 +0000
Message-ID: <4D2C688E.9080204@dronecode.org.uk>
Date: Tue, 11 Jan 2011 14:26:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck -s should not imply -d
References: <4D24CB9A.2030906@dronecode.org.uk> <20110110125102.GA14789@calimero.vinschen.de> <20110110175244.GC10806@ednor.casa.cgf.cx> <20110111081043.GB8899@calimero.vinschen.de>
In-Reply-To: <20110111081043.GB8899@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00006.txt.bz2

On 11/01/2011 08:10, Corinna Vinschen wrote:
> On Jan 10 12:52, Christopher Faylor wrote:
>> On Mon, Jan 10, 2011 at 01:51:02PM +0100, Corinna Vinschen wrote:
>>> On Jan  5 19:50, Jon TURNEY wrote:
>>>>
>>>> Currently, for cygcheck -s implies -d.  This seems rather unhelpful.
>>>>
>>>> I'm afraid I've lost the thread which inspired this, but in it the reporter
>>>> provided cygcheck -svr output as requested, but this did not help diagnose
>>>> what ultimately turned out to be the problem, that a DLL was actually an older
>>>> version (presumably due to replace-in-use problems)
>>>>
>>>> Attached a patch to modify cygcheck so -s no longer implies -d (although -d
>>>> can still be used).
>>>>
>>>
>>>>
>>>> 2011-01-05  Jon TURNEY
>>>>
>>>> 	* cygcheck.cc (main): don't imply -d from -s option to cygcheck
>>>
>>> Looks good to me.  Applied.
>>
>> Sorry that I didn't reply to this.  I wasn't 100% convinced that this
>> was a good idea since some of the packages show up as having problems
>> when they are ok.  I was wondering if that would end up generating more
>> (understandably) confused mailing list traffic but I guess, in the end,
>> it probably is better to check the validity of the packages for the
>> prescribed error reporting technique.
> 
> I wasn't quite sure either, but while running cygcheck with Jon's patch
> it started to make more sense.  We can also change the docs to ask for
> `cygcheck -svrd' output, but I guess we should just wait and see.

FWIW (I don't have all packages installed), mutt is the only package I have
installed for which cygcheck -c falsely reports a problem.

$ cygcheck -c | grep -v OK
Cygwin Package Information
Package                        Version                  Status
mutt                           1.5.20-1                 Incomplete

Would a patch to http://cygwin.com/setup.html be welcome recommending that:
(a) if a package installs files which a user is expected to customize, don't
trample over those customizations when the package is upgraded/reinstalled
(b) a package should verify as correctly installed with cygcheck -c?
