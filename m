Return-Path: <cygwin-patches-return-3225-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1633 invoked by alias); 24 Nov 2002 16:12:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1588 invoked from network); 24 Nov 2002 16:12:43 -0000
Date: Sun, 24 Nov 2002 08:12:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: More passwd/group patches
Message-ID: <20021124171242.C1398@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DDE4528.3BDCDCEF@ieee.org> <3DDE3FB9.2AFAA199@ieee.org> <20021122154644.N1398@cygbert.vinschen.de> <3DDE4528.3BDCDCEF@ieee.org> <3.0.5.32.20021124092120.00829650@mail.attbi.com> <20021124170805.B1398@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021124170805.B1398@cygbert.vinschen.de>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00176.txt.bz2

On Sun, Nov 24, 2002 at 05:08:05PM +0100, Corinna Vinschen wrote:
> - ...except for in the CLASS_OBJ entry.  The default setting on that
>   machine for all my files is 0x1ff and, frankly, I have no idea
>   how to explain that setting.  Interesting enough, the Solaris
>   getfacl as well as my getfacl both return 'rwx' as permission bits
>   for that entry.

Sorry, I forgot to discuss this point.  Since I don't know how to
explain that setting... should we just set CLASS_OBJ to 0x1ff, too?
It matches Solaris plus it's correctly(?) printed as rwx.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
