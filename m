Return-Path: <cygwin-patches-return-3697-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1555 invoked by alias); 12 Mar 2003 05:57:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1545 invoked from network); 12 Mar 2003 05:57:12 -0000
Date: Wed, 12 Mar 2003 05:57:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_socket::dup
Message-ID: <20030312055720.GB10425@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3E6DF617.CA7DC2C0@ieee.org> <3.0.5.32.20030310200902.007f3100@mail.attbi.com> <20030311102431.GB13544@cygbert.vinschen.de> <3E6DF617.CA7DC2C0@ieee.org> <3.0.5.32.20030312001525.007f5310@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030312001525.007f5310@incoming.verizon.net>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00346.txt.bz2

On Wed, Mar 12, 2003 at 12:15:25AM -0500, Pierre A. Humblet wrote:
>At 04:20 PM 3/11/2003 +0100, Corinna Vinschen wrote:
>
>>> > I'm seriously concidering to remove all the fixup_before/fixup_after
>>> > from fhandler_socket::dup() and just call fhandler_base::dup() on
>>> > NT systems.
>
>Corinna,
>
>I like that and I have pushed the logic to also do it on Win9X, without
>apparent bad effects. I just delivered 140 e-mails from a WinME to an exim 
>server on Win98, ran inetd, ssh, etc... I also tried duping a socket after a 
>fork, it worked fine.

I think it doesn't work fine on Windows 95, IIRC.

cgf
