Return-Path: <cygwin-patches-return-4134-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13184 invoked by alias); 20 Aug 2003 20:23:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13170 invoked from network); 20 Aug 2003 20:23:36 -0000
Message-ID: <3F43D3A7.C6AFAADC@phumblet.no-ip.org>
Date: Wed, 20 Aug 2003 20:23:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
References: <20030819024617.GA6581@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F43B482.AC7F68F4@phumblet.no-ip.org> <20030820180919.GB26273@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00150.txt.bz2

Christopher Faylor wrote:
> 

> >While looking at the code, I got worried by interrupt_setup().  As soon
> >as sigsave.sig = sig; is executed, the sigsave can be picked up by a
> >terminating handler.  Thus shouldn't sigsave.sig = sig; be the last
> >statement in interrupt_setup() to avoid a race condition?
> 
> Yes, it's a race but I think it's harmless since, AFAICT, the only thing
> affected is errno which wouldn't be handled in a recursive signal call.
> I'll move the setting to the end of interrupt_setup, though.

OK. 
There is also the SetEvent (signal_arrived) that must be done before
it's reset in the handler.

Pierre
