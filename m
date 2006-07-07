Return-Path: <cygwin-patches-return-5920-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10705 invoked by alias); 7 Jul 2006 04:13:58 -0000
Received: (qmail 10695 invoked by uid 22791); 7 Jul 2006 04:13:57 -0000
X-Spam-Check-By: sourceware.org
Received: from okigate.oki.co.jp (HELO iscan1.intra.oki.co.jp) (202.226.91.194)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Jul 2006 04:13:56 +0000
Received: from s24c53.dm1.oii.oki.co.jp (IDENT:root@localhost.localdomain [127.0.0.1]) 	by iscan1.intra.oki.co.jp (8.9.3/8.9.3) with ESMTP id NAA29452; 	Fri, 7 Jul 2006 13:13:53 +0900
Received: from [10.161.35.40] (suzuki611-note.ngo.okisoft.co.jp [10.161.35.40]) 	by s24c53.dm1.oii.oki.co.jp (8.11.6/8.11.2) with ESMTP id k674Drd03972; 	Fri, 7 Jul 2006 13:13:53 +0900
Message-ID: <44ADDFAC.3020200@oki.com>
Date: Fri, 07 Jul 2006 04:13:00 -0000
From: SUZUKI Hisao <suzuki611@oki.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060516)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: UTF-8 Cygwin
References: <037101c6a0f5$749bb130$a501a8c0@CAM.ARTIMI.COM> <44ADADD0.8000803@oki.com> <20060707024219.GA8827@trixie.casa.cgf.cx>
In-Reply-To: <20060707024219.GA8827@trixie.casa.cgf.cx>
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
X-SW-Source: 2006-q3/txt/msg00015.txt.bz2

Christopher Faylor wrote:
> 
> I hate to say this but I really don't like doing things this way.  If we
> need to use wide character support then it should just be a wholesale
> replacement, not a bunch of wrappers around existing functions.
> 
> Corinna and I have talked about using the FooW functions for a long time.
> There are some fundamental changes required to incorporate these into
> cygwin but I don't think that wrappers around everything are the way to
> go.
> 
> cgf

I hope you will understand that both approaches (wapper approach and
non-wrapper approach) are _compatible_.

In Cygwin-1.5.20-1 on Windows XP,
fhandler_disk_file::readdir() at winsup/cygwin/fhandler_disk_file.cc
does not use FindNextFileA, one of ANSI WIN32 APIs, anymore.  It use
so-called undocumented APIs which are Unicode-base.  You have
implemented your approach here a little, haven't you?

And the UTF-8 Cygwin still works very well ;-)

Wrapper functions do _nothing_ where wide characters are used.
It is sys_wcstombs that converts Unicode to UTF-8 here.

The cygwin programs can enjoy UTF-8 _now_ with the UTF-8 patch,
and someday in the future when UTF-8 is supported natively,
you can delete wrapper functions which are not used anymore then.

-- SUZUKI Hisao
