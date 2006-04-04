Return-Path: <cygwin-patches-return-5812-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13527 invoked by alias); 4 Apr 2006 23:04:37 -0000
Received: (qmail 13517 invoked by uid 22791); 4 Apr 2006 23:04:37 -0000
X-Spam-Check-By: sourceware.org
Received: from web31508.mail.mud.yahoo.com (HELO web31508.mail.mud.yahoo.com) (68.142.198.137)     by sourceware.org (qpsmtpd/0.31) with SMTP; Tue, 04 Apr 2006 23:04:36 +0000
Received: (qmail 71771 invoked by uid 60001); 4 Apr 2006 23:04:35 -0000
Message-ID: <20060404230435.71769.qmail@web31508.mail.mud.yahoo.com>
Received: from [143.106.22.88] by web31508.mail.mud.yahoo.com via HTTP; Tue, 04 Apr 2006 20:04:35 ART
Date: Tue, 04 Apr 2006 23:04:00 -0000
From: Mauro Canova Zaccarias <maurocz@yahoo.com.br>
Subject: Patch to pass file descriptors
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00000.txt.bz2

   Hi folks,

   Have you found any solution for the problem of passing descriptors on
cygwin? How did this discussion end up?

   Many thanks,
   Mauro Zaccarias




-------------------------------
Re: Patch to pass file descriptors

    * From: Corinna Vinschen <cygwin-patches at cygwin dot com>
    * To: cygwin-patches at cygwin dot com
    * Date: Wed, 3 Jul 2002 13:41:15 +0200
    * Subject: Re: Patch to pass file descriptors
    * References:
<Pine.LNX.4.30L.0207021305230.31764-100000@w20-575-40.mit.edu>
<005601c22280$e9e4f610$c9823bd5@dmitry>

On Wed, Jul 03, 2002 at 07:59:59PM +0900, Dmitry Timoshkov wrote:
> Hello all.
> 
> Why not implement passing file descriptors in the following way:
> 
> Somewhere in the structure passed to sendmsg send a handle of
> the calling process created with
> OpenProcess(PROCESS_DUP_HANDLE, FALSE, GetCurrentProcessId());
> OpenProcess will always succed, since the caller is current process.
> 
> recvmsg implementation will just use that process handle
> for the DuplicateHandle call.

recvmsg is in another process.  The open handle is only valid in
the source process.  It would have to be duplicated for the receiving
process using DuplicateHandle(src, target) which only works if
the duplicating process has already PROCESS_DUP_HANDLE access on
the other process.  Therefore the Cygwin internal descriptor
passing code only works if one of the processes is a privileged
process (being member of the admins group is sufficient here).

That means basically, if one needs to pass descriptors between
two non-privileged processes, it still requires a cygserver solution.

For the records:

Please keep in mind that I'm *not* against a cygserver solution.
It's just that I'm still trying to get as much functionality done
in the DLL itself w/o needing the cygserver.  The cygserver should
be only the resort for functionality which can't get implemented
with just the dll.  It's not the panacea to implement every new
functionality w/o having to think about a stand-alone solution.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
----------------------------------


		
_______________________________________________________ 
Abra sua conta no Yahoo! Mail: 1GB de espaço, alertas de e-mail no celular e anti-spam realmente eficaz. 
http://br.info.mail.yahoo.com/
