Return-Path: <cygwin-patches-return-2140-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12756 invoked by alias); 2 May 2002 15:33:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12741 invoked from network); 2 May 2002 15:33:40 -0000
Date: Thu, 02 May 2002 08:33:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Why no shutdown? (was: Re: SSH -R problem)
Message-ID: <20020502173338.B15039@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020430073223.007e3e00@mail.attbi.com> <20020430142039.D1214@cygbert.vinschen.de> <3.0.5.32.20020430215517.007f13e0@mail.attbi.com> <006601c1f0f3$6f7df750$42a18c09@wdg.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006601c1f0f3$6f7df750$42a18c09@wdg.uk.ibm.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00124.txt.bz2

On Wed, May 01, 2002 at 10:34:47AM +0100, Max Bowsher wrote:
> On cygwin-patches@, Pierre A. Humblet wrote:
> > >So an ideal fix would detect "end of life" situations. Here is a brain
> > >storming idea: on a Cygwin close(), do a shutdown(.,2), free the Cygwin
> > Oops, absolutely no shutdown().
> >
> > Pierre
> 
> Why no shutdown?

shutdown() disables the socket, not the socket handle.  The result
is that parent as well as child processes using dup'd sockets are
influenced by that.  close() OTOH just wants to disable only this
very socket handle of the calling process.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
