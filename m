Return-Path: <cygwin-patches-return-2269-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9372 invoked by alias); 30 May 2002 08:23:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9358 invoked from network); 30 May 2002 08:23:29 -0000
Date: Thu, 30 May 2002 01:23:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Cleanup of ntdll.h
Message-ID: <20020530102327.Z30892@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020530095651.Y30892@cygbert.vinschen.de> <00e901c207b0$9ac7d060$0200a8c0@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e901c207b0$9ac7d060$0200a8c0@lifelesswks>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00252.txt.bz2

On Thu, May 30, 2002 at 06:04:19PM +1000, Robert Collins wrote:
> > [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Corinna Vinschen
> > I changed that now so that all functions are called with Nt prefix.
> 
> This is incorrect. BOTH definitions should exist. NtXXX are kernel mode
> calls, ZwXXX are user mode calls that gate through to kernel mode calls
> via int 2eh.

Nope.  From user mode both call types are identical.  There's no need
to use both forms in Cygwin and since the header is only used inside
of Cygwin there's also no need to define both variations.  One is enough.
It's all one to me if it's the Zw or Nt version but we should at least
use always the same.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
