From: "Trevor Forbes" <trevorforbes@ozemail.com.au>
To: "cygpatch" <cygwin-patches@cygwin.com>
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file  existence
Date: Thu, 08 Mar 2001 12:38:00 -0000
Message-id: <004301c0a80f$764b3530$0200a8c0@voyager>
References: <VA.00000696.0015413c@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00157.html

----- Original Message -----
From: "Brian Keener" <bkeener@thesoftwaresource.com>
To: "Trevor Forbes" <cygwin-patches@cygwin.com>
Sent: Thursday, 8 March 2001 4:57
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file
existence


> Trevor Forbes wrote:
> > >From my own build of setup 2.38, it would not let me select any source
at
> > all.   And when I selected experimental, I was not able to see a package
> > that was visible/available in current.
>
> Which download option did you select:  Download, Install from Internet or
> Install from local directory.  The modifications I made will cause the
choose
> screen to only show packages for which the Prev,Curr, and Test buttons
apply
> (ie the package has that particular version available) and then also their
> display is based on whether you have selected full/part.  I package might
show
> with partial selected in current because it has a current version but will
not
> show under test because it does not have a test version.  But if you
select
> Full all packages should show but the options you can click (ie Keep,
> uninstall, install a version ) will vary depending if you have prev,
current,
> test selected.

Firstly, I always Download then install from local directory. I was talking
about downloading.

Next, ..Ok, I missed the change in the way current, test work now.  I just
got used to going straight to experimental and expecting the available
current packages to be present also.

But I still cannot select any source packages, -- that neat little X will
not present itself in the source select box.

Also, install from local directory still does not work, its been broken for
some time now.

However, if no one else is having any problems with building a working
setup, then something might be broken with my setup :[  (I am still not
confident in my build script/setup yet)

Regards Trevor



