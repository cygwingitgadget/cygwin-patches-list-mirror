Return-Path: <cygwin-patches-return-5767-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13266 invoked by alias); 17 Feb 2006 15:06:12 -0000
Received: (qmail 13255 invoked by uid 22791); 17 Feb 2006 15:06:11 -0000
X-Spam-Check-By: sourceware.org
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 17 Feb 2006 15:06:09 +0000
Received: from rainbow ([192.168.1.165]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 17 Feb 2006 15:06:07 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] cygcheck: follow symbolic links
Date: Fri, 17 Feb 2006 15:06:00 -0000
Message-ID: <012701c633d3$adb73960$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.GSO.4.63.0602170902090.1592@access1.cims.nyu.edu>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00076.txt.bz2

On 17 February 2006 14:05, Igor Peshansky wrote:

> On Fri, 17 Feb 2006, Dave Korn wrote:
> 
>> On 16 February 2006 17:27, Igor Peshansky wrote:
>> 
>>> On Thu, 16 Feb 2006, Corinna Vinschen wrote:
>> 
>>>> - Couldn't you just reuse the readlink implementation in
>>>>   ../cygwin/path.cc as is, to avoid having to different implementations?
>>> 
>>> Umm, most of that code is very general purpose, and has too much extra
>>> stuff in it.
>> 
>>   I think you may have misoptimised for speed rather than
>> maintainability. Cygcheck isn't something that people expect to run a
>> million times per second in an inner loop.
> 
> No, but I thought ease of understanding implied maintainability...

  Yes, but cutting and pasting the same code into a duplicated location
doesn't make it any clearer, and in fact it impacts both maintainability _and_
clarity when it starts to diverge and someone come to look at it six months
later and wonders "Why has this functionality been implemented twice and why
are the two versions slightly different and which one is meant to be the right
way of doing it"

> Besides, I'm sure binutils, for one, has the code for reading chunks of
> application code and finding the DLL dependencies -- why aren't we reusing
> that?  The answer: too much work to extract the needed bits in the form
> that would be usable in both places.

  hmmm... maybe we should think about that....


>>>  I basically used part of it (symlink_info::check_shortcut)
>>> for my implementation.  I wanted something lightweight and easy to
>>> understand
>> 
>>   Perhaps you could have just exported it (or a convenient interface to
>> it) instead?
> 
> Ahem.  You are forgetting that cygcheck is not a Cygwin program, so we
> can't introduce a dependency on cygwin1.dll.  We'd have to create an
> independent (static?) library that both cygcheck and Cygwin depended on...

  Not necessarily.  We could unify it so they both build from the same one
single shared copy of path.cc instead of having the real deal in winsup/cygwin
and a stripped down copy that has to be manually synced every now and again in
winsup/utils... of course, that's really getting fairly sidetracked from the
issue you were trying to directly deal with.  But longterm it would be good if
they both got their code from the same place.

  Hey, does anyone know off the top of their heads of any other chunks of code
shared like this between cygwin and utils?  I could make it a sort-of long
term code tidyup project to try and get better sharing and reuse...


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
