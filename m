From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: signal semaphores inheritance
Date: Tue, 20 Feb 2001 09:47:00 -0000
Message-id: <20010220184706.C908@cygbert.vinschen.de>
References: <1616663500.20010220192409@logos-m.ru>
X-SW-Source: 2001-q1/msg00093.html

On Tue, Feb 20, 2001 at 07:24:09PM +0300, Egor Duda wrote:
> Hi!
> 
>   if  ntsec is on and cygwin app a.exe  (with pid x) starts non-cygwin
> app  b.exe,  b.exe  inherits  cygwin1S3.sigcatch.x semaphore. if a.exe
> dies  and  b.exe continue  execution,  and  if  new  cygwin  app c.exe
> got  pid  x it, fails to create sigcatch semaphore. looks like typo in
> getsem() to me. is this patch ok?

Did you check it with apps chenging the user context? AFAIR I had
a reason using an inheritable SD...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
