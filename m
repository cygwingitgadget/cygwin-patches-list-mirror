From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: [egorovv@mailandnews.com: inet_network]
Date: Wed, 19 Apr 2000 21:35:00 -0000
Message-id: <20000420003524.A18106@cygnus.com>
References: <20000419134603.A15867@cygnus.com> <200004191752.NAA03943@envy.delorie.com> <20000419135549.D15867@cygnus.com> <200004191757.NAA03992@envy.delorie.com> <itygkq3z.fsf@mailandnews.com> <20000419194209.C17112@cygnus.com> <uog758k80.fsf@mailandnews.com>
X-SW-Source: 2000-q2/msg00018.html

On Thu, Apr 20, 2000 at 08:33:35AM +0400, Vadim Egorov wrote:
>Chris Faylor <cgf@cygnus.com> writes:
>
>> On Tue, Mar 21, 2000 at 11:47:12PM +0300, Vadim Egorov wrote:
>> >One more way is to borow it -- glibc contains quite compact and independent one -- 
>> >though I'm not quite sure about cygwin policy in this respect. 
>> 
>> We can't borrow from glibc due to license considerations, unfortunately.
>> BSD, on the other hand...
>> 
>> cgf
>> 
>As I found both FreeBSD and glibc contain the same code of inet_network
>(with slightest diffs).

There should be no problem using BSD code.  We use it in other places in Cygwin.

cgf
