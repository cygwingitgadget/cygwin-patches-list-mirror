Return-Path: <cygwin-patches-return-5316-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8969 invoked by alias); 25 Jan 2005 20:59:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8939 invoked from network); 25 Jan 2005 20:59:00 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 25 Jan 2005 20:59:00 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 0D2601B522; Tue, 25 Jan 2005 15:59:23 -0500 (EST)
Date: Tue, 25 Jan 2005 20:59:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: setting errno to ENOTDIR rather than ENOENT
Message-ID: <20050125205922.GA10380@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <41F6B1F6.5207C318@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6B1F6.5207C318@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2005-q1/txt/msg00019.txt.bz2

On Tue, Jan 25, 2005 at 03:54:14PM -0500, Pierre A. Humblet wrote:
>This patch should take care of the error reported by 
>Eric Blake on the list, at least for disk files.
>
>It also removes code under the condition
>(opt & PC_SYM_IGNORE) && pcheck_case == PCHECK_RELAXED
>which is never true, AFAICS.
>
>It also gets rid of an obsolete function.
>
>While testing, the assert (!i); on line 259 of pinfo.cc kicks in.
>That's a feature because when flag & PID_EXECED the code just loops,
>keeping the same h0 and mapname! Am I the only one to see that?

No.  Corinna is seeing it too.  I have a fix in my sandbox but I've been
too busy to test it properly before I check it in.

Feel free to nuke the digits stuff.  Corinna will have to give her
blessings to the rest since she's the one who researched this most
recently.

cgf
