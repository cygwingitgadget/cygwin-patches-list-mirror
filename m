From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Check modification time on /etc/passwd and /etc/group
Date: Sun, 05 Aug 2001 11:00:00 -0000
Message-id: <20010805195959.A27538@cygbert.vinschen.de>
References: <20010731203820.U490@cygbert.vinschen.de> <20010803144012.X23782@cygbert.vinschen.de> <996843821.24208.3.camel@lifelesswks> <20010803151518.Y23782@cygbert.vinschen.de> <996845317.24251.9.camel@lifelesswks> <20010804215935.N23782@cygbert.vinschen.de> <20010804172101.B4457@redhat.com> <20010805111251.R23782@cygbert.vinschen.de> <20010805122954.B13202@redhat.com>
X-SW-Source: 2001-q3/msg00056.html

On Sun, Aug 05, 2001 at 12:29:54PM -0400, Christopher Faylor wrote:
> So, is it worthwhile to make this change?  We might be adding some overhead
> for an infrequent case.

Hmm, that's a good question. I would like to see that handled
correctly w/o having to stop and start my services again. And
it's actually no infrequent case for sysadmins to add users.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
