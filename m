From: DJ Delorie <dj@delorie.com>
To: juliano@cs.unc.edu
Cc: cygwin-patches@sources.redhat.com
Subject: Re: cinstall contribution
Date: Mon, 17 Jul 2000 13:00:00 -0000
Message-id: <200007172000.QAA03205@envy.delorie.com>
References: <Pine.SGI.4.10.10007111450500.361924-100000@cystine.cs.unc.edu> <396B7FC4.188536DC@delorie.com> <200007112129.RAA03821@envy.delorie.com> <396F377E.F3ADDEF6@cs.unc.edu> <200007141712.NAA14485@envy.delorie.com> <396F9057.83997899@cs.unc.edu> <200007142222.SAA16834@envy.delorie.com> <39735BDE.ECBF7C9A@cs.unc.edu>
X-SW-Source: 2000-q3/msg00018.html

Applied.  Thanks!  I did make some minor changes, though...

I changed my mind about site.h.  That function isn't really a public
API, so instead of adding site.h I just added a prototype in other.cc.

I added a few spaces before parens to meet GNU coding styles (yes,
I have to now go fix all of *my* similar mistakes).

I did add the concat fix.

I changed save_URL() to save_site_url().

I scan for both \r and \n when reading the saved url.

Keep up the good work!

DJ
