Return-Path: <cygwin-patches-return-5328-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24698 invoked by alias); 6 Feb 2005 23:44:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24662 invoked from network); 6 Feb 2005 23:43:55 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 6 Feb 2005 23:43:55 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 440281B52C; Sun,  6 Feb 2005 18:44:58 -0500 (EST)
Date: Sun, 06 Feb 2005 23:44:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: gethostbyname() problem?
Message-ID: <20050206234458.GA2425@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <200502051240.j15CevQ32345@webmail.web-mania.com> <4205D6D1.70D38D40@dessent.net> <20050206110530.GR19096@cygbert.vinschen.de> <20050206230129.GA3512@efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206230129.GA3512@efn.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2005-q1/txt/msg00031.txt.bz2

On Sun, Feb 06, 2005 at 03:01:29PM -0800, Yitzchak Scott-Thoennes wrote:
>On Sun, Feb 06, 2005 at 12:05:30PM +0100, Corinna Vinschen wrote:
>> On Feb  6 00:35, Brian Dessent wrote:
>> > -  static int a, b, c, d;
>> > +  static int a, b, c, d, n;
>> >  
>> >    sig_dispatch_pending ();
>> >    if (check_null_str_errno (name))
>> >      return NULL;
>> >  
>> > -  if (sscanf (name, "%d.%d.%d.%d", &a, &b, &c, &d) == 4)
>> > +  if (sscanf (name, "%d.%d.%d.%d%n", &a, &b, &c, &d, &n) == 4 && (unsigned)n == strlen (name))
>>
>> Thanks for the patch, Brian.  Do you also have a nice ChangeLog entry
>> for me?
>
>I've always done this like below; then the n==strlen(name) check isn't
>needed (since the ==4 verifies that %c wasn't used).  Even using the
>%n, there's no reason to make n static, is there?

There has been no reason to make a, b, c, d static either AFAICT.
This whole function is frightfully non-reentrant, but I knew that.

cgf
