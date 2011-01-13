Return-Path: <cygwin-patches-return-7153-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2504 invoked by alias); 13 Jan 2011 13:04:34 -0000
Received: (qmail 2494 invoked by uid 22791); 13 Jan 2011 13:04:33 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,TW_YG
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 13 Jan 2011 13:04:26 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.5]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 13 Jan 2011 13:04:24 +0000
Message-ID: <4D2EF866.9090809@dronecode.org.uk>
Date: Thu, 13 Jan 2011 13:04:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck -s should not imply -d
References: <4D24CB9A.2030906@dronecode.org.uk> <20110110125102.GA14789@calimero.vinschen.de> <20110110175244.GC10806@ednor.casa.cgf.cx> <20110111081043.GB8899@calimero.vinschen.de> <4D2C688E.9080204@dronecode.org.uk> <20110113123336.GA25033@calimero.vinschen.de>
In-Reply-To: <20110113123336.GA25033@calimero.vinschen.de>
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
X-SW-Source: 2011-q1/txt/msg00008.txt.bz2

On 13/01/2011 12:33, Corinna Vinschen wrote:
> On Jan 11 14:26, Jon TURNEY wrote:
>> On 11/01/2011 08:10, Corinna Vinschen wrote:
>>> I wasn't quite sure either, but while running cygcheck with Jon's patch
>>> it started to make more sense.  We can also change the docs to ask for
>>> `cygcheck -svrd' output, but I guess we should just wait and see.
>>
>> FWIW (I don't have all packages installed), mutt is the only package I have
>> installed for which cygcheck -c falsely reports a problem.
>>
>> $ cygcheck -c | grep -v OK
>> Cygwin Package Information
>> Package                        Version                  Status
>> mutt                           1.5.20-1                 Incomplete
> 
> Do you happen to know why?

You can read my ill-informed speculation about this matter at [1] :-)

[1] http://sourceware.org/ml/cygwin-apps/2010-11/msg00065.html

>> Would a patch to http://cygwin.com/setup.html be welcome recommending that:
>> (a) if a package installs files which a user is expected to customize, don't
>> trample over those customizations when the package is upgraded/reinstalled
> 
> Isn't that what /etc/defaults and /etc/postinstall is for, basically?
> I'm not sure I understand what you're proposing.  At which point should
> setup warn and how is it supposed to know that a file is a
> user-customizable one?  In theory, that's all in the responsibility
> of the package.

Sorry, that URL isn't very helpfully named.  I'm not proposing to change
setup.exe, I'm just suggesting adding some text to the 'Cygwin Package
Contributor's Guide' web page, recommending those things. (I only became aware
of the existence of /etc/defaults by looking at what other packages do, I
can't see it mentioned on that page)

>> (b) a package should verify as correctly installed with cygcheck -c?
> 
> I don't understand this, sorry.  Would you mind to rephrase and maybe
> give an example what you mean?
