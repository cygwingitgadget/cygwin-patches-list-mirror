Return-Path: <cygwin-patches-return-3700-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22773 invoked by alias); 12 Mar 2003 14:37:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22764 invoked from network); 12 Mar 2003 14:37:15 -0000
Message-ID: <3E6F46C5.3691F045@ieee.org>
Date: Wed, 12 Mar 2003 14:37:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: fhandler_socket::dup
References: <3E6DF617.CA7DC2C0@ieee.org> <3.0.5.32.20030310200902.007f3100@mail.attbi.com> <20030311102431.GB13544@cygbert.vinschen.de> <3E6DF617.CA7DC2C0@ieee.org> <3.0.5.32.20030312001525.007f5310@incoming.verizon.net> <20030312055720.GB10425@redhat.com> <20030312085227.GL13544@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00349.txt.bz2

Corinna Vinschen wrote:
> 
> On Wed, Mar 12, 2003 at 12:57:20AM -0500, Christopher Faylor wrote:
> > On Wed, Mar 12, 2003 at 12:15:25AM -0500, Pierre A. Humblet wrote:
> > >At 04:20 PM 3/11/2003 +0100, Corinna Vinschen wrote:
> > >
> > >>> > I'm seriously concidering to remove all the fixup_before/fixup_after
> > >>> > from fhandler_socket::dup() and just call fhandler_base::dup() on
> > >>> > NT systems.
> > >
> > >Corinna,
> > >
> > >I like that and I have pushed the logic to also do it on Win9X, without
> > >apparent bad effects. I just delivered 140 e-mails from a WinME to an exim
> > >server on Win98, ran inetd, ssh, etc... I also tried duping a socket after a
> > >fork, it worked fine.
> >
> > I think it doesn't work fine on Windows 95, IIRC.
> 
> I search email archives and MSDN again and it is possible that I used
> the same fixup_before/fixup_after technique in dup for... well, symmetry.
> All errors mentioned in KB on sockets are actually related to sockets
> duplicated between processes.  Win95 wasn't related, AFAIR, since it
> didn't even have WinSock2 installed by default.

Corinna, 

I agree 100% with your assessment above.
I don't see any indication that there is any more danger to use 
DuplicateHandle with WinSock2 on Win9X than on NT.
Cygwin strives to use uniform mechanisms on all platforms, so why not here,
if only to keep the code simple and straightforward, and more maintainable?
Any modification involves some risk, and that's why we test as much as 
we can.

Pierre
