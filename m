Return-Path: <cygwin-patches-return-6234-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3732 invoked by alias); 8 Jan 2008 20:20:15 -0000
Received: (qmail 3721 invoked by uid 22791); 8 Jan 2008 20:20:15 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 08 Jan 2008 20:19:57 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Tue, 8 Jan 2008 20:19:55 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
References: <074301c84a42$46df85d0$2e08a8c0@CAM.ARTIMI.COM> <20071229180628.GE24999@ednor.casa.cgf.cx> <000b01c84d71$8acf6530$2e08a8c0@CAM.ARTIMI.COM> <20080102190756.GA1178@ednor.casa.cgf.cx> <000f01c84d78$23aaf5c0$2e08a8c0@CAM.ARTIMI.COM> <20080107130921.GN29568@calimero.vinschen.de>
Subject: RE: BLODA FAQ entry.
Date: Tue, 08 Jan 2008 20:20:00 -0000
Message-ID: <006601c85233$d4ca0c00$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20080107130921.GN29568@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00008.txt.bz2

On 07 January 2008 13:09, Corinna Vinschen wrote:

> On Jan  2 19:46, Dave Korn wrote:
>> On 02 January 2008 19:08, Christopher Faylor wrote:
>>> On Wed, Jan 02, 2008 at 06:59:03PM -0000, Dave Korn wrote:

>>>>  Hmm, I thought the website might update itself automagically when the
>>>> sources are changed, but I guess not.  How do we get the online version
>>>> of the FAQ to rebuild?
>>> 
>>> It isn't automatic.  I usually wait for "someone" with dessent skills in
>>> creating the pages and transferring them to the right location to do this.
>>> 
>>> cgf
>> 
>>   Ah.  Who, to judge from lack of posting, is still away on xmas/newyear
>> break of some description. 

> Erm... are you talking about me, by any chance?  

  I don't think so... I think the clue is in the typo :)

> I have now updated the FAQ.

  But thanks nonetheless!

>  Fortunately it's quite simple by using cvs.  I don't know
> of any hidden gotchas.  If there are any, I'd be as screwed up as
> anybody :)

  So as far as you know we just build winsup as normal and commit the
generated html files as new revisions over the existing ones in wwwdocs, yep?
That's kinda what I expected but I always like to hear from someone who's done
something before, because they might know about the unknown unknowns...

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
