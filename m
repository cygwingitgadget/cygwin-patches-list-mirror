Return-Path: <cygwin-patches-return-2544-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30547 invoked by alias); 29 Jun 2002 21:15:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30522 invoked from network); 29 Jun 2002 21:15:37 -0000
Date: Sat, 29 Jun 2002 14:51:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to pass file descriptors
Message-ID: <20020629211541.GA17770@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <06a901c21e92$e3d4ae60$6132bc3e@BABEL> <003601c21e94$064fc780$0200a8c0@lifelesswks> <20020629093616.C1247@cygbert.vinschen.de> <003201c21f49$30ba8900$1800a8c0@LAPTOP> <037501c21f4b$8de441f0$6132bc3e@BABEL> <20020629173324.GA29874@redhat.com> <003e01c21f9a$3f324940$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003e01c21f9a$3f324940$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00527.txt.bz2

On Sat, Jun 29, 2002 at 07:24:45PM +0100, Conrad Scott wrote:
>"Christopher Faylor" <cgf@redhat.com> wrote:
>>The bottom line is that I don't want to have to tell Red Hat's
>>customers to install a server component if they want to use cygwin.  I
>>also don't want to have to tell every person who wants to release a
>>standalone cygwin program that they have to copy around cygwin1.dll and
>>cygserver.exe, finding some way to start cygserver automatically.
>
>Got you: basically customers shouldn't be forced to use the setup
>program but should be able to treat cygwin like any other DLL their
>program might use.  That wasn't a scenario I was considering and it's a
>good point.

Thanks for understanding.

The flip side of this is that cygserver functionality is something that
I've dreamed of adding to cygwin since 1997.  So please don't read the
above as a negation of the concept itself.

cgf
