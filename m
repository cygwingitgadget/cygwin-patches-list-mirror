From: Christopher Faylor <cgf@redhat.com>
To: cygpat <cygwin-patches@cygwin.com>, cygwin-xfree@cygwin.com
Subject: Re: [PATCH] Re: pthread -- Corinna?
Date: Tue, 17 Apr 2001 07:15:00 -0000
Message-id: <20010417101609.A13312@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF79C0@itdomain002.itdomain.net.au> <20010417005137.A26463@redhat.com> <20010417122126.A12559@cygbert.vinschen.de> <009d01c0c729$68fe0b80$0200a8c0@lifelesswks> <20010417140502.F12559@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00099.html

On Tue, Apr 17, 2001 at 02:05:02PM +0200, Corinna Vinschen wrote:
>On Tue, Apr 17, 2001 at 08:30:11PM +1000, Robert Collins wrote:
>> From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
>> >   So, the better way is probably to drop both ..._sem variables and
>> >   just switch off allow_ntsec in read_etc_...() before opening a
>> >   file and restoring the setting afterwards.
>> >
>> >   If that's done inside of the above mentioned mutex or critical
>> section
>> >   protected area in read_etc_...(), it's protected against changings
>> by
>> >   simultaneous threads, too.
>> 
>> is allow_ntsec thread-specific or process-specific or system specific?
>
>It's process-specific. Hmmja, I didn't reflect about that. Sorry.
>My first idea (which I didn't write about) was probably better:
>
>When I changed the code in passwd.cc and grp.cc once, I was annoyed
>about the usage of fopen in these internal functions. However, I
>didn't change it due to the usage of fgets(). I'm pretty sure
>it would be better to use CreateFile/ReadFile/CloseHandle in
>read_etc_...() than high-level libc functions. This would drop the
>need for the ..._sem variables once and for all. No open(), no
>ntsec, no recursion. It only would have to care for line endings
>by itself.

Ok.  I'm going to check in my changes.  I was mulling over the idea
of not using fopen/fread but it didn't seem like prospect of doing all
of the buffer/line management was really worth it.

I don't particularly like the idea of using the f* family either but
I think that duplicating the functionality of open/read for this
situation isn't really worth it.

cgf
