Return-Path: <cygwin-patches-return-2126-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28631 invoked by alias); 30 Apr 2002 12:20:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28599 invoked from network); 30 Apr 2002 12:20:41 -0000
Date: Tue, 30 Apr 2002 05:20:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: SSH -R problem
Message-ID: <20020430142039.D1214@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020430073223.007e3e00@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020430073223.007e3e00@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00110.txt.bz2

On Tue, Apr 30, 2002 at 07:32:23AM -0400, Pierre A. Humblet wrote:
> At 10:32 AM 4/30/2002 +0200, Corinna Vinschen wrote:
> >> Of course we are then exposed to the issue that Cygwin was trying
> >> to fix by setting linger to On, i.e. the case of a process 
> >> exiting just after the close(). Fortunately sockets are usually 
> >
> >...why cant we keep that, i. e.
> >
> >   If the socket is non blocking
> >     then make it blocking
> >    set linger to On, as done currently
> 
> because in the case of a server handling many connections at once
> (ssh or sshd, among others) you don't want to block the whole operation 
> when closing one socket.

That makes sense... but doesn't that again break something else?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
