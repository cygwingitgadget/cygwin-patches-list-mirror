Return-Path: <cygwin-patches-return-4304-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20778 invoked by alias); 16 Oct 2003 13:34:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20754 invoked from network); 16 Oct 2003 13:34:08 -0000
Date: Thu, 16 Oct 2003 13:34:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] *** CreateFileMapping, Win32 error 5.  Terminating.
Message-ID: <20031016133407.GA25076@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20031015222235.00825920@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031015222235.00825920@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00023.txt.bz2

On Wed, Oct 15, 2003 at 10:22:35PM -0400, Pierre A. Humblet wrote:
> 2003-10-15  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* syscalls.cc (seteuid32): Always construct a default DACL including
> 	the new sid, Admins and SYSTEM and copy it to the new thread token.
> 	* security.cc (create_token): Use a NULL default DACL in NtCreateToken.

I assume you have tested it also with an external token, don't you?
I'm a bit concerned that the code also tries to modify the external
token.  Is that actually unavoidable?  Isn't the problem just a
typical problem of a self-created token?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
