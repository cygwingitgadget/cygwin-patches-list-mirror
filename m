Return-Path: <cygwin-patches-return-2590-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17759 invoked by alias); 3 Jul 2002 12:54:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17679 invoked from network); 3 Jul 2002 12:54:21 -0000
Date: Wed, 03 Jul 2002 05:54:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to pass file descriptors
Message-ID: <20020703145419.A21857@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.30L.0207021305230.31764-100000@w20-575-40.mit.edu> <005601c22280$e9e4f610$c9823bd5@dmitry> <20020703134115.V21857@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020703134115.V21857@cygbert.vinschen.de>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00038.txt.bz2

On Wed, Jul 03, 2002 at 01:41:15PM +0200, cygpatch wrote:
> On Wed, Jul 03, 2002 at 07:59:59PM +0900, Dmitry Timoshkov wrote:
> > Hello all.
> > 
> > Why not implement passing file descriptors in the following way:
> > 
> > Somewhere in the structure passed to sendmsg send a handle of
> > the calling process created with
> > OpenProcess(PROCESS_DUP_HANDLE, FALSE, GetCurrentProcessId());
> > OpenProcess will always succed, since the caller is current process.
> > 
> > recvmsg implementation will just use that process handle
> > for the DuplicateHandle call.
> 
> recvmsg is in another process.  The open handle is only valid in
> the source process.  It would have to be duplicated for the receiving
> process using DuplicateHandle(src, target) which only works if
> the duplicating process has already PROCESS_DUP_HANDLE access on
> the other process.  Therefore the Cygwin internal descriptor
> passing code only works if one of the processes is a privileged
> process (being member of the admins group is sufficient here).

Btw., descriptor passing works w/o cygserver also if both
processes are running under the same unprivileged account.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
