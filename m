From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: readlink() patch
Date: Tue, 05 Sep 2000 14:51:00 -0000
Message-id: <20000905175103.E4362@cygnus.com>
References: <119170270886.20000903213328@logos-m.ru> <20000903200337.A22931@cygnus.com> <33215577994.20000904100834@logos-m.ru> <200009051610.MAA14632@envy.delorie.com>
X-SW-Source: 2000-q3/msg00065.html

On Tue, Sep 05, 2000 at 12:10:12PM -0400, DJ Delorie wrote:
>Has anyone actually *tried* readlink() on linux?  I did.

Yes, I checked it on linux but apparently I didn't check it on
cygwin after the patch.

The problem was that Egor used a 'max()' rather than a 'min()' in
his patch.  I changed that.

cgf
