Return-Path: <cygwin-patches-return-6170-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28668 invoked by alias); 16 Nov 2007 19:42:36 -0000
Received: (qmail 28629 invoked by uid 22791); 16 Nov 2007 19:42:35 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-70-20-17-24.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (70.20.17.24)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 16 Nov 2007 19:42:31 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 0F8652B352; Fri, 16 Nov 2007 14:42:30 -0500 (EST)
Date: Fri, 16 Nov 2007 19:42:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Encode invalid chars in /proc/registry entries
Message-ID: <20071116194229.GA9171@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <473CC0A6.6010409@t-online.de> <20071116110901.GK30894@calimero.vinschen.de> <20071116134022.GA7993@ednor.casa.cgf.cx> <473DF114.1090108@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473DF114.1090108@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00022.txt.bz2

On Fri, Nov 16, 2007 at 08:35:48PM +0100, Christian Franke wrote:
> Christopher Faylor wrote:
>> ..
>>>> Patch is tested with 1.5.24-2. Merge with HEAD looks good, but was not 
>>>> actually tested. Therefore, no changelog provided yet.
>>>>       
>>> Thanks for this patch.  Apart from the missing ChangeLog I'm inclined
>>> to apply it to the upcoming 1.5.25 release, but I don't like to have it
>>> in HEAD as is.
>>>     
>>
>>I'm not so sure it's appropriate for either yet.
>>
>>Isn't it possible to use at least some of the managed mode functions
>>which deal with munging characters to do some of encoding?  It seems
>>like the patch duplicates some of the functionality from path.cc.
>>
>>I realize that the registry is sort of the opposite of a managed mount
>>but it seems like the encoding functions might be potentially used in
>>reverse for this.
>
>I actually consulted path.cc before starting the patch but did not find
>any function which provides the required functionality OOTB.
>Therefore, I solved the tradeoff between "reuse" and "do not change
>working code if you don't have time for thorough regression testing" by
>the latter :-)

I'm sorry but "reuse" is a fairly important concept in a project like
this.  The proc functions, in particular, have been prone to NIH and I
don't want to see even more there if we can possibly help it.

So, I'll reiterate my suggestion that you look at, e.g.,
mount_item::fnmunge and possibly think about generalizing it if it isn't
quite up to the task.

I'll also go on record as advocating that this not be part of a bugfix
release.  It seems too much like a last minute change to me.

Getting it into cvs main, however, seems like a good idea.

cgf
