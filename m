From: "Town, Brad" <btown@ceddec.com>
To: "'cygwin-patches@sources.redhat.com'" <cygwin-patches@sources.redhat.com>
Subject: RE: 'clear' does not clear entire screen (affects vim also)
Date: Thu, 16 Nov 2000 13:06:00 -0000
Message-id: <F10D23B02E54D011A0AB0020AF9CEFE988FA0F@lynx.ceddec.com>
X-SW-Source: 2000-q4/msg00016.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65437-16"

This is a multi-part message in MIME format...

------------=_1583532846-65437-16
Content-length: 1108

(This was sent to the cygwin-patches list rather than the cygwin list.)

The ChangeLog entry is attached.  Is there a better way to do this sort of
thing?  For example, should I send a ChangeLog entry along with proposed
patches?  Should I send proposed patches to cygwin-patches instead?

BTW, the copyright assignment form is almost ready -- I'm waiting to get the
employer part back.  Perhaps I'll send the first two parts now and the third
part when I get it.

Brad Town


> -----Original Message-----
> From: Chris Faylor [ mailto:cgf@redhat.com ]
> Sent: Thursday, November 16, 2000 3:51 PM
> To: 'cygwin@cygwin.com'
> Subject: Re: 'clear' does not clear entire screen (affects vim also)
> 
> 
> On Tue, Nov 14, 2000 at 09:52:09AM -0500, Town, Brad wrote:
> >Attached is a minor patch that uses the screen buffer width 
> rather than the
> >window width to calculate the number of spaces to clear.
> 
> The patch looks reasonable.  Could I have a ChangeLog entry 
> for it, please?
> 
> cgf
> 
> --
> Want to unsubscribe from this list?
> Send a message to cygwin-unsubscribe@sourceware.cygnus.com
> 


------------=_1583532846-65437-16
Content-Type: text/plain; charset=us-ascii; name="ChangeLog.mine"
Content-Disposition: inline; filename="ChangeLog.mine"
Content-Transfer-Encoding: base64
Content-Length: 391

VGh1IE5vdiAxNiAxNTo1OTo1OCAyMDAwIEJyYWRsZXkgQS4gVG93biA8dG93
bmJhQHBvYm94LmNvbT4KCgkqIGZoYW5kbGVyX2NvbnNvbGUuY2M6IE5ldyBt
ZW1iZXIgdmFyaWFibGUgYGR3QnVmZmVyU2l6ZScgZm9yIGBpbmZvJy4KCShm
aWxsaW5faW5mbyk6IFNldCBgZHdCdWZmZXJTaXplJyB0byB0aGUgc2l6ZSBv
ZiB0aGUgY29uc29sZSBidWZmZXIuCgkoY2xlYXJfc2NyZWVuKTogVXNlIHdp
ZHRoIG9mIGNvbnNvbGUgYnVmZmVyIHRvIGNhbGN1bGF0ZSBob3cgbWFueQoJ
c3BhY2VzIHRvIGNsZWFyLgo=

------------=_1583532846-65437-16--
