From: DJ Delorie <dj@delorie.com>
To: bkeener@thesoftwaresource.com
Cc: cygwin-patches@cygwin.com
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file  existence
Date: Tue, 06 Mar 2001 15:01:00 -0000
Message-id: <200103062301.SAA16798@envy.delorie.com>
References: <VA.0000068e.017d3abe@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00154.html

The full/part idea is that "part" mode only shows the entries for
things that either will or should change, but things that won't change
(either at all or by default) show up only in "full" mode.  The idea
is to not bother the majority of the users with things they didn't
need to know.

Setup has (had?) no option to forcibly re-install or re-download a
package.  It's probably OK to add such a feature, but it shouldn't be
needed and the user can always just delete the local copy (or install
record) and get the same effect.

I didn't add the option to download sources independent of binaries
because it was harder than I had time for.
