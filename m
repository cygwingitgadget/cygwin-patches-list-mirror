From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: [PATCH]: Check modification time on /etc/passwd and /etc/group
Date: Mon, 06 Aug 2001 06:28:00 -0000
Message-id: <20010806152800.B23782@cygbert.vinschen.de>
References: <20010803144012.X23782@cygbert.vinschen.de> <996843821.24208.3.camel@lifelesswks> <20010803151518.Y23782@cygbert.vinschen.de> <996845317.24251.9.camel@lifelesswks> <20010804215935.N23782@cygbert.vinschen.de> <20010804172101.B4457@redhat.com> <20010805111251.R23782@cygbert.vinschen.de> <20010805122954.B13202@redhat.com> <20010805195959.A27538@cygbert.vinschen.de> <3B6EA230.412E6B18@yahoo.com>
X-SW-Source: 2001-q3/msg00062.html

On Mon, Aug 06, 2001 at 07:57:04AM -0600, Earnie Boyd wrote:
> Corinna Vinschen wrote:
> > 
> > On Sun, Aug 05, 2001 at 12:29:54PM -0400, Christopher Faylor wrote:
> > > So, is it worthwhile to make this change?  We might be adding some overhead
> > > for an infrequent case.
> > 
> > Hmm, that's a good question. I would like to see that handled
> > correctly w/o having to stop and start my services again. And
> > it's actually no infrequent case for sysadmins to add users.
> > 
> 
> Robert Collins had some interesting questions on this subject in this
> http://www.cygwin.com/ml/cygwin-developers/2001-04/msg00071.html post.
> 
> And http://www.sxlist.com/techref/os/win/api/win32/func/src/f24_9.htm is
> Win32 API documentation for FindFirstChangeNotification.

Yep, I know that function but I wasn't too keen to start
another thread per process just to get a notification.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
