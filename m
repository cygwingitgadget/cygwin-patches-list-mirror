Return-Path: <cygwin-patches-return-7641-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13575 invoked by alias); 17 Apr 2012 20:37:44 -0000
Received: (qmail 13408 invoked by uid 22791); 17 Apr 2012 20:37:42 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,KHOP_THREADED,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_NO,TW_BJ,TW_YG,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout01.t-online.de (HELO mailout01.t-online.de) (194.25.134.80)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 17 Apr 2012 20:37:28 +0000
Received: from fwd06.aul.t-online.de (fwd06.aul.t-online.de )	by mailout01.t-online.de with smtp 	id 1SKF9S-00073A-Cm; Tue, 17 Apr 2012 22:37:26 +0200
Received: from [192.168.2.108] (XV0-uwZvohtDWCaG241rR+OzieGvxFl1Xi2oSPVAG68V54K5C6UnlWtKAXUwy8dwCW@[79.224.113.222]) by fwd06.t-online.de	with esmtp id 1SKF9M-1DDyW80; Tue, 17 Apr 2012 22:37:20 +0200
Message-ID: <4F8DD47E.30907@t-online.de>
Date: Tue, 17 Apr 2012 20:37:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120312 Firefox/11.0 SeaMonkey/2.8
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Setting TZ may break time() in non-Cygwin programs
References: <4F4FD8C6.5000807@t-online.de> <20120302091317.GD14404@calimero.vinschen.de> <4F513D11.2080203@t-online.de> <20120304115232.GC18852@calimero.vinschen.de> <4F53B791.2090709@t-online.de> <20120304204938.GL18852@calimero.vinschen.de> <4F85D2F4.8090204@t-online.de> <20120417070615.GA22155@calimero.vinschen.de> <20120417141947.GB15491@ednor.casa.cgf.cx>
In-Reply-To: <20120417141947.GB15491@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2012-q2/txt/msg00010.txt.bz2

Christopher Faylor wrote:
> On Tue, Apr 17, 2012 at 09:06:15AM +0200, Corinna Vinschen wrote:
>> On Apr 11 20:52, Christian Franke wrote:
>>> Yes. Patch is attached.
>>>
>>> Christian
>>>
>> Thanks for the patch.  I'm just wondering if we shouldn't generalize
>> this right from the start by keeping an array of variables to skip
>> when starting native apps and a function to handle this, along the
>> lines of the getwinenv function and the conv_envvars array.
>> It might only contain TZ now, but there's always a chance we suddenly
>> stumble over a similar problem, isn't it?
> I really hate having Cygwin be "smart" like this.  It seems like it's
> asking for a follow-on "How do I set TZ for my Windoze program???"
> email, followed by a "We need a CYGWIN environment variable option!"
>
> What's the problem with just unsetting TZ again?  Yes, I know you
> have to remember to do it but does this affect enough programs that
> we need to add even more head standing code in Cygwin to accommodate
> it.

It affects all C/C++ programs which use time() and friends from any 
version of MSVCRT as DLL or static library.

Which means that cygcheck is also affected:

$ echo $TZ
Europe/Berlin

$ objdump -p /bin/cygwin1.dll | grep 'Time/Date[^ ]'
Time/Date               Sun Apr 15 19:56:27 2012

$ cygcheck -v /bin/cygwin1.dll | grep 'cygwin1.*ts'
   "cygwin1.dll" v0.0 ts=2012/4/15 18:56

$ export TZ=America/Los_Angeles

$ objdump -p /bin/cygwin1.dll | grep 'Time/Date[^ ]'
Time/Date               Sun Apr 15 10:56:27 2012

$ cygcheck -v /bin/cygwin1.dll | grep 'cygwin1.*ts'
   "cygwin1.dll" v0.0 ts=2012/4/15 18:56

$ unset TZ

$ objdump -p /bin/cygwin1.dll | grep 'Time/Date[^ ]'
Time/Date               Sun Apr 15 19:56:27 2012

$ cygcheck -v /bin/cygwin1.dll | grep 'cygwin1.*ts'
   "cygwin1.dll" v0.0 ts=2012/4/15 19:56


In this case the effect is harmless. In other cases it may break 
functionality.

Christian
