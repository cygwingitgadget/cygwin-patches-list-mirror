From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: [egorovv@mailandnews.com: inet_network]
Date: Thu, 20 Apr 2000 22:27:00 -0000
Message-id: <20000421012740.A6796@cygnus.com>
References: <20000419134603.A15867@cygnus.com> <200004191752.NAA03943@envy.delorie.com> <20000419135549.D15867@cygnus.com> <200004191757.NAA03992@envy.delorie.com> <itygkq3z.fsf@mailandnews.com> <20000419194209.C17112@cygnus.com> <uog758k80.fsf@mailandnews.com> <200004201315.JAA29367@envy.delorie.com> <20000420154647.D1862@cygnus.com> <u66tcjaa1.fsf@mailandnews.com>
X-SW-Source: 2000-q2/msg00025.html

On Fri, Apr 21, 2000 at 09:25:10AM +0400, Vadim Egorov wrote:
>Chris Faylor <cgf@cygnus.com> writes:
>
>> On Thu, Apr 20, 2000 at 09:15:08AM -0400, DJ Delorie wrote:
>> >Note that BSD code should no longer have the advertising clause in it.
>> 
>> Yup.
>
>This copyright stuff is really tough.
>
>Here is an another inet_network patch containing BSD implementation.
>I have only changed u_long to unsigned int. Copyright notice is left
>unchanged and same as it is in other BSD files in cygwin.
>
>Personally I don't see much difference between this solution and previous
>one - undocumented winsock func - I won't be surprised if they use the same 
>source.

No, no.  Sorry for the miscommunication.  If you found the inet_network in
all of the winsock DLLs, then let's just use that.  Your previous patch
should be fine.

DJ, could you apply it.

cgf
