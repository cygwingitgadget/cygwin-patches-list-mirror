Return-Path: <cygwin-patches-return-3227-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30049 invoked by alias); 24 Nov 2002 16:47:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30040 invoked from network); 24 Nov 2002 16:47:10 -0000
Date: Sun, 24 Nov 2002 08:47:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: More passwd/group patches
Message-ID: <20021124174709.E1398@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20021124092120.00829650@mail.attbi.com> <3DDE4528.3BDCDCEF@ieee.org> <3DDE3FB9.2AFAA199@ieee.org> <20021122154644.N1398@cygbert.vinschen.de> <3DDE4528.3BDCDCEF@ieee.org> <3.0.5.32.20021124092120.00829650@mail.attbi.com> <3.0.5.32.20021124112817.008279b0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021124112817.008279b0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00178.txt.bz2

On Sun, Nov 24, 2002 at 11:28:17AM -0500, Pierre A. Humblet wrote:
> At 05:08 PM 11/24/2002 +0100, Corinna Vinschen wrote:
> >The appropriate changes to sec_acl.cc would collide with your patch
> >so I'd like to ask you if you want me to make the necessary changes
> >to comply with Solaris first and then to send a revised patch, or
> >if you want to incorporate these changes into your patch, too?
> 
> Corinna,
> 
> Between the two proposals I prefer the first (you make the change first).
> The don't like the second much, because there is a possibility of 
> misunderstanding.
> There is also a third possibility: apply the patch and then fix it to
> match solaris. That may minimize the overall amount of work and 
> reviewing.

Ok, I'm going to apply your patch and then rework it as I think fit.

> I have been working on the home directory problem but can't reproduce 
> it. 
> I don't see anything wrong with his passwd file. Do you?

There isn't.  It looks like the files created by mkpasswd/mkgroup.

I'm pretty sure it's related to setting myself->gid to the new
DEFAULT_GID 401 in internal_getlogin.  It's perhaps a problem of the
execution order.  However, I didn't look into the code so far since
I'm busy with the sec_acl stuff.

Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
