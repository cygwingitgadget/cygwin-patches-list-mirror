Return-Path: <cygwin-patches-return-6776-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13707 invoked by alias); 16 Oct 2009 10:02:27 -0000
Received: (qmail 13495 invoked by uid 22791); 16 Oct 2009 10:02:26 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 16 Oct 2009 10:02:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 482846D5598; Fri, 16 Oct 2009 12:02:10 +0200 (CEST)
Date: Fri, 16 Oct 2009 10:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] Case-sensitive programs exist but cannot both be run
Message-ID: <20091016100210.GC31638@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AD7F017.5080609@users.sourceforge.net> <20091016080302.GO27964@calimero.vinschen.de> <4AD832FB.2050901@users.sourceforge.net> <4AD8393C.6040805@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AD8393C.6040805@lysator.liu.se>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00107.txt.bz2

On Oct 16 11:13, Peter Rosin wrote:
> Den 2009-10-16 10:46 skrev Yaakov (Cygwin/X):
>> On 16/10/2009 03:03, Corinna Vinschen wrote:
>>> On Oct 15 23:01, Yaakov S wrote:
>>>> It appears that two EXEs can coexist (with the registry setting) but 
>>>> only
>>>> whichever one was so named first will be run:
>>>> [...]
>>>> Bug?  Limitation?  If it hurts, don't do that?
>>>
>>> Limitation.  While we can do everything with files using native NT
>>> calls, we can't use NtCreateProcess to create new processes.  We
>>> have to use CreateProcess, and there's no flag available which defines
>>> case-sensitivity for this call, unfortunately.
>>
>> In that case, let's document it.  Patch attached.
>
> *snip*
>
>> +trying to run either of them will always run whichever was so named 
>> first.  
>
> I suspect that you don't necessarily get the one which was named first. My
> guess is that you'll get whichever file happening to appear first in the
> unsorted directory list. Seems bad to make "promises" in the docs in this
> case...

Something along the lines of "there's no way to determine which one of
it will be started since starting applications is still case-insensitive
due to WIndows limitations" might make sense.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
