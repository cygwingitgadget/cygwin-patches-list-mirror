Return-Path: <cygwin-patches-return-5922-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17818 invoked by alias); 7 Jul 2006 06:28:16 -0000
Received: (qmail 17704 invoked by uid 22791); 7 Jul 2006 06:28:12 -0000
X-Spam-Check-By: sourceware.org
Received: from okigate.oki.co.jp (HELO iscan1.intra.oki.co.jp) (202.226.91.194)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Jul 2006 06:28:10 +0000
Received: from s24c53.dm1.oii.oki.co.jp (IDENT:root@localhost.localdomain [127.0.0.1]) 	by iscan1.intra.oki.co.jp (8.9.3/8.9.3) with ESMTP id PAA06253; 	Fri, 7 Jul 2006 15:28:07 +0900
Received: from [10.161.35.40] (suzuki611-note.ngo.okisoft.co.jp [10.161.35.40]) 	by s24c53.dm1.oii.oki.co.jp (8.11.6/8.11.2) with ESMTP id k676S7d21422; 	Fri, 7 Jul 2006 15:28:07 +0900
Message-ID: <44ADFF23.2090001@oki.com>
Date: Fri, 07 Jul 2006 06:28:00 -0000
From: SUZUKI Hisao <suzuki611@oki.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060516)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: UTF-8 Cygwin
References: <037101c6a0f5$749bb130$a501a8c0@CAM.ARTIMI.COM> <44ADADD0.8000803@oki.com> <20060707024219.GA8827@trixie.casa.cgf.cx> <44ADDFAC.3020200@oki.com> <20060707052511.GB8827@trixie.casa.cgf.cx>
In-Reply-To: <20060707052511.GB8827@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00017.txt.bz2

Christopher Faylor wrote:
> On Fri, Jul 07, 2006 at 01:14:36PM +0900, SUZUKI Hisao wrote:
>> Christopher Faylor wrote:
>>> I hate to say this but I really don't like doing things this way.  If
>>> we need to use wide character support then it should just be a
>>> wholesale replacement, not a bunch of wrappers around existing
>>> functions.
>>>
>>> Corinna and I have talked about using the FooW functions for a long
>>> time.  There are some fundamental changes required to incorporate these
>>> into cygwin but I don't think that wrappers around everything are the
>>> way to go.
>> I hope you will understand that both approaches (wapper approach and
>> non-wrapper approach) are _compatible_.
>>
>> In Cygwin-1.5.20-1 on Windows XP, fhandler_disk_file::readdir() at
>> winsup/cygwin/fhandler_disk_file.cc does not use FindNextFileA, one of
>> ANSI WIN32 APIs, anymore.  It use so-called undocumented APIs which are
>> Unicode-base.  You have implemented your approach here a little,
>> haven't you?
> 
> Hmm.  Two times in one day where people seem to think that they've made
> a telling point by mentioning that cygwin uses the Nt routines.  What are
> the odds.
> 
> Anyway, I know that you are proud of your patch and I really appreciate
> the amount of work that went into it but I really don't want to do
> things this way.

I'd like to hear the reason, if you please.

> I'm really sorry about this.  If you had asked about your approach prior
> to implementing it, I'm sure that either Corinna or I would have
> expressed our reservations.

I have implemented it because it is _necessary_ for us and for now.

I do not think the other approach is reasonable.  In fact, I had tried
the other approach also, but it had never stared to work.  You will
have to redesign "class path_conv" in winsup/cygwin/path.h more cleanly.
It may be feasible in theory, but it requires a lot of efforts.
And its gain in efficiency will be little...anyway you need conversion
between UTF-8 and Unicode to keep compatibility with POSIX, and path names
are short enough in most cases.

> 
> cgf

-- SUZUKI Hisao
