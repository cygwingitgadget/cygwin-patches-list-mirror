From: Egor Duda <deo@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: signal semaphores inheritance
Date: Wed, 21 Feb 2001 03:43:00 -0000
Message-id: <286043253.20010221144030@logos-m.ru>
References: <1616663500.20010220192409@logos-m.ru> <20010220184706.C908@cygbert.vinschen.de> <13772066496.20010221104733@logos-m.ru> <20010221090813.L908@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00100.html

Hi!

Wednesday, 21 February, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:

>> >>   if  ntsec is on and cygwin app a.exe  (with pid x) starts non-cygwin
>> >> app  b.exe,  b.exe  inherits  cygwin1S3.sigcatch.x semaphore. if a.exe
>> >> dies  and  b.exe continue  execution,  and  if  new  cygwin  app c.exe
>> >> got  pid  x it, fails to create sigcatch semaphore. looks like typo in
>> >> getsem() to me. is this patch ok?
>> 
>> CV> Did you check it with apps chenging the user context? AFAIR I had
>> CV> a reason using an inheritable SD...
>> 
>> hmm.  i  haven't noticed any differences. i may have missed something,
>> though.  but,  if this handle is supposed to be inheritable, shouldn't
>> it  be  DuplicateHandle()'d  in  child  process?  I've grepped through
>> sources  and haven't find any DuplicateHandle() used on semaphores. so
>> even   if   this   handle  is  made inheritable, i don't see the place
>> where child is using it.

CV> Please don't misunderstand me. I'm asking that question because I'm
CV> really unsure why this is an inheritable SD and I only remember (in
CV> the deepest corner of my brain) that there might have been _some_ issue
CV> to do it that way but my alzheimer disease is getting worse...

CV> If you have tested the patch with using telnet or ssh to actually
CV> change the user context and an `id' results in the correct identity
CV> and the permissions seem to be ok then I have no problem with your patch.

i've    tested   it in several simple scenarios, and it seems to work.
user  context is changed, id shows correct info, and i can send SIGINT
to process run under sshd via pressing Ctrl-C.

i've checked this patch in.

of   course,  i'm  sure i haven't tested all those obscure cases which
can   appear  in  cygwin  signal processing. If anyone find such case,
and  it  turns  out  that  sigcatch  semaphore  should  persist  after
it's    creator    dies,   i   think    we'll    need    to   change
cygwin1S3.sigcatch.PID semaphore name to something more unique.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

