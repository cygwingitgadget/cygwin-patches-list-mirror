From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: [RFD, PATCH]: Set "hidden" attribute when creating files/dirs/symlinks with trailing dot
Date: Sun, 11 Nov 2001 19:13:00 -0000
Message-ID: <002501c16b28$38f79ca0$0200a8c0@lifelesswks>
References: <20011112014116.B2618@cygbert.vinschen.de> <20011112024721.GB28017@redhat.com>
X-SW-Source: 2001-q4/msg00201.html
Message-ID: <20011111191300.SsPiCHoujJTrQ4u3O_B4CMaNngfsp6n-vCVm4iiROZw@z>

> On Mon, Nov 12, 2001 at 01:41:16AM +0100, Corinna Vinschen wrote:
> >Hi,
> >
> >I thought it would be a good idea to ask for your opinion on that
> >patch first.
> >
> >As you all know, files with a trailing dot are hidden in the output
> >of e.g. `ls' unless you give explicitely the -a option.  That's a
> >good thing IMO (even if some people alias `ls' to `ls -a') since
> >it doesn't show the whole lot of option files when listing the
> >home dir.

Right... ls hides them, but opendir and readdir don't hide them.

> >The Windows explorer since 98/W2K has a global setting called
> >"[Do not] show hidden files and folders" which hides files with
> >FILE_ATTRIBUTE_HIDDEN attribute set, if set.  It's set to
> >"Do not ..." by default as it's for the `ls' command with dot files.

Because MS have this crazy idea that us users actually trust everyone
else in the world to always set the right flags on files. No thanks.
MS's extension hiding, and file hiding defaults are a direct cause for
many of the social engineering security attacks available to virus
writers and the like.

...
> >The below patch adds the appropriate setting of
FILE_ATTRIBUTE_HIDDEN.
> >
> >What's your opinion on such a change?

I don't like it. If I'm browsing the cygwin directory tree via explorer,
I should see everything by default - otherwise _why_ am I browsing that
tree?

Rob
