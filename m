Return-Path: <cygwin-patches-return-4306-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26401 invoked by alias); 16 Oct 2003 15:48:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26391 invoked from network); 16 Oct 2003 15:48:06 -0000
Message-ID: <3F8EBDA7.F6E69A30@phumblet.no-ip.org>
Date: Thu, 16 Oct 2003 15:48:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [Patch] *** CreateFileMapping, Win32 error 5.  Terminating.
References: <3.0.5.32.20031015222235.00825920@incoming.verizon.net> <20031016133407.GA25076@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00025.txt.bz2

Corinna Vinschen wrote:
> 
> On Wed, Oct 15, 2003 at 10:22:35PM -0400, Pierre A. Humblet wrote:
> > 2003-10-15  Pierre Humblet  <pierre.humblet@ieee.org>
> >
> >       * syscalls.cc (seteuid32): Always construct a default DACL including
> >       the new sid, Admins and SYSTEM and copy it to the new thread token.
> >       * security.cc (create_token): Use a NULL default DACL in NtCreateToken.
> 
> I assume you have tested it also with an external token, don't you?
> I'm a bit concerned that the code also tries to modify the external
> token.  Is that actually unavoidable?  Isn't the problem just a
> typical problem of a self-created token?
 
Yes it has been tested with an external token. We already touch the owner
and primary group of the external tokens, the dacl is just another item.

It's needed with external tokens to handle the following type of cases.
A user in the admins group telnets into the box, creating a file
mapping with access by admins and system, but not by his sid (without the
patch).
While he is logged in, some service (exim, proftp...) creates a 
setgroups(0, NULL) + seteuid() process. That process may not be able
the access the file mapping (without the patch).

Pierre
