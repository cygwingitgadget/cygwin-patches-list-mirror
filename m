Return-Path: <cygwin-patches-return-5327-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17233 invoked by alias); 6 Feb 2005 23:01:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17223 invoked from network); 6 Feb 2005 23:01:28 -0000
Received: from unknown (HELO pop-a065d01.pas.sa.earthlink.net) (207.217.121.248)
  by sourceware.org with SMTP; 6 Feb 2005 23:01:28 -0000
Received: from user-2inif7b.dialup.mindspring.com ([165.121.60.235] helo=efn.org)
	by pop-a065d01.pas.sa.earthlink.net with smtp (Exim 3.33 #1)
	id 1CxvPC-0004hS-00
	for cygwin-patches@cygwin.com; Sun, 06 Feb 2005 15:01:27 -0800
Received: by efn.org (sSMTP sendmail emulation); Sun, 6 Feb 2005 15:01:30 -0800
Date: Sun, 06 Feb 2005 23:01:00 -0000
From: Yitzchak Scott-Thoennes <sthoenna@efn.org>
To: cygwin-patches@cygwin.com
Subject: Re: gethostbyname() problem?
Message-ID: <20050206230129.GA3512@efn.org>
References: <200502051240.j15CevQ32345@webmail.web-mania.com> <4205D6D1.70D38D40@dessent.net> <20050206110530.GR19096@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206110530.GR19096@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
Organization: bs"d
X-SW-Source: 2005-q1/txt/msg00030.txt.bz2

On Sun, Feb 06, 2005 at 12:05:30PM +0100, Corinna Vinschen wrote:
> On Feb  6 00:35, Brian Dessent wrote:
> > -  static int a, b, c, d;
> > +  static int a, b, c, d, n;
> >  
> >    sig_dispatch_pending ();
> >    if (check_null_str_errno (name))
> >      return NULL;
> >  
> > -  if (sscanf (name, "%d.%d.%d.%d", &a, &b, &c, &d) == 4)
> > +  if (sscanf (name, "%d.%d.%d.%d%n", &a, &b, &c, &d, &n) == 4 && (unsigned)n == strlen (name))
>
> Thanks for the patch, Brian.  Do you also have a nice ChangeLog entry
> for me?

I've always done this like below; then the n==strlen(name) check isn't
needed (since the ==4 verifies that %c wasn't used).  Even using the
%n, there's no reason to make n static, is there?


2005-02-06  Yitzchak Scott-Thoennes <sthoenna@efn.org>

	* net.cc (cygwin_gethostbyname): Treat as hostname even if
	beginning with "%d.%d.%d.%d"

--- winsup/cygwin/net.cc.orig	2004-04-11 10:41:17.000000000 -0700
+++ winsup/cygwin/net.cc	2005-02-06 13:49:42.783942400 -0800
@@ -997,12 +997,13 @@ cygwin_gethostbyname (const char *name)
   static char *tmp_aliases[1];
   static char *tmp_addr_list[2];
   static int a, b, c, d;
+  char dummy;
 
   sig_dispatch_pending ();
   if (check_null_str_errno (name))
     return NULL;
 
-  if (sscanf (name, "%d.%d.%d.%d", &a, &b, &c, &d) == 4)
+  if (sscanf (name, "%d.%d.%d.%d%c", &a, &b, &c, &d, &dummy) == 4)
     {
       /* In case you don't have DNS, at least x.x.x.x still works */
       memset (&tmp, 0, sizeof (tmp));
