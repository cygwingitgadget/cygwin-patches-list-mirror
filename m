Return-Path: <cygwin-patches-return-2465-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28689 invoked by alias); 19 Jun 2002 07:18:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28546 invoked from network); 19 Jun 2002 07:18:16 -0000
Date: Wed, 19 Jun 2002 00:18:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Reorganizing internal_getlogin() patch is in
Message-ID: <20020619091814.X30892@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020616051506.GA6188@redhat.com> <20020613052709.GA17779@redhat.com> <20020613052709.GA17779@redhat.com> <3.0.5.32.20020616000701.007f7df0@mail.attbi.com> <20020616051506.GA6188@redhat.com> <3.0.5.32.20020617224247.007faad0@mail.attbi.com> <20020618134102.A23980@cygbert.vinschen.de> <3D0F5CB6.58140BD3@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D0F5CB6.58140BD3@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00448.txt.bz2

Hi Pierre,

On Tue, Jun 18, 2002 at 12:15:50PM -0400, Pierre A. Humblet wrote:
> Could somebody with only a domain account try the following 
> program? It's quick and dirty, you have to type the logonserver
> and user names in the program. Compile with -lnetapi32 .

I know where I can test this but it will take a few hours.
My own machine is not even domain member.

> This would just be curiosity, to see if Windows does any
> caching. In the case of setuid we are looking up another user. 
> Looking up domain accounts on NULL fails. 

Hmmja.  I suspect you're right and it's not worth to keep
the NULL call in the code.  On standalone machines the logon
server is the machine itself and the call is unnecessary, too.

I'm going to test your small testapp as soon as I can.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
