From: Egor Duda <deo@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: signal semaphores inheritance
Date: Tue, 20 Feb 2001 23:49:00 -0000
Message-id: <13772066496.20010221104733@logos-m.ru>
References: <1616663500.20010220192409@logos-m.ru> <20010220184706.C908@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00098.html

Hi!

Tuesday, 20 February, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:

CV> On Tue, Feb 20, 2001 at 07:24:09PM +0300, Egor Duda wrote:
>> Hi!
>> 
>>   if  ntsec is on and cygwin app a.exe  (with pid x) starts non-cygwin
>> app  b.exe,  b.exe  inherits  cygwin1S3.sigcatch.x semaphore. if a.exe
>> dies  and  b.exe continue  execution,  and  if  new  cygwin  app c.exe
>> got  pid  x it, fails to create sigcatch semaphore. looks like typo in
>> getsem() to me. is this patch ok?

CV> Did you check it with apps chenging the user context? AFAIR I had
CV> a reason using an inheritable SD...

hmm.  i  haven't noticed any differences. i may have missed something,
though.  but,  if this handle is supposed to be inheritable, shouldn't
it  be  DuplicateHandle()'d  in  child  process?  I've grepped through
sources  and haven't find any DuplicateHandle() used on semaphores. so
even   if   this   handle  is  made inheritable, i don't see the place
where child is using it.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

