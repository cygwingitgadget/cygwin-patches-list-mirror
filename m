Return-Path: <cygwin-patches-return-3233-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22041 invoked by alias); 25 Nov 2002 11:25:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22031 invoked from network); 25 Nov 2002 11:25:15 -0000
Date: Mon, 25 Nov 2002 03:25:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: More passwd/group patches
Message-ID: <20021125122512.L1398@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20021124112817.008279b0@mail.attbi.com> <3.0.5.32.20021124092120.00829650@mail.attbi.com> <3DDE4528.3BDCDCEF@ieee.org> <3DDE3FB9.2AFAA199@ieee.org> <20021122154644.N1398@cygbert.vinschen.de> <3DDE4528.3BDCDCEF@ieee.org> <3.0.5.32.20021124092120.00829650@mail.attbi.com> <3.0.5.32.20021124112817.008279b0@mail.attbi.com> <3.0.5.32.20021124161104.00825ab0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021124161104.00825ab0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00184.txt.bz2

On Sun, Nov 24, 2002 at 04:11:04PM -0500, Pierre A. Humblet wrote:
> There is another strange thing in there that I should have mentioned:
> we are returning success even if the user gives us an ACLU that's 
> tohasmall. Is that how Sun does it? 

Just checked.  No, Solaris returns ENOSPC.  I've fixed that in sec_acl.cc.
Thanks for the hint.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
