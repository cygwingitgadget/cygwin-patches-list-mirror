From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Tue, 27 Nov 2001 16:21:00 -0000
Message-ID: <20011128002122.GA6919@redhat.com>
References: <20011127230925.GA5830@redhat.com> <000001c1779c$e1fe2fa0$2101a8c0@NOMAD> <20011127235226.GA6537@redhat.com> <1006906033.2048.23.camel@lifelesswks>
X-SW-Source: 2001-q4/msg00267.html
Message-ID: <20011127162100.9vJA_q5DKjdV6TA2xgA-kD9_zgafthliojep7I6zfy0@z>

On Wed, Nov 28, 2001 at 11:07:12AM +1100, Robert Collins wrote:
>On Wed, 2001-11-28 at 10:52, Christopher Faylor wrote:
>> On Tue, Nov 27, 2001 at 05:40:22PM -0600, Gary R Van Sickle wrote:
>> >> On Wed, Nov 28, 2001 at 09:12:20AM +1100, Robert Collins wrote:
>> >> >On Wed, 2001-11-28 at 05:42, Christopher Faylor wrote:
>> >> Regardless, I strenuously disagree with this.  It certainly is not
>> >> deprecated in the Cygwin DLL.
>> >
>> >I'm with Chris on this one, again from a self-documenting standpoint if
>> >nothing else.
>
>Answering both Gary and Chris..
> 
>> Yes, that's my primary motivation.  Basically, it was the way I was
>> taught and the reasons for doing it that way were drilled into my
>> head.
>
>For C I agree completely. In C I am religious about using NULL for
>pointers. 
> 
>> I used to really object to stuff like this, too:
>... 	   ...
>> which is what started this thread.  I used to inform everyone who worked
>> for me not to do this.  Then I had to work on Cygwin where this
>> construction is rampant.  And, I believe that it is even mentioned in
>> the GNU coding standard.
>
>I must revisit that soon :].
> 
>> So, my new internal rule is that the above is ok but foo != 0 is
>> "wrong".
>
>Why? I parse (foo) and if (foo != 0) are the same IFF foo is a simple
>type (which includes pointers to objects). if (foo != NULL) is the same
>as these two IFF foo is a pointer to an object. So NULL is a special
>case, and thats useful in C, with it's relatively weak type checking.
>C++ however has much stronger type checking, so I don't see the value in
>a manual extra check like that. 

Why?  For the reasons that both Gary and I mentioned.  It's self
documenting?

Did you miss the point that I decided on the !foo because I had no
choice?

Do we really have to go down a rat hole for every single #&@#$
discussion?

>> When I test a character, I use c != '\0' and when I test a floating
>> point value, I do f != 0.0.
>
>Which is wrong BTW. To test floating point you want (abs (f) > confidence). 

Are you really so desne as to miss my point?  Apparently so.

cgf
