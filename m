Return-Path: <cygwin-patches-return-4284-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31801 invoked by alias); 7 Oct 2003 18:25:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31778 invoked from network); 7 Oct 2003 18:24:59 -0000
Message-ID: <3F8304F5.B0E47BC1@phumblet.no-ip.org>
Date: Tue, 07 Oct 2003 18:25:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: shared.cc debug info.
References: <3.0.5.32.20031006212612.008203b0@incoming.verizon.net> <20031007021858.GA10077@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00003.txt.bz2

Christopher Faylor wrote:
> 
> On Mon, Oct 06, 2003 at 09:26:12PM -0400, Pierre A. Humblet wrote:
> >Here is a pretty simple patch..
> 
> Ok to include.
> 
> >BTW, are there more questions about "[Patch]: Fixing the PROCESS_DUP_HANDLE
> >security  hole (part 1)." from last week?
> 
> Yes, actually.  I am still puzzling over all of the extra logic that you
> pass in cygheap.  I don't understand the need for special handling of
> children of the process that owns the controlling tty.

A typical sequence is as follows (e.g. telnet)
1) inetd runs as SYSTEM, launches in.telnetd
2) in.telnetd creates master pty and forks
3) in.telnetd (child) setsid(), opens slave terminal and execs login.exe
4) login.exe calls setuid and execs bash.exe
5) bash.exe opens /dev/tty
  Unfortunately this requires duplicating pipes from in.telnetd and thus
  having PROCESS_DUP_HANDLE access to in.telnetd.
  As in.telnetd runs as SYSTEM, this is a security risk.

What the patch does is that when the slave side is first opened in
3), the pipes are duplicated in the cygheap and passed by inheritance
(until the ctty changes). There is no access/security issue because
3) is running as SYSTEM.

From now on, each time the ctty is opened (in particular in 5) the patch 
first checks if local inherited copies of the pipes are available. 
If so, they are used as the source of the duplication. 
This obviates the need for bash to have any access to in.telnetd and 
thus in.telnetd doesn't need to open itself wide to everybody (in 2).

Pierre
