Return-Path: <cygwin-patches-return-5330-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10216 invoked by alias); 7 Feb 2005 06:12:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10029 invoked from network); 7 Feb 2005 06:12:09 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 7 Feb 2005 06:12:09 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 219001B52C; Mon,  7 Feb 2005 01:13:13 -0500 (EST)
Date: Mon, 07 Feb 2005 06:12:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: gethostbyname() problem?
Message-ID: <20050207061313.GA7852@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <200502051240.j15CevQ32345@webmail.web-mania.com> <4205D6D1.70D38D40@dessent.net> <20050206110530.GR19096@cygbert.vinschen.de> <20050206230129.GA3512@efn.org> <20050206234458.GA2425@trixie.casa.cgf.cx> <20050207055347.GA2248@efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207055347.GA2248@efn.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2005-q1/txt/msg00033.txt.bz2

On Sun, Feb 06, 2005 at 09:53:48PM -0800, Yitzchak Scott-Thoennes wrote:
>On Sun, Feb 06, 2005 at 06:44:58PM -0500, Christopher Faylor wrote:
>> On Sun, Feb 06, 2005 at 03:01:29PM -0800, Yitzchak Scott-Thoennes wrote:
>> >On Sun, Feb 06, 2005 at 12:05:30PM +0100, Corinna Vinschen wrote:
>> >> On Feb  6 00:35, Brian Dessent wrote:
>> >> > -  static int a, b, c, d;
>> >> > +  static int a, b, c, d, n;
>> >> >  
>> >> >    sig_dispatch_pending ();
>> >> >    if (check_null_str_errno (name))
>> >> >      return NULL;
>> >> >  
>> >> > -  if (sscanf (name, "%d.%d.%d.%d", &a, &b, &c, &d) == 4)
>> >> > +  if (sscanf (name, "%d.%d.%d.%d%n", &a, &b, &c, &d, &n) == 4 && (unsigned)n == strlen (name))
>> >>
>> >> Thanks for the patch, Brian.  Do you also have a nice ChangeLog entry
>> >> for me?
>> >
>> >I've always done this like below; then the n==strlen(name) check isn't
>> >needed (since the ==4 verifies that %c wasn't used).  Even using the
>> >%n, there's no reason to make n static, is there?
>> 
>> There has been no reason to make a, b, c, d static either AFAICT.
>> This whole function is frightfully non-reentrant, but I knew that.
>
>Better?

Yes, I think it is much better.  I know that this doesn't have to be
non-reentrant but it should be thread safe, IMO.

>Reentrancy isn't actually required, but no reason not to do it.  I have
>compiled net.cc but not done any other testing.  Did I mention that
>dup_ent is really neat?

Thank you.  That solved a few problems when I implemented it.

You'd think it would have occurred to me that you could use it in this
context.

This is fine with me, if it is ok with Corinna.

Thanks for the patch!

cgf


>2005-02-06  Yitzchak Scott-Thoennes <sthoenna@efn.org>
>
>	* net.cc (cygwin_gethostbyname): Be more picky about what's
>	a numeric address string, and use tls in that case too.
>
>--- winsup/cygwin/net.cc.orig	2004-04-11 10:41:17.000000000 -0700
>+++ winsup/cygwin/net.cc	2005-02-06 21:41:46.811609600 -0800
>@@ -992,17 +992,19 @@ cygwin_gethostname (char *name, size_t l
> extern "C" struct hostent *
> cygwin_gethostbyname (const char *name)
> {
>-  static unsigned char tmp_addr[4];
>-  static struct hostent tmp;
>-  static char *tmp_aliases[1];
>-  static char *tmp_addr_list[2];
>-  static int a, b, c, d;
>+  unsigned char tmp_addr[4];
>+  struct hostent tmp, *h;
>+  char *tmp_aliases[1] = {0};
>+  char *tmp_addr_list[2] = {0,0};
>+  unsigned int a, b, c, d;
>+  char dummy;
> 
>   sig_dispatch_pending ();
>   if (check_null_str_errno (name))
>     return NULL;
> 
>-  if (sscanf (name, "%d.%d.%d.%d", &a, &b, &c, &d) == 4)
>+  if (sscanf (name, "%u.%u.%u.%u%c", &a, &b, &c, &d, &dummy) == 4
>+      && a < 256 && b < 256 && c < 256 && d < 256)
>     {
>       /* In case you don't have DNS, at least x.x.x.x still works */
>       memset (&tmp, 0, sizeof (tmp));
>@@ -1016,11 +1018,13 @@ cygwin_gethostbyname (const char *name)
>       tmp.h_addrtype = 2;
>       tmp.h_length = 4;
>       tmp.h_addr_list = tmp_addr_list;
>-      return &tmp;
>+      h = &tmp;
>     }
>+  else
>+    h = gethostbyname (name);
>+
>+  _my_tls.locals.hostent_buf = (hostent *) dup_ent (_my_tls.locals.hostent_buf, h, is_hostent);
> 
>-  _my_tls.locals.hostent_buf = (hostent *) dup_ent (_my_tls.locals.hostent_buf, gethostbyname (name),
>-				     is_hostent);
>   if (!_my_tls.locals.hostent_buf)
>     {
>       set_winsock_errno ();
