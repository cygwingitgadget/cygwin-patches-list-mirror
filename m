From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Tue, 27 Nov 2001 10:42:00 -0000
Message-ID: <20011127184223.GA24028@redhat.com>
References: <3C035977.BF151D0A@syntrex.com> <000601c17772$7c5ecfd0$2101a8c0@d8rc020b>
X-SW-Source: 2001-q4/msg00256.html
Message-ID: <20011127104200.AE6iS8m3RCBYdliyUHJd5jI19h6JBKdOfcRXkvWxlFY@z>

On Tue, Nov 27, 2001 at 12:36:52PM -0600, Gary R Van Sickle wrote:
>> "Gary R. Van Sickle" wrote:
>> >
>> > Ok, setup.exe seems to work much better with this patch
>> applied (also attached):
>>
>> Yep, I'm the one that screwed this up. Here is how it was before
>> my patch was applied.
>>
>>   do {
>>     l = s->gets ();
>>     if (_strnicmp (l, "Content-Length:", 15) == 0)
>>       sscanf (l, "%*s %d", &file_size);
>>   } while (*l);
>>
>>
>> What about replacing this in your patch:
>> > +  while (((l = s->gets ()) != 0) && (strlen(l) != 0))
>> with
>>   +  while (((l = s->gets ()) != 0) && *l)
>>
>
>Ah, better yet.  Jeez you guys are clever ;-).  But how about we make it:
>
>	while (((l = s->gets ()) != 0) && (*l != '\0'))
>
>in the interest of making it a bit more self-documenting?

Actually, how about not using != 0.  Use NULL in this context.

I don't think that *l is hard to understand, fwiw.

cgf
