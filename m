From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Tue, 27 Nov 2001 15:52:00 -0000
Message-ID: <20011127235226.GA6537@redhat.com>
References: <20011127230925.GA5830@redhat.com> <000001c1779c$e1fe2fa0$2101a8c0@NOMAD>
X-SW-Source: 2001-q4/msg00263.html
Message-ID: <20011127155200.B3UoATPTKoUxFT6p84zqK1tWdL3SD0IFJLM1uncdPCA@z>

On Tue, Nov 27, 2001 at 05:40:22PM -0600, Gary R Van Sickle wrote:
>> On Wed, Nov 28, 2001 at 09:12:20AM +1100, Robert Collins wrote:
>> >On Wed, 2001-11-28 at 05:42, Christopher Faylor wrote:
>> Regardless, I strenuously disagree with this.  It certainly is not
>> deprecated in the Cygwin DLL.
>
>I'm with Chris on this one, again from a self-documenting standpoint if
>nothing else.

Yes, that's my primary motivation.  Basically, it was the way I was
taught and the reasons for doing it that way were drilled into my
head.

I used to really object to stuff like this, too:

	char *foo;
	.
	.
	.
	if (!foo)
	   ...

which is what started this thread.  I used to inform everyone who worked
for me not to do this.  Then I had to work on Cygwin where this
construction is rampant.  And, I believe that it is even mentioned in
the GNU coding standard.

So, my new internal rule is that the above is ok but foo != 0 is
"wrong".

When I test a character, I use c != '\0' and when I test a floating
point value, I do f != 0.0.

Btw, is google actually faster if someone else has just done the same
search?  :-)

cgf
