Return-Path: <cygwin-patches-return-2515-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4441 invoked by alias); 25 Jun 2002 14:20:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4425 invoked from network); 25 Jun 2002 14:20:15 -0000
Date: Tue, 25 Jun 2002 11:57:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: uinfo.cc
Message-ID: <20020625142014.GD10468@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020624194543.00802da0@mail.attbi.com> <20020625092131.A18883@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020625092131.A18883@cygbert.vinschen.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00498.txt.bz2

On Tue, Jun 25, 2002 at 09:21:31AM +0200, Corinna Vinschen wrote:
>On Mon, Jun 24, 2002 at 07:45:43PM -0400, Pierre A. Humblet wrote:
>> Looks like I had introduced a bug. A child had the wrong 
>> uid/gid (but the right token), following setEuid(). This fixes it. 
>> Sorry about that.
>
>I already fixed it yesterday.
>
>Thanks anyway,

Doh.  I thought the patch looked familiar.  That's probably why I was
so certain that it looked ok.  :-)

cgf
